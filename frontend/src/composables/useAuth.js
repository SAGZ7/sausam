import { ref, computed } from 'vue'
import api from '../services/api'

const user = ref(JSON.parse(localStorage.getItem('user') || 'null'))
const token = ref(localStorage.getItem('token'))

export function useAuth() {
  const isAuthenticated = computed(() => !!token.value)
  const isAdmin = computed(() => user.value?.role === 'admin')

  const login = async (credentials) => {
    const response = await api.post('/login', credentials)
    token.value = response.data.token
    user.value = response.data.user
    localStorage.setItem('token', token.value)
    localStorage.setItem('user', JSON.stringify(user.value))
    return response.data
  }

  const register = async (userData) => {
    const response = await api.post('/register', userData)
    token.value = response.data.token
    user.value = response.data.user
    localStorage.setItem('token', token.value)
    localStorage.setItem('user', JSON.stringify(user.value))
    return response.data
  }

const logout = async () => {
  try {
    token.value = null
    user.value = null
    localStorage.removeItem('token')
    localStorage.removeItem('user')
    
    api.post('/logout').catch(() => {
      // Ignorar errores del backend, ya cerramos sesión localmente
    })
  } catch (err) {
    // Ignorar cualquier error
  }
}

  return {
    user,
    token,
    isAuthenticated,
    isAdmin,
    login,
    register,
    logout
  }
}