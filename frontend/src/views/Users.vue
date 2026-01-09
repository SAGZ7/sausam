<template>
  <div class="min-h-screen bg-gray-100">
    <!-- Navbar -->
    <nav class="bg-white shadow-md">
      <div class="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-gray-800">SAUSAM</h1>
        <div class="flex items-center gap-4">
          <button @click="router.push('/')" class="text-blue-600 hover:text-blue-800">
            Dashboard
          </button>
          <span class="text-gray-600">{{ user?.name }}</span>
          <button @click="handleLogout" class="btn-secondary">
            Cerrar Sesión
          </button>
        </div>
      </div>
    </nav>

    <!-- Content -->
    <div class="max-w-7xl mx-auto px-4 py-8">
      <div class="card">
        <div class="flex justify-between items-center mb-6">
          <h2 class="text-2xl font-bold text-gray-800">Gestión de Usuarios</h2>
          <div class="flex gap-2">
            <button v-if="isAdmin" @click="exportUsers" class="btn-secondary">
              Exportar CSV
            </button>
            <button v-if="isAdmin" @click="openModal()" class="btn-primary">
              Nuevo Usuario
            </button>
          </div>
        </div>

        <!-- Loading -->
        <div v-if="loading" class="text-center py-8">
          <p class="text-gray-600">Cargando usuarios...</p>
        </div>

        <!-- Error -->
        <div v-if="error" class="mb-4 p-3 bg-red-100 border border-red-400 text-red-700 rounded">
          {{ error }}
        </div>

        <!-- Table -->
        <div v-if="!loading" class="overflow-x-auto">
          <table class="min-w-full bg-white">
            <thead class="bg-gray-100">
              <tr>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase">ID</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase">Nombre</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase">Email</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase">Teléfono</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase">Rol</th>
                <th v-if="isAdmin" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase">Acciones</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
              <tr v-for="usr in users" :key="usr.id" class="hover:bg-gray-50">
                <td class="px-6 py-4 text-sm text-gray-900">{{ usr.id }}</td>
                <td class="px-6 py-4 text-sm text-gray-900">{{ usr.name }}</td>
                <td class="px-6 py-4 text-sm text-gray-600">{{ usr.email }}</td>
                <td class="px-6 py-4 text-sm text-gray-600">{{ usr.phone || '-' }}</td>
                <td class="px-6 py-4">
                  <span class="px-2 py-1 text-xs rounded-full" :class="usr.role === 'admin' ? 'bg-purple-100 text-purple-800' : 'bg-blue-100 text-blue-800'">
                    {{ usr.role }}
                  </span>
                </td>
                <td v-if="isAdmin" class="px-6 py-4 text-sm">
                  <button @click="openModal(usr)" class="text-blue-600 hover:text-blue-800 mr-3">
                    Editar
                  </button>
                  <button @click="handleDelete(usr)" class="text-red-600 hover:text-red-800">
                    Eliminar
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Pagination -->
        <div v-if="pagination.last_page > 1" class="mt-6 flex justify-center gap-2">
          <button
            v-for="page in pagination.last_page"
            :key="page"
            @click="fetchUsers(page)"
            class="px-4 py-2 rounded"
            :class="page === pagination.current_page ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700 hover:bg-gray-300'"
          >
            {{ page }}
          </button>
        </div>
      </div>
    </div>

    <!-- Modal -->
    <div v-if="showModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div class="bg-white rounded-lg p-6 max-w-md w-full mx-4">
        <h3 class="text-xl font-bold mb-4">{{ editingUser ? 'Editar Usuario' : 'Nuevo Usuario' }}</h3>
        
        <form @submit.prevent="handleSubmit">
          <div class="mb-4">
            <label class="block text-gray-700 text-sm font-medium mb-2">Nombre</label>
            <input v-model="formData.name" type="text" class="input-field" required />
          </div>

          <div class="mb-4">
            <label class="block text-gray-700 text-sm font-medium mb-2">Email</label>
            <input v-model="formData.email" type="email" class="input-field" required />
          </div>

          <div class="mb-4">
            <label class="block text-gray-700 text-sm font-medium mb-2">
              Contraseña {{ editingUser ? '(dejar vacío para no cambiar)' : '' }}
            </label>
            <input
              v-model="formData.password"
              type="password"
              class="input-field"
              :required="!editingUser"
              minlength="8"
            />
          </div>

          <div class="mb-4">
            <label class="block text-gray-700 text-sm font-medium mb-2">Teléfono</label>
            <input v-model="formData.phone" type="text" class="input-field" />
          </div>

          <div class="mb-6">
            <label class="block text-gray-700 text-sm font-medium mb-2">Rol</label>
            <select v-model="formData.role" class="input-field" required>
              <option value="user">Usuario</option>
              <option value="admin">Administrador</option>
            </select>
          </div>

          <div v-if="formError" class="mb-4 p-3 bg-red-100 border border-red-400 text-red-700 rounded text-sm">
            {{ formError }}
          </div>

          <div class="flex justify-end gap-2">
            <button type="button" @click="closeModal" class="btn-secondary">Cancelar</button>
            <button type="submit" class="btn-primary" :disabled="submitting">
              {{ submitting ? 'Guardando...' : 'Guardar' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuth } from '../composables/useAuth'
import { useUsers } from '../composables/useUsers'

const router = useRouter()
const { user, isAdmin, logout } = useAuth()
const { users, loading, error, pagination, fetchUsers, createUser, updateUser, deleteUser, exportUsers } = useUsers()

const showModal = ref(false)
const editingUser = ref(null)
const formData = ref({
  name: '',
  email: '',
  password: '',
  phone: '',
  role: 'user'
})
const submitting = ref(false)
const formError = ref('')

onMounted(() => {
  fetchUsers()
})

const openModal = (usr = null) => {
  editingUser.value = usr
  if (usr) {
    formData.value = {
      name: usr.name,
      email: usr.email,
      password: '',
      phone: usr.phone || '',
      role: usr.role
    }
  } else {
    formData.value = {
      name: '',
      email: '',
      password: '',
      phone: '',
      role: 'user'
    }
  }
  formError.value = ''
  showModal.value = true
}

const closeModal = () => {
  showModal.value = false
  editingUser.value = null
}

const handleSubmit = async () => {
  submitting.value = true
  formError.value = ''
  
  try {
    const data = { ...formData.value }
    if (editingUser.value && !data.password) {
      delete data.password
    }

    if (editingUser.value) {
      await updateUser(editingUser.value.id, data)
    } else {
      await createUser(data)
    }
    
    await fetchUsers(pagination.value.current_page)
    closeModal()
  } catch (err) {
    formError.value = err.response?.data?.message || 'Error al guardar usuario'
  } finally {
    submitting.value = false
  }
}

const handleDelete = async (usr) => {
  if (!confirm(`¿Está seguro de eliminar a ${usr.name}?`)) return
  
  try {
    await deleteUser(usr.id)
    await fetchUsers(pagination.value.current_page)
  } catch (err) {
    alert('Error al eliminar usuario')
  }
}

const handleLogout = async () => {
  await logout()
  router.push('/login')
}
</script>