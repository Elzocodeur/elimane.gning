<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class UsersTableSeeder extends Seeder
{
    public function run()
    {
        \App\Models\User::factory(10)->create(); // Crée 10 utilisateurs
    }
}
