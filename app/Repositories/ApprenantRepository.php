<?php

namespace App\Repositories;

use App\Facades\Apprenant;

class ApprenantRepository
{
    public function createApprenant(array $data)
    {
        return Apprenant::create($data);
    }

    public function findApprenant(string $id)
    {
        return Apprenant::find($id);
    }

    public function updateApprenant(string $id, array $data)
    {
        return Apprenant::update($id, $data);
    }

    public function deleteApprenant(string $id)
    {
        return Apprenant::delete($id);
    }

    public function getAllApprenants()
    {
        return Apprenant::all();
    }

    


}
