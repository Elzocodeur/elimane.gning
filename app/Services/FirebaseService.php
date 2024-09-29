<?php


namespace App\Services;

use Kreait\Firebase\Factory;
use Kreait\Firebase\Auth;
use Illuminate\Support\Facades\Storage;
use App\Repositories\Interfaces\UserRepositoryInterface;
use Illuminate\Support\Facades\Hash;

class FirebaseService
{
    protected $auth;
    protected $database;
    protected $storage;
    protected $userRepository;

    public function __construct(UserRepositoryInterface $userRepository)
    {
        $factory = (new Factory)
            ->withServiceAccount(config('services.firebase.credentials'))   
            // dd(config('services.firebase.credentials'))
            ->withDatabaseUri(config('services.firebase.database_url')); // Pas besoin de withStorageBucket()


        $this->auth = $factory->createAuth();
        $this->database = $factory->createDatabase();
        $this->storage = $factory->createStorage(); // Création de l'instance de Storage
        $this->userRepository = $userRepository;
    }

    public function createFirebaseUser(array $data, $photo)
    {
        // Créer l'utilisateur dans Firebase Authentication
        $firebaseUser = $this->auth->createUserWithEmailAndPassword($data['email'], $data['password']);
        $firebaseUid = $firebaseUser->uid;

        // Stocker la photo dans Firebase Storage et obtenir le lien
        $photoPath = $this->uploadPhotoToFirebaseStorage($photo, $firebaseUid);

        // Stocker les informations dans la Realtime Database
        $this->database->getReference('users/' . $firebaseUid)->set([
            'nom' => $data['nom'],
            'prenom' => $data['prenom'],
            'adresse' => $data['adresse'],
            'telephone' => $data['telephone'],
            'fonction' => $data['fonction'],
            'statut' => $data['statut'],
            'role_id' => $data['role_id'],
            'email' => $data['email'],
            'photo' => $photoPath, // Lien de la photo dans Firebase Storage
            'password' => Hash::make($data['password']),
        ]);

        // Stocker les informations localement, y compris le lien de la photo
        $localUserData = array_merge($data, ['photo' => $photoPath]);
        $this->storeUserLocally($localUserData);

        return [
            'user' => $firebaseUser,
            'photoUrl' => $photoPath, // Retourner le lien de la photo
        ];
    }


    public function uploadPhotoToFirebaseStorage($photo, $firebaseUid)
    {
        // Récupérer le bucket Firebase Storage
        $bucket = $this->storage->getBucket(); // Récupère le bucket par défaut

        $fileName = 'users/' . $firebaseUid . '/' . $photo->getClientOriginalName();

        // Uploader le fichier dans Firebase Storage
        $bucket->upload(
            file_get_contents($photo->getRealPath()),
            [
                'name' => $fileName,
            ]
        );

        // Récupérer le lien public de l'image
        $photoUrl = $bucket->object($fileName)->signedUrl(new \DateTime('+1 year'));

        return $photoUrl;
    }

    // public function storeUserLocally(array $data)
    // {
    //     // Utiliser le repository pour stocker l'utilisateur localement
    //     return $this->userRepository->create($data);
    // }


    public function storeUserLocally(array $data)
    {
        // Vérifier si un utilisateur avec le même email existe déjà
        $existingUser = $this->userRepository->findByEmail($data['email']);

        if ($existingUser) {
            // Si l'utilisateur existe déjà, tu peux soit retourner un message d'erreur
            // ou mettre à jour les informations existantes
            return [
                'error' => 'Cet email est déjà utilisé par un autre utilisateur.',
            ];
        }

        // Si l'utilisateur n'existe pas, enregistrer les nouvelles informations
        return $this->userRepository->create($data);
    }


}
