<template>
  <div class="min-h-screen bg-gray-100">
    <nav class="bg-white shadow-md">
      <div class="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-gray-800">SAUSAM</h1>
        <div class="flex items-center gap-4">
          <span class="text-gray-600">{{ user?.name }}</span>
          <span class="px-3 py-1 text-xs rounded-full" :class="badgeClass">
            {{ user?.role }}
          </span>
          <button @click="handleLogout" class="btn-secondary">
            Cerrar Sesión
          </button>
        </div>
      </div>
    </nav>

    <div class="max-w-7xl mx-auto px-4 py-8">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div class="card">
          <h3 class="text-lg font-semibold text-gray-700 mb-2">Bienvenido</h3>
          <p class="text-3xl font-bold text-blue-600">{{ user?.name }}</p>
        </div>

        <div class="card">
          <h3 class="text-lg font-semibold text-gray-700 mb-2">Rol</h3>
          <p class="text-3xl font-bold text-gray-800">{{ user?.role }}</p>
        </div>

        <div class="card">
          <h3 class="text-lg font-semibold text-gray-700 mb-2">Email</h3>
          <p class="text-lg text-gray-600">{{ user?.email }}</p>
        </div>
      </div>

      <div class="card">
        <h2 class="text-xl font-bold text-gray-800 mb-4">Acciones Rápidas</h2>
        <button @click="router.push('/users')" class="btn-primary">
          Ver Gestión de Usuarios
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuth } from '../composables/useAuth'

const router = useRouter()
const { user, logout } = useAuth()

const badgeClass = computed(() => {
  return user.value?.role === 'admin'
    ? 'bg-purple-100 text-purple-800'
    : 'bg-blue-100 text-blue-800'
})

const handleLogout = async () => {
  await logout()
  router.push('/login')
}
</script>