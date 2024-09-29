<?php

// namespace App\Repositories;

// use App\Facades\Referenciel;

// class RepositoryReferenciel
// {
//     public function createReferenciel(array $data)
//     {
//         return Referenciel::create($data);

//     }


//     public function getAllReferenciels()
//     {
//         return Referenciel::all();
//     }

//     public function findReferencielById(string $id)
//     {
//         return Referenciel::find($id);
//     }

//     public function updateReferenciel(string $id, array $data)
//     {
//         return Referenciel::update($id, $data);
//     }

//     public function deleteReferenciel(string $id)
//     {
//         return Referenciel::delete($id);
//     }
// }



namespace App\Repositories;

use App\Models\ReferencielFirebaseModel;

class RepositoryReferenciel
{
    protected $referencielModel;

    public function __construct(ReferencielFirebaseModel $referencielModel)
    {
        $this->referencielModel = $referencielModel;
    }

    public function createReferenciel(array $data)
    {
        return $this->referencielModel->create($data);
    }

    public function getAllReferenciels()
    {
        return $this->referencielModel->all();

    }

    public function updateReferenciel(string $id, array $data)
    {
        return $this->referencielModel->update($id, $data);
    }

    public function deleteReferenciel(string $id)
    {
        return $this->referencielModel->delete($id);
    }

// Récupérer les référentiels actifs
    public function getActiveReferenciels()
    {
        // Récupérer tous les référentiels et filtrer ceux qui ont le statut "Actif"
        return collect($this->referencielModel->all())
            ->filter(function ($referenciel) {
                return $referenciel['statut'] === 'Actif';
            });
    }

        // Méthode pour vérifier si un référentiel avec un code ou libelle existe
        public function checkIfExists(string $field, string $value)
        {
            return collect($this->referencielModel->all())
                ->firstWhere($field, $value);
        }


        public function findById(string $id)
        {
            // Récupérer un référentiel par son ID
            return $this->referencielModel->find($id);
        }




        public function getReferencielById($id)
        {
            return $this->referencielModel->find($id);
        }


   // Soft delete: Ajout du champ deleted_at sans supprimer réellement
   public function softDeleteReferenciel(string $id)
   {
       $referenciel = $this->referencielModel->find($id); // Utilise la méthode 'find' pour récupérer le référentiel

       if (!$referenciel) {
           throw new \Exception("Référentiel introuvable");
       }

       // Marquer le référentiel comme supprimé en ajoutant la date de suppression
       $referenciel['deleted_at'] = now()->toDateTimeString();
       return $this->referencielModel->update($id, $referenciel);
   }

   // Récupérer tous les référentiels supprimés
   public function getDeletedReferenciels()
   {
       $referenciels = $this->referencielModel->all(); // Récupérer tous les documents avec la méthode 'all'

       // Filtrer les documents avec le champ 'deleted_at' défini
       return array_filter($referenciels, function ($referenciel) {
           return isset($referenciel['deleted_at']);
       });
   }
}
