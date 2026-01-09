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

  const exportUsers = () => {
    window.open('http://localhost:8000/api/users/export/csv', '_blank')
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