<template>
  <div class="min-h-screen bg-gray-50">
<nav class="sticky top-0 z-40 bg-white/80 backdrop-blur-md border-b border-gray-200">
  <div class="max-w-7xl mx-auto px-6 py-3">
    <div class="flex items-center justify-between">

      <!-- IZQUIERDA -->
      <div class="flex items-center gap-6">
        <h1 class="text-lg font-bold text-gray-900 tracking-tight">SAUSAM</h1>

        <button 
          @click="router.push('/')" 
          class="text-sm text-gray-600 hover:text-gray-900 transition-colors flex items-center gap-1.5"
        >
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M10 19l-7-7m0 0l7-7m-7 7h18" />
          </svg>
          <span>Dashboard</span>
        </button>
      </div>

      <!-- DERECHA -->
      <div class="flex items-center gap-3">

        <!-- 🌐 Idioma -->
        <div class="flex gap-1 bg-gray-100 rounded-lg p-1">
          <button
            @click="setLocale('es')"
            class="px-2.5 py-1 rounded text-xs font-medium transition-all"
            :class="locale === 'es'
              ? 'bg-white text-gray-900 shadow-sm'
              : 'text-gray-600 hover:text-gray-900'"
          >
            ES
          </button>
          <button
            @click="setLocale('en')"
            class="px-2.5 py-1 rounded text-xs font-medium transition-all"
            :class="locale === 'en'
              ? 'bg-white text-gray-900 shadow-sm'
              : 'text-gray-600 hover:text-gray-900'"
          >
            EN
          </button>
        </div>

        <!-- Usuario -->
        <div class="flex items-center gap-3 px-3 py-1.5 rounded-lg bg-gray-100/50">
          <div class="w-7 h-7 rounded-full bg-gray-900 flex items-center justify-center">
            <span class="text-xs font-bold text-white">
              {{ user?.name?.charAt(0).toUpperCase() }}
            </span>
          </div>
          <span class="text-sm text-gray-700 font-medium">
            {{ user?.name }}
          </span>
        </div>

        <!-- Logout -->
        <button 
          @click="handleLogout" 
          class="p-2 hover:bg-gray-100 rounded-lg transition-colors"
          :title="t?.dashboard?.logout || 'Cerrar sesión'"
        >
          <svg class="w-5 h-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
          </svg>
        </button>

      </div>
    </div>
  </div>
</nav>


    <!-- Main Content -->
    <div class="max-w-7xl mx-auto px-6 py-8">
      <!-- Stats Cards -->
      <div class="grid grid-cols-3 gap-4 mb-8">
        <div class="bg-white border border-gray-200 rounded-lg p-5 hover:shadow-sm transition-shadow">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-xs text-gray-500 font-medium uppercase tracking-wider mb-1">{{t.users.totalUsers}}</p>
              <p class="text-3xl font-bold text-gray-900 tracking-tight">{{ pagination.total || 0 }}</p>
            </div>
            <div class="w-12 h-12 rounded-lg bg-blue-50 flex items-center justify-center">
              <svg class="w-6 h-6 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                <path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"></path>
              </svg>
            </div>
          </div>
        </div>

        <div class="bg-white border border-gray-200 rounded-lg p-5 hover:shadow-sm transition-shadow">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-xs text-gray-500 font-medium uppercase tracking-wider mb-1">{{t.users.administrators}}</p>
              <p class="text-3xl font-bold text-gray-900 tracking-tight">{{ users.filter(u => u.role === 'admin').length }}</p>
            </div>
            <div class="w-12 h-12 rounded-lg bg-purple-50 flex items-center justify-center">
              <svg class="w-6 h-6 text-purple-600" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
              </svg>
            </div>
          </div>
        </div>

        <div class="bg-white border border-gray-200 rounded-lg p-5 hover:shadow-sm transition-shadow">
          <div class="flex items-center justify-between">
            <div>
              <p class="text-xs text-gray-500 font-medium uppercase tracking-wider mb-1">{{t.users.regularUsers}}</p>
              <p class="text-3xl font-bold text-gray-900 tracking-tight">{{ users.filter(u => u.role === 'user').length }}</p>
            </div>
            <div class="w-12 h-12 rounded-lg bg-green-50 flex items-center justify-center">
              <svg class="w-6 h-6 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                <path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v3h-3zM4.75 12.094A5.973 5.973 0 004 15v3H1v-3a3 3 0 013.75-2.906z"></path>
              </svg>
            </div>
          </div>
        </div>
      </div>

      <!-- Toolbar -->
      <div class="bg-white border border-gray-200 rounded-lg mb-6">
        <div class="p-5 flex items-center justify-between">
          <div>
            <h2 class="text-xl font-bold text-gray-900 tracking-tight">{{ t.users.directory }}</h2>
            <p class="text-sm text-gray-500 mt-0.5">{{ users.length }} {{t.users.registeredUsers}}</p>
          </div>

          <div class="flex items-center gap-3">
            <!-- Search -->
            <div class="relative">
              <input 
                v-model="searchQuery"
                type="text"
                placeholder="Buscar usuarios..."
                class="pl-9 pr-4 py-2 text-sm border border-gray-200 rounded-lg bg-gray-50 focus:bg-white focus:border-blue-600 focus:ring-1 focus:ring-blue-600 focus:outline-none transition-all w-64"
              />
              <svg class="w-4 h-4 text-gray-400 absolute left-3 top-1/2 -translate-y-1/2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
              </svg>
            </div>

            <!-- Export (Admin only) -->
            <button 
              v-if="isAdmin"
              @click="handleExport"
              :disabled="isExporting"
              class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-200 rounded-lg transition-all flex items-center gap-2"
              :class="isExporting ? 'opacity-75 cursor-wait bg-gray-50' : 'hover:bg-gray-50 hover:shadow-sm'"
            >
              <svg v-if="isExporting" class="animate-spin w-4 h-4 text-gray-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>

              <svg v-else class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
              </svg>

              <span>{{ isExporting ? 'Generando...' : t.users.export }}</span>
            </button>

            <!-- New User Button (Admin only) -->
            <button 
              v-if="isAdmin"
              @click="openModal()"
              class="px-4 py-2 text-sm font-medium text-white bg-gray-900 rounded-lg hover:bg-gray-800 transition-colors flex items-center gap-2"
            >
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
              </svg>
              <span>{{t.users.new}}</span>
            </button>
          </div>
        </div>

        <!-- Table -->
        <div v-if="loading" class="p-16 text-center">
          <div class="inline-block w-8 h-8 border-2 border-gray-300 border-t-gray-900 rounded-full animate-spin"></div>
          <p class="mt-4 text-sm text-gray-500">{{t.users.loading}}</p>
        </div>

        <div v-else-if="filteredUsers.length === 0" class="p-16 text-center">
          <svg class="w-12 h-12 text-gray-300 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"></path>
          </svg>
          <p class="text-sm text-gray-500">{{ t.users.notFound }}</p>
        </div>

        <table v-else class="w-full">
          <thead class="border-t border-gray-200">
            <tr class="bg-gray-50">
              <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">{{t.users.user }}</th>
              <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">{{t.users.rol }}</th>
              <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">{{t.users.state }}</th>
              <th class="px-5 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">{{t.users.actions }}</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-100">
            <tr 
              v-for="usr in filteredUsers" 
              :key="usr.id" 
              class="group hover:bg-gray-50 transition-colors"
            >
              <!-- Usuario Column -->
              <td class="px-5 py-4">
                <div class="flex items-center gap-3">
                  <div class="w-9 h-9 rounded-full bg-gradient-to-br from-gray-700 to-gray-900 flex items-center justify-center flex-shrink-0">
                    <span class="text-xs font-bold text-white">{{ usr.name.charAt(0).toUpperCase() }}</span>
                  </div>
                  <div>
                    <p class="text-sm font-medium text-gray-900">{{ usr.name }}</p>
                    <p class="text-xs text-gray-500">{{ usr.email }}</p>
                  </div>
                </div>
              </td>

              <!-- Rol Column -->
              <td class="px-5 py-4">
                <span 
                  class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium"
                  :class="usr.role === 'admin' 
                    ? 'bg-purple-50 text-purple-700 border border-purple-200' 
                    : 'bg-blue-50 text-blue-700 border border-blue-200'"
                >
                  {{ usr.role === 'admin' ? 'Admin' : 'User' }}
                </span>
              </td>

              <!-- Estado Column -->
              <td class="px-5 py-4">
                <div class="flex items-center gap-2">
                  <div class="w-2 h-2 rounded-full bg-green-500"></div>
                  <span class="text-sm text-gray-600">{{t.users.active}}</span>
                </div>
              </td>

              <!-- Acciones Column (hover reveal) -->
              <td class="px-5 py-4">
                <div 
                  v-if="isAdmin"
                  class="flex items-center gap-2 opacity-0 group-hover:opacity-100 transition-opacity"
                >
                  <button 
                    @click="openModal(usr)"
                    class="p-1.5 hover:bg-gray-200 rounded transition-colors"
                    title="Editar"
                  >
                    <svg class="w-4 h-4 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                    </svg>
                  </button>
                  <button 
                    @click="handleDelete(usr)"
                    class="p-1.5 hover:bg-red-50 rounded transition-colors"
                    title="Eliminar"
                  >
                    <svg class="w-4 h-4 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                    </svg>
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>

        <!-- Pagination -->
        <div v-if="pagination.last_page > 1" class="px-5 py-4 border-t border-gray-200 flex items-center justify-between">
          <p class="text-sm text-gray-500">
            {{t.users.page}} {{ pagination.current_page }} de {{ pagination.last_page }}
          </p>
          <div class="flex items-center gap-1">
            <button
              v-for="page in pagination.last_page"
              :key="page"
              @click="fetchUsers(page)"
              class="px-3 py-1 text-sm rounded transition-colors"
              :class="page === pagination.current_page 
                ? 'bg-gray-900 text-white font-medium' 
                : 'text-gray-600 hover:bg-gray-100'"
            >
              {{ page }}
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal con Glassmorphism -->
    <Transition name="modal">
      <div 
        v-if="showModal" 
        class="fixed inset-0 z-50 flex items-center justify-center p-4"
        @click.self="closeModal"
      >
        <div class="absolute inset-0 bg-black/40 backdrop-blur-sm"></div>
        
        <div class="relative bg-white/90 backdrop-blur-md rounded-xl shadow-2xl max-w-md w-full border border-gray-200">
          <div class="p-6">
            <div class="flex items-center justify-between mb-6">
              <h3 class="text-lg font-bold text-gray-900 tracking-tight">
                {{ editingUser ? t.users.editUser : t.users.newUser }}
              </h3>
              <button 
                @click="closeModal"
                class="p-1.5 hover:bg-gray-100 rounded-lg transition-colors"
              >
                <svg class="w-5 h-5 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
              </button>
            </div>

            <form @submit.prevent="handleSubmit" class="space-y-4">
              <div>
                <label class="block text-xs font-medium text-gray-700 mb-1.5">{{t.users.fullName}}</label>
                <input 
                  v-model="formData.name"
                  type="text"
                  class="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:border-blue-600 focus:ring-1 focus:ring-blue-600 focus:outline-none transition-colors"
                  placeholder="Juan Pérez"
                  required
                />
              </div>

              <div>
                <label class="block text-xs font-medium text-gray-700 mb-1.5">Email</label>
                <input 
                  v-model="formData.email"
                  type="email"
                  class="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:border-blue-600 focus:ring-1 focus:ring-blue-600 focus:outline-none transition-colors"
                  placeholder="juan@ejemplo.com"
                  required
                />
              </div>

              <div>
                <label class="block text-xs font-medium text-gray-700 mb-1.5">
                  {{t.users.passwordLabel}} {{ editingUser ? '(dejar vacío para mantener)' : '' }}
                </label>
                <input 
                  v-model="formData.password"
                  type="password"
                  class="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:border-blue-600 focus:ring-1 focus:ring-blue-600 focus:outline-none transition-colors"
                  placeholder="••••••••"
                  :required="!editingUser"
                  minlength="8"
                />
              </div>

              <div>
                <label class="block text-xs font-medium text-gray-700 mb-1.5">{{t.users.phoneLabel}}</label>
                <input 
                  v-model="formData.phone"
                  type="text"
                  class="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:border-blue-600 focus:ring-1 focus:ring-blue-600 focus:outline-none transition-colors"
                  placeholder="+52 443 123 4567"
                />
              </div>

              <div>
                <label class="block text-xs font-medium text-gray-700 mb-1.5">Rol</label>
                <select 
                  v-model="formData.role"
                  class="w-full px-3 py-2 text-sm border border-gray-200 rounded-lg focus:border-blue-600 focus:ring-1 focus:ring-blue-600 focus:outline-none transition-colors"
                  required
                >
                  <option value="user">{{t.users.user}}</option>
                  <option value="admin">{{t.users.administrator}}</option>
                </select>
              </div>

              <div v-if="formError" class="p-3 bg-red-50 border border-red-200 rounded-lg">
                <p class="text-sm text-red-600">{{ formError }}</p>
              </div>

              <div class="flex items-center justify-end gap-3 pt-4">
                <button 
                  type="button"
                  @click="closeModal"
                  class="px-4 py-2 text-sm font-medium text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
                >
                  Cancelar
                </button>
                <button 
                  type="submit"
                  class="px-4 py-2 text-sm font-medium text-white bg-gray-900 rounded-lg hover:bg-gray-800 transition-colors flex items-center gap-2"
                  :disabled="submitting"
                >
                  <svg v-if="submitting" class="animate-spin w-4 h-4" fill="none" viewBox="0 0 24 24">
                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                  </svg>
                  <span>{{ submitting ? t.common.saving : t.common.save }}</span>
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAuth } from '../composables/useAuth'
import { useUsers } from '../composables/useUsers'
import { useLocale } from '../composables/useLocale'

const router = useRouter()
const { user, isAdmin, logout } = useAuth()
const { users, loading, error, pagination, fetchUsers, createUser, updateUser, deleteUser, exportUsers } = useUsers()
const loggingOut = ref(false)
const { locale, t, setLocale } = useLocale()
const isExporting = ref(false);
const showModal = ref(false)
const editingUser = ref(null)
const searchQuery = ref('')
const formData = ref({
  name: '',
  email: '',
  password: '',
  phone: '',
  role: 'user'
})
const submitting = ref(false)
const formError = ref('')

const handleExport = async () => {
  if (isExporting.value) return; // Evita doble clic

  isExporting.value = true;
  
  try {
    // Llamamos a tu función original exportUsers()
    await exportUsers(); 
  } catch (error) {
    console.error('Error exportando:', error);
  } finally {
    // Importante: Desactivamos el spinner al terminar (haya error o no)
    isExporting.value = false;
  }
};

// Filtered users based on search
const filteredUsers = computed(() => {
  if (!searchQuery.value) return users.value
  
  const query = searchQuery.value.toLowerCase()
  return users.value.filter(usr => 
    usr.name.toLowerCase().includes(query) ||
    usr.email.toLowerCase().includes(query)
  )
})

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
  loggingOut.value = true
  await logout()
  router.push('/login')
}
</script>

<style scoped>
.modal-enter-active,
.modal-leave-active {
  transition: opacity 0.2s ease;
}

.modal-enter-from,
.modal-leave-to {
  opacity: 0;
}

.modal-enter-active .relative,
.modal-leave-active .relative {
  transition: transform 0.2s ease, opacity 0.2s ease;
}

.modal-enter-from .relative,
.modal-leave-to .relative {
  transform: scale(0.95);
  opacity: 0;
}
</style>