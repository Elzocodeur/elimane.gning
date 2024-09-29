<?php

namespace App\Http\Controllers;

use App\Services\ReferencielService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Validator;
use App\Http\Requests\StoreReferencielRequest;
use Illuminate\Support\Facades\Log;


class ReferencielController extends Controller
{
    protected $referencielService;

    public function __construct(ReferencielService $referencielService)
    {
        $this->referencielService = $referencielService;
    }

    public function store(StoreReferencielRequest $request): JsonResponse
    {
        $data = $request->only(['libelle', 'description', 'code', 'statut']);
        $photo = $request->file('photo');
        $competences = $request->input('competences');

        if (is_string($competences)) {
            $competences = json_decode($competences, true);
        }

        $data['competences'] = $competences;

        // Vérifier l'unicité du code et du libelle
        $validationErrors = $this->referencielService->validateUniqueFields($data);

        if (!empty($validationErrors)) {
            return response()->json(['errors' => $validationErrors], 422); // Unprocessable Entity
        }

        try {
            // Créer le référentiel avec la photo
            $referenciel = $this->referencielService->createReferencielWithPhoto($data, $photo);
            return response()->json($referenciel, 201);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function index(Request $request): JsonResponse
    {
        Log::info('Authorization Header: ' . $request->header('Authorization'));
        if ($request->has('statut') && $request->input('statut') === 'Actif') {
            // Filtrer les référentiels actifs
            $referenciels = $this->referencielService->getActiveReferenciels();
        } else {
            // Récupérer tous les référentiels
            $referenciels = $this->referencielService->getAllReferenciels();
        }

        return response()->json($referenciels, 200);
    }



    // PATCH: Update referenciel and manage competences and modules
    public function update($id, Request $request): JsonResponse
    {
        try {
            $data = $request->only(['libelle', 'description', 'code', 'statut']);
            $referenciel = $this->referencielService->updateReferenciel($id, $data);
            return response()->json($referenciel, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    // POST: Add a new competence to the referenciel
    public function addCompetence($id, Request $request): JsonResponse
    {
        try {
            // Valide les données avant d'ajouter la compétence
            $competence = $request->input('competence');

            // Vérifie si la compétence n'est pas vide ou incorrecte
            if (is_null($competence) || !is_array($competence)) {
                return response()->json(['error' => 'Les données de la compétence sont invalides.'], 400);
            }

            // Ajouter la compétence au référentiel via le service
            $referenciel = $this->referencielService->addCompetenceToReferenciel($id, $competence);

            return response()->json($referenciel, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    // POST: Add a module to a competence in the referenciel
    public function addModule($id, $competenceId, Request $request): JsonResponse
    {
        try {
            // Récupérer les données du module
            $module = $request->input('module');

            // Valider que les données du module sont bien fournies et sous forme de tableau
            if (is_null($module) || !is_array($module)) {
                return response()->json(['error' => 'Les données du module sont invalides.'], 400);
            }

            // Ajouter le module à la compétence via le service
            $referenciel = $this->referencielService->addModuleToCompetence($id, $competenceId, $module);

            return response()->json($referenciel, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }


    // DELETE: Remove a competence from the referenciel (soft delete)
    public function removeCompetence($id, $competenceId): JsonResponse
    {
        try {
            // Appeler le service pour supprimer la compétence
            $referenciel = $this->referencielService->removeCompetenceFromReferenciel($id, $competenceId);

            // Retourner le référentiel mis à jour
            return response()->json($referenciel, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    // DELETE: Remove a module from a competence in the referenciel
    public function removeModule($id, $competenceId, $moduleId): JsonResponse
    {
        try {
            // Appeler le service pour supprimer le module d'une compétence
            $referenciel = $this->referencielService->removeModuleFromCompetence($id, $competenceId, $moduleId);

            // Retourner la réponse avec le référentiel mis à jour
            return response()->json($referenciel, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }


    // DELETE: Soft delete d'un référentiel
    public function softDelete($id): JsonResponse
    {
        try {
            $this->referencielService->softDeleteReferenciel($id);
            return response()->json(['message' => 'Référentiel supprimé avec succès'], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    // GET: Récupérer les référentiels supprimés
    public function listDeleted(): JsonResponse
    {
        try {
            $deletedReferenciels = $this->referencielService->getDeletedReferenciels();
            return response()->json($deletedReferenciels, 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
}
