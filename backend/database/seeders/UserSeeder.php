<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        User::create([
            'name' => 'Admin User',
            'email' => 'admin@sausam.com',
            'password' => Hash::make('password'),
            'phone' => '+52 443 123 4567',
            'role' => 'admin',
        ]);

        User::create([
            'name' => 'Regular User',
            'email' => 'user@sausam.com',
            'password' => Hash::make('password'),
            'phone' => '+52 443 765 4321',
            'role' => 'user',
        ]);
    }
}