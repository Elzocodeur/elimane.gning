<?php

namespace App\Services;

use App\Repositories\PromotionRepository;
use Carbon\Carbon;
use Exception;

class PromotionService
{
    protected $promotionRepository;

    public function __construct(PromotionRepository $promotionRepository)
    {
        $this->promotionRepository = $promotionRepository;
    }

    public function createPromotion(array $data)
    {
        // Validation des données
        if (empty($data['libelle']) || empty($data['date_debut'])) {
            throw new Exception("Libellé et date de début sont obligatoires.");
        }

        // Vérifier si le libellé est unique dans Firebase
        $promotions = $this->promotionRepository->getAllPromotions();
        foreach ($promotions as $promotion) {
            if ($promotion['libelle'] === $data['libelle']) {
                throw new Exception("Le libellé de la promotion doit être unique.");
            }
        }

        // Calcul de la durée ou de la date de fin si nécessaire
        if (!empty($data['duree'])) {
            $data['date_fin'] = Carbon::parse($data['date_debut'])->addMonths($data['duree'])->toDateString();
        } elseif (!empty($data['date_fin'])) {
            $data['duree'] = Carbon::parse($data['date_debut'])->diffInMonths(Carbon::parse($data['date_fin']));
        } else {
            throw new Exception("Il faut fournir soit la durée, soit la date de fin.");
        }

        // Par défaut, l'état de la promotion est 'Inactif'
        $data['etat'] = $data['etat'] ?? 'Inactif';

        // Si l'état est 'Actif', vérifier qu'il n'y a pas d'autre promotion active
        if ($data['etat'] === 'Actif') {
            foreach ($promotions as $promotion) {
                if ($promotion['etat'] === 'Actif') {
                    throw new Exception("Une seule promotion peut être active à la fois.");
                }
            }
        }

        // Si l'état est 'Clôturer', vérifier que la date de fin est atteinte
        if ($data['etat'] === 'Clôturer') {
            if (Carbon::now()->lt(Carbon::parse($data['date_fin']))) {
                throw new Exception("La promotion ne peut être clôturée que si la date de fin est atteinte.");
            }
        }

        // Vérifier et filtrer les référentiels actifs s'ils sont fournis
        if (isset($data['referentiels']) && is_array($data['referentiels'])) {
            $data['referentiels'] = array_filter($data['referentiels'], function ($referentiel) {
                return isset($referentiel['etat']) && $referentiel['etat'] === 'Actif';
            });
        } else {
            $data['referentiels'] = [];
        }

        // Créer la promotion dans Firebase
        return $this->promotionRepository->createPromotion($data);
    }

    public function updatePromotion(string $id, array $data)
    {
        // Gestion de la mise à jour de la promotion
        return $this->promotionRepository->updatePromotion($id, $data);
    }

    public function deletePromotion(string $id)
    {
        // Suppression logique (soft delete)
        $promotion = $this->promotionRepository->findPromotion($id);
        $promotion['deleted_at'] = now();
        return $this->promotionRepository->updatePromotion($id, $promotion);
    }

    public function getDeletedPromotions()
    {
        return $this->promotionRepository->getDeletedPromotions();
    }

    public function getAllPromotions()
    {
        return $this->promotionRepository->getAllPromotions();
    }


    public function updatePromotionReferentiels(string $id, array $data, $user)
    {
        $promotion = $this->promotionRepository->findPromotion($id);
        if (!$promotion) {
            throw new Exception("Promotion not found.");
        }

        if (!isset($data['referentiels']) || !is_array($data['referentiels'])) {
            throw new Exception("Referentiels data is required and should be an array.");
        }

        // Check user role and permissions
        if ($user->role->name === 'CM') {
            // CM can only remove empty referentials
            foreach ($data['referentiels'] as $referentiel) {
                if (isset($referentiel['remove']) && $referentiel['remove'] && count($referentiel['apprenants']) > 0) {
                    throw new Exception("CM can only remove empty referentiels.");
                }
            }
        }

        // Update referentiels
        foreach ($data['referentiels'] as $referentiel) {
            if (isset($referentiel['remove']) && $referentiel['remove']) {
                // Soft delete logic
                $referentiel['deleted_at'] = now();
            } else {
                // Add or update referentiel
                $referentiel['etat'] = 'Actif';
            }
        }

        $promotion['referentiels'] = $data['referentiels'];

        return $this->promotionRepository->updatePromotion($id, $promotion);
    }


    public function updatePromotionEtat(string $id, string $etat, $user)
    {
        if ($user->role->name !== 'Manager') {
            throw new Exception("Only Manager can change the promotion status.");
        }

        $promotion = $this->promotionRepository->findPromotion($id);
        if (!$promotion) {
            throw new Exception("Promotion not found.");
        }

        if ($etat === 'Actif') {
            $activePromotions = array_filter($this->promotionRepository->getAllPromotions(), function ($promotion) {
                return $promotion['etat'] === 'Actif';
            });
            if (count($activePromotions) > 0) {
                throw new Exception("Une seule promotion peut être active à la fois");
            }
        }

        if ($etat === 'Clôturer' && Carbon::now()->lt(Carbon::parse($promotion['date_fin']))) {
            throw new Exception("The promotion can only be closed if the end date is reached.");
        }

        $promotion['etat'] = $etat;
        return $this->promotionRepository->updatePromotion($id, $promotion);
    }


            public function getActivePromotion()
        {
            $promotions = $this->promotionRepository->getAllPromotions();
            foreach ($promotions as $promotion) {
                if ($promotion['etat'] === 'Actif') {
                    return $promotion;
                }
            }
            throw new Exception("No active promotion found.");
        }


        public function getPromotionReferentiels(string $id)
                {
                    $promotion = $this->promotionRepository->findPromotion($id);
                    if (!$promotion) {
                        throw new Exception("Promotion not found.");
                    }

                    return array_filter($promotion['referentiels'], function ($referentiel) {
                        return $referentiel['etat'] === 'Actif';
                    });
                }


                public function cloturerPromotion(string $id, $user)
                {
                    $promotion = $this->promotionRepository->findPromotion($id);
                    if (!$promotion) {
                        throw new Exception("Promotion not found.");
                    }

                    if (Carbon::now()->lt(Carbon::parse($promotion['date_fin']))) {
                        throw new Exception("La promotion ne peut être clôturée que si la date de fin est atteinte ou dépassée.");
                    }

                    // Clôture la promotion
                    $promotion['etat'] = 'Clôturer';
                    $updatedPromotion = $this->promotionRepository->updatePromotion($id, $promotion);
                    return $updatedPromotion;
                }

}
