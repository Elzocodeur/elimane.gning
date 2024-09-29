<?php

namespace App\Services;

use App\Repositories\RepositoryReferenciel;
use Illuminate\Support\Facades\Storage;

class ReferencielService
{
    protected $repositoryReferenciel;

    public function __construct(RepositoryReferenciel $repositoryReferenciel)
    {
        $this->repositoryReferenciel = $repositoryReferenciel;
    }


    // Valider l'unicité du code et libelle avant la création
    public function validateUniqueFields(array $data)
    {
        $errors = [];

        if ($this->repositoryReferenciel->checkIfExists('code', $data['code'])) {
            $errors['code'] = 'Le code existe déjà.';
        }

        if ($this->repositoryReferenciel->checkIfExists('libelle', $data['libelle'])) {
            $errors['libelle'] = 'Le libellé existe déjà.';
        }

        return $errors;
    }


    public function createReferencielWithPhoto(array $data, $photo)
    {
        // Récupérer le bucket Firebase Storage
        $bucket = app('firebase.storage')->getBucket(); // Utilise le bucket par défaut de Firebase Storage

        // Générer un nom unique pour la photo
        $fileName = 'referentiels/' . uniqid() . '/' . $photo->getClientOriginalName();

        // Uploader la photo dans Firebase Storage
        $bucket->upload(
            file_get_contents($photo->getRealPath()),
            [
                'name' => $fileName,
            ]
        );

        // Récupérer le lien public de la photo
        $photoUrl = $bucket->object($fileName)->signedUrl(new \DateTime('+1 year'));

        // Ajouter le lien de la photo dans les données
        $data['photoUrl'] = $photoUrl;

        // Créer le référentiel dans Firebase via le repository
        return $this->repositoryReferenciel->createReferenciel($data);
    }

    // Récupérer tous les référentiels
    public function getAllReferenciels()
    {
        return $this->repositoryReferenciel->getAllReferenciels();
    }

    // Récupérer les référentiels actifs
    public function getActiveReferenciels()
    {
        return $this->repositoryReferenciel->getActiveReferenciels();
    }



    // Mise à jour d'un référentiel
    public function updateReferenciel($id, array $data)
    {
        // Mise à jour des informations du référentiel
        return $this->repositoryReferenciel->updateReferenciel($id, $data);
    }


    // Suppression d'un module d'une compétence
    public function deleteModuleFromCompetence($referencielId, $competenceId, $moduleId)
    {
        $referenciel = $this->repositoryReferenciel->findById($referencielId);

        // Trouver la compétence et supprimer le module
        foreach ($referenciel['competences'] as &$competence) {
            if ($competence['id'] == $competenceId) {
                foreach ($competence['modules'] as &$module) {
                    if ($module['id'] == $moduleId) {
                        $module['deleted_at'] = now(); // Soft delete pour le module
                    }
                }
            }
        }

        return $this->repositoryReferenciel->updateReferenciel($referencielId, $referenciel);
    }

    public function addCompetenceToReferenciel($referencielId, array $competence)
    {
        // Récupérer le référentiel par son ID
        $referenciel = $this->repositoryReferenciel->getReferencielById($referencielId);

        // Ajouter la compétence au référentiel
        if (!isset($referenciel['competences'])) {
            $referenciel['competences'] = [];
        }

        // Ajoute la compétence à la liste des compétences
        $referenciel['competences'][] = $competence;

        // Mettre à jour le référentiel
        return $this->repositoryReferenciel->updateReferenciel($referencielId, $referenciel);
    }




    // Méthode pour ajouter un module à une compétence spécifique dans un référentiel
    public function addModuleToCompetence($referencielId, $competenceId, array $module)
    {
        // Récupérer le référentiel par ID
        $referenciel = $this->repositoryReferenciel->getReferencielById($referencielId);

        // Vérifier que les compétences existent dans le référentiel
        if (!isset($referenciel['competences'][$competenceId])) {
            throw new \Exception("Compétence introuvable");
        }

        // Ajouter le module à la compétence
        if (!isset($referenciel['competences'][$competenceId]['modules'])) {
            $referenciel['competences'][$competenceId]['modules'] = [];
        }

        // Ajouter le nouveau module à la liste des modules
        $referenciel['competences'][$competenceId]['modules'][] = $module;

        // Mettre à jour le référentiel avec la nouvelle structure
        return $this->repositoryReferenciel->updateReferenciel($referencielId, $referenciel);
    }

    // Méthode pour retirer une compétence d'un référentiel (soft delete)
    public function removeCompetenceFromReferenciel($referencielId, $competenceId)
    {
        // Récupérer le référentiel par son ID
        $referenciel = $this->repositoryReferenciel->getReferencielById($referencielId);

        // Vérifier que la compétence existe
        if (!isset($referenciel['competences'][$competenceId])) {
            throw new \Exception("Compétence introuvable");
        }

        // Effectuer un soft delete (désactivation ou marquage)
        $referenciel['competences'][$competenceId]['deleted_at'] = now();

        // Mettre à jour le référentiel
        return $this->repositoryReferenciel->updateReferenciel($referencielId, $referenciel);
    }


    // Méthode pour retirer un module d'une compétence
    public function removeModuleFromCompetence($referencielId, $competenceId, $moduleId)
    {
        // Récupérer le référentiel
        $referenciel = $this->repositoryReferenciel->getReferencielById($referencielId);

        // Vérifier que la compétence existe dans le référentiel
        if (!isset($referenciel['competences'][$competenceId])) {
            throw new \Exception("Compétence introuvable");
        }

        // Vérifier que le module existe dans la compétence
        if (!isset($referenciel['competences'][$competenceId]['modules'][$moduleId])) {
            throw new \Exception("Module introuvable");
        }

        // Effectuer un soft delete (ajouter une clé 'deleted_at' au module)
        $referenciel['competences'][$competenceId]['modules'][$moduleId]['deleted_at'] = now();

        // Mettre à jour le référentiel dans le repository
        return $this->repositoryReferenciel->updateReferenciel($referencielId, $referenciel);
    }



        // Service pour faire un soft delete
        public function softDeleteReferenciel($referencielId)
        {
            return $this->repositoryReferenciel->softDeleteReferenciel($referencielId);
        }

        // Service pour récupérer les référentiels supprimés
        public function getDeletedReferenciels()
        {
            return $this->repositoryReferenciel->getDeletedReferenciels();
        }
}
