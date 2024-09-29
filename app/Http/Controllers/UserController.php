<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreUserRequest;
use App\Models\User;
use App\Models\Role;
use App\Repositories\Interfaces\UserRepositoryInterface;
use App\Services\FirebaseService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class UserController extends Controller
{
    protected $firebaseService;
    protected $userRepository;

    public function __construct(FirebaseService $firebaseService, UserRepositoryInterface $userRepository)
    {
        $this->firebaseService = $firebaseService;
        $this->userRepository = $userRepository;
    }

    public function register(StoreUserRequest $request): JsonResponse
{
    $data = $request->validated();
    $photo = $request->file('photo'); // Récupérer la photo

    // Chercher le rôle de l'utilisateur à créer
    $role = Role::find($data['role_id']);
    $targetUser = new User(['role_id' => $role->id]);

    // Autorisation basée sur la policy
    $this->authorize('create', $targetUser);

    try {
        // Créer l'utilisateur dans Firebase et obtenir le lien de la photo
        $result = $this->firebaseService->createFirebaseUser($data, $photo);
        $firebaseUser = $result['user'];
        $photoUrl = $result['photoUrl']; // Lien de la photo

        // Stocker l'utilisateur localement
        $data['photo'] = $photoUrl; // Stocker le lien de la photo dans la DB locale
        $user = $this->firebaseService->storeUserLocally($data);

        return response()->json([
            'message' => 'User registered successfully',
            'firebase_user' => $firebaseUser,
            'local_user' => $user,
        ], 201);
    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 500);
    }
}

        // Lister les utilisateurs avec filtre par rôle
        public function index(Request $request)
        {
            $role = $request->query('role'); // Récupérer le paramètre de rôle
            $users = $this->userRepository->getAllUsers($role);
            return response()->json($users);
        }

        // Modifier un utilisateur
        public function update(Request $request, $id)
        {
            $this->userRepository->update($id, $request->all());
            return response()->json(['message' => 'Utilisateur mis à jour avec succès.']);
        }

}
