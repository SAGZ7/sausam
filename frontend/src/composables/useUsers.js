import { ref } from 'vue'
import api from '../services/api'

export function useUsers() {
  const users = ref([])
  const loading = ref(false)
  const error = ref(null)
  const pagination = ref({})

  const fetchUsers = async (page = 1) => {
    loading.value = true
    error.value = null
    try {
      const response = await api.get(`/users?page=${page}`)
      users.value = response.data.data
      pagination.value = {
        current_page: response.data.current_page,
        last_page: response.data.last_page,
        total: response.data.total,
        per_page: response.data.per_page
      }
    } catch (err) {
      error.value = err.response?.data?.message || 'Error al cargar usuarios'
    } finally {
      loading.value = false
    }
  }

  const createUser = async (userData) => {
    const response = await api.post('/users', userData)
    return response.data
  }

  const updateUser = async (id, userData) => {
    const response = await api.put(`/users/${id}`, userData)
    return response.data
  }

  const deleteUser = async (id) => {
    await api.delete(`/users/${id}`)
  }

  const exportUsers = async () => {
  try {
    const token = localStorage.getItem('token')
    const baseUrl = import.meta.env.VITE_API_URL || 'http://localhost:8000'
    const response = await fetch(`${baseUrl}/api/users-export`, {
      headers: {
        'Authorization': `Bearer ${token}`,
        'Accept': 'application/json'
      }
    })
    
    if (!response.ok) throw new Error('Error al exportar')
    
    const blob = await response.blob()
    const url = window.URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `usuarios-${new Date().toISOString().split('T')[0]}.csv`
    document.body.appendChild(a)
    a.click()
    window.URL.revokeObjectURL(url)
    a.remove()
  } catch (err) {
    console.error('Error al exportar:', err)
    alert('Error al exportar usuarios')
  }
}

  return {
    users,
    loading,
    error,
    pagination,
    fetchUsers,
    createUser,
    updateUser,
    deleteUser,
    exportUsers
  }
}