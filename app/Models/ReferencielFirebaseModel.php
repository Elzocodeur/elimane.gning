<?php
namespace App\Models;

use Kreait\Firebase\Database;

class ReferencielFirebaseModel extends BaseFirebaseModel
{
    protected $table = 'referentiels';

    public function __construct(Database $database)
    {
        parent::__construct($database);
    }

        // Scope global pour les référentiels actifs
        public function scopeActif($query)
        {
            return $query->where('statut', 'Actif');
        }
}
