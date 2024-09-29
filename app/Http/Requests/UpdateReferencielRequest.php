<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateReferencielRequest extends FormRequest
{
    public function authorize()
    {
        return true; // Autorisation pour tous les utilisateurs
    }

    public function rules()
    {
        return [
            'code' => 'sometimes|required|string|max:255',
            'libelle' => 'sometimes|required|string|max:255',
            'description' => 'sometimes|required|string',
            'statut' => 'sometimes|required|in:Actif,Inactif,Archiver',
            'competences' => 'sometimes|array',
            'competences.*.modules' => 'sometimes|array',
            'competences.*.modules.*.nom' => 'required|string',
            'competences.*.modules.*.description' => 'required|string',
            'competences.*.modules.*.duree_aquisition' => 'required|string',
        ];
    }

    public function messages(){
        return [
            'code.required' => 'Le code est obligatoire.',
            'libelle.required' => 'Le libellé est obligatoire.',
            'description.required' => 'La description est obligatoire.',
            'statut.required' => 'Le statut est obligatoire.',
        ];
    }
}
