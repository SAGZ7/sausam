<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

class UserTest extends TestCase
{
    use RefreshDatabase;

    protected function createAdminUser()
    {
        return User::factory()->create(['role' => 'admin']);
    }

    protected function createRegularUser()
    {
        return User::factory()->create(['role' => 'user']);
    }

    public function test_admin_can_list_users()
    {
        $admin = $this->createAdminUser();
        User::factory()->count(5)->create();

        $response = $this->actingAs($admin, 'sanctum')
            ->getJson('/api/users');

        $response->assertStatus(200)
            ->assertJsonStructure([
                'data' => [
                    '*' => ['id', 'name', 'email', 'role']
                ],
                'current_page',
                'last_page'
            ]);
    }

    public function test_regular_user_can_list_users()
    {
        $user = $this->createRegularUser();

        $response = $this->actingAs($user, 'sanctum')
            ->getJson('/api/users');

        $response->assertStatus(200);
    }

    public function test_admin_can_create_user()
    {
        $admin = $this->createAdminUser();

        $response = $this->actingAs($admin, 'sanctum')
            ->postJson('/api/users', [
                'name' => 'New User',
                'email' => 'newuser@example.com',
                'password' => 'password123',
                'phone' => '+52 443 123 4567',
                'role' => 'user',
            ]);

        $response->assertStatus(201)
            ->assertJsonFragment(['email' => 'newuser@example.com']);

        $this->assertDatabaseHas('users', [
            'email' => 'newuser@example.com',
        ]);
    }

    public function test_regular_user_cannot_create_user()
    {
        $user = $this->createRegularUser();

        $response = $this->actingAs($user, 'sanctum')
            ->postJson('/api/users', [
                'name' => 'New User',
                'email' => 'newuser@example.com',
                'password' => 'password123',
                'role' => 'user',
            ]);

        $response->assertStatus(403);
    }

    public function test_admin_can_update_user()
    {
        $admin = $this->createAdminUser();
        $user = User::factory()->create([
            'name' => 'Old Name',
            'role' => 'user'
        ]);

        $response = $this->actingAs($admin, 'sanctum')
            ->putJson("/api/users/{$user->id}", [
                'name' => 'Updated Name',
                'email' => $user->email,
                'role' => 'user',
            ]);

        $response->assertStatus(200)
            ->assertJsonFragment(['name' => 'Updated Name']);

        $this->assertDatabaseHas('users', [
            'id' => $user->id,
            'name' => 'Updated Name',
        ]);
    }

    public function test_admin_can_delete_user()
    {
        $admin = $this->createAdminUser();
        $user = User::factory()->create();

        $response = $this->actingAs($admin, 'sanctum')
            ->deleteJson("/api/users/{$user->id}");

        $response->assertStatus(200);

        $this->assertDatabaseMissing('users', [
            'id' => $user->id,
        ]);
    }

    public function test_regular_user_cannot_delete_user()
    {
        $user = $this->createRegularUser();
        $otherUser = User::factory()->create();

        $response = $this->actingAs($user, 'sanctum')
            ->deleteJson("/api/users/{$otherUser->id}");

        $response->assertStatus(403);
    }

    public function test_unauthenticated_user_cannot_access_users()
    {
        $response = $this->getJson('/api/users');

        $response->assertStatus(401);
    }
}
