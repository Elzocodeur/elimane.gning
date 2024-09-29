<?php

namespace App\Services;

use App\Repositories\ApprenantRepository;
use Illuminate\Support\Str;
use BaconQrCode\Writer;
use BaconQrCode\Renderer\ImageRenderer;
use BaconQrCode\Renderer\RendererStyle\RendererStyle;
use BaconQrCode\Renderer\Image\SvgImageBackEnd;
use Illuminate\Support\Facades\Validator;
use App\Jobs\SendMailJob;

class ApprenantService
{
    protected $apprenantRepository;

    public function __construct(ApprenantRepository $apprenantRepository)
    {
        $this->apprenantRepository = $apprenantRepository;
    }

    public function inscrireApprenant(array $data)
    {
        // Validation avec Firebase, par exemple via Validator si Firebase valide les données côté client
        $validator = Validator::make($data, [
            'nom' => 'required|string',
            'prenom' => 'required|string',
            'adresse' => 'required|string',
            'telephone' => 'required|string',
            'email' => 'required|email',
            'photo' => 'required|string', // Si base64
            'referentiel_id' => 'required|string',
            'tuteur.nom' => 'required|string',
            'tuteur.telephone' => 'required|string',
            'documents.carte_identite' => 'required|string',
            'documents.diplome' => 'required|string',
            'documents.visite_medicale' => 'required|string',
            'documents.extrait_naissance' => 'required|string',
            'documents.casier_judiciaire' => 'required|string',
        ]);

        if ($validator->fails()) {
            throw new \Exception($validator->errors()->first());
        }

        // Génération du matricule
        $data['matricule'] = 'APP-' . Str::upper(Str::random(8));

        // Génération du QR code
        $qrCodePath = $this->generateQrCode($data);
        $data['qr_code'] = $qrCodePath;

        // Créer l'apprenant en base de données via le repository
        $apprenant = $this->apprenantRepository->createApprenant($data);

        // Envoi de l'email d'inscription
        // $this->envoyerMailInscription($apprenant);
        $this->envoyerMailInscription($apprenant, $qrCodePath);

        return $apprenant;
    }

    // protected function generateQrCode($data)
    // {
    //     // Vérifier si le répertoire des QR codes existe, sinon le créer
    //     $qrCodeDir = storage_path('app/qrcodes');
    //     if (!file_exists($qrCodeDir)) {
    //         mkdir($qrCodeDir, 0777, true);
    //     }

    //     // Générer le QR code
    //     $renderer = new ImageRenderer(new RendererStyle(400), new SvgImageBackEnd());
    //     $writer = new Writer($renderer);

    //     $qrCodeData = json_encode($data);
    //     $qrCodePath = 'qrcodes/' . $data['matricule'] . '.png';

    //     // Sauvegarder le QR code dans le répertoire créé
    //     $writer->writeFile($qrCodeData, storage_path('app/' . $qrCodePath));

    //     return $qrCodePath;
    // }

    // protected function envoyerMailInscription($apprenant)
    // {
    //     $mailData = [
    //         'email' => $apprenant['email'],
    //         'login' => $apprenant['email'],
    //         'password' => 'Passer@123', // Générer mot de passe
    //         'lien_auth' => route('login'),
    //     ];

    //     // Envoi de l'email via un Job
    //     SendMailJob::dispatch($mailData);
    // }

    protected function generateQrCode($data)
    {
        // Génération du QR code
        $qrCodeDir = storage_path('app/qrcodes');
        if (!file_exists($qrCodeDir)) {
            mkdir($qrCodeDir, 0777, true);
        }

        $renderer = new ImageRenderer(new RendererStyle(400), new SvgImageBackEnd());
        $writer = new Writer($renderer);

        $qrCodeData = json_encode($data);
        $qrCodePath = 'qrcodes/' . $data['matricule'] . '.png';
        $writer->writeFile($qrCodeData, storage_path('app/' . $qrCodePath));

        return $qrCodePath;
    }

    protected function envoyerMailInscription($apprenant, $qrCodePath)
    {
        $mailData = [
            'email' => $apprenant['email'],
            'login' => $apprenant['email'],
            'password' => 'Passer@123', // Générer mot de passe
            'lien_auth' => route('login'),
            'qr_code' => storage_path('app/' . $qrCodePath), // Attach QR code path
        ];

        // Envoi de l'email via un Job
        SendMailJob::dispatch($mailData);
    }
}
