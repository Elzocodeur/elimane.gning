<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreReferencielRequest extends FormRequest
{
    public function authorize()
    {
        return true; // Autorisation pour tous les utilisateurs
    }

    public function rules()
    {
        $referencielId = $this->route('referenciel'); // Assure-toi que tu passes l'ID dans la route

        return [
            'code' => 'required|string|max:255',
            'libelle' => 'required|string|max:255',
            'description' => 'required|string',
            'photo' => 'required|image|max:2048',
            'statut' => 'required|in:Actif,Inactif,Archiver',
        ];
    }

    public function messages(){
        return[
            'code.required' => 'Le code est obligatoire.',
            'libelle.required' => 'Le libelle est obligatoire.',
            'description.required' => 'La description est obligatoire.',
            'photo.required' => 'Le photo est obligatoire.',
            'statut.required' => "Le statut est obligatoire.",
        ];
    }

}
