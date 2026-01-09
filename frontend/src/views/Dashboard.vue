<template>
  <div class="min-h-screen bg-gray-50/50 font-sans text-gray-800">
    
<nav class="sticky top-0 z-40 bg-white/80 backdrop-blur-md border-b border-gray-100 transition-all duration-300">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between h-16">
      
      <!-- IZQUIERDA: Logo -->
      <div class="flex items-center gap-3">
        <div class="bg-gray-900 text-white p-1.5 rounded-lg shadow-sm">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
          </svg>
        </div>
        <span class="text-xl font-bold tracking-tight text-gray-900">SAUSAM</span>
      </div>

      <!-- DERECHA -->
      <div class="flex items-center gap-4">

        <!-- 🌐 Selector de idioma -->
        <div class="flex gap-1 bg-gray-100 rounded-lg p-1">
          <button
            @click="setLocale('es')"
            class="px-3 py-1 rounded text-xs font-medium transition-all"
            :class="locale === 'es'
              ? 'bg-white text-gray-900 shadow-sm'
              : 'text-gray-600 hover:text-gray-900'"
          >
            ES
          </button>
          <button
            @click="setLocale('en')"
            class="px-3 py-1 rounded text-xs font-medium transition-all"
            :class="locale === 'en'
              ? 'bg-white text-gray-900 shadow-sm'
              : 'text-gray-600 hover:text-gray-900'"
          >
            EN
          </button>
        </div>

        <!-- Info usuario -->
        <div class="hidden md:flex flex-col items-end">
          <span class="text-sm font-bold text-gray-800 leading-tight">
            {{ user?.name }}
          </span>
          <span class="text-[10px] font-medium text-gray-500 uppercase tracking-wider">
            {{ user?.role === 'admin' ? 'Administrador' : 'Usuario' }}
          </span>
        </div>

        <!-- Separador -->
        <div class="h-8 w-px bg-gray-200"></div>

        <!-- Logout -->
        <button
          @click="handleLogout"
          class="group flex items-center gap-2 px-4 py-2 text-sm font-medium text-gray-600 transition-all duration-200 hover:text-red-600 hover:bg-red-50 rounded-full"
        >
          <span>{{ t.dashboard.logout }}</span>
          <svg class="w-4 h-4 transition-transform group-hover:translate-x-1"
            fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
          </svg>
        </button>

      </div>
    </div>
  </div>
</nav>

    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 space-y-8">
      
      <div class="relative rounded-3xl overflow-hidden shadow-2xl animate-fade-in-up">
        <div 
          class="absolute inset-0 bg-cover bg-center z-0"
          :style="{ backgroundImage: `url(${moreliaBg})` }"
        ></div>
        <div class="absolute inset-0 bg-gradient-to-r from-gray-900 via-gray-900/90 to-transparent z-10"></div>
        
        <div class="relative z-20 p-8 md:p-12 flex flex-col md:flex-row justify-between items-center">
          <div class="space-y-4 max-w-2xl">
            <div class="inline-flex items-center px-3 py-1 rounded-full border border-gray-600 bg-gray-800/50 backdrop-blur-sm text-gray-300 text-xs font-medium">
              <span class="w-2 h-2 rounded-full bg-green-400 mr-2 animate-pulse"></span>
              {{t.dashboard.systemActive}}
            </div>
            <h1 class="text-3xl md:text-5xl font-extrabold text-white tracking-tight">
              {{ t.dashboard.hello }}, <span class="text-transparent bg-clip-text bg-gradient-to-r from-blue-200 to-white">{{ user?.name?.split(' ')[0] }}</span>
            </h1>
            <p class="text-gray-300 text-lg font-light leading-relaxed">
              {{t.dashboard.largeWelcome}}
            </p>
          </div>
          
          <div class="hidden md:block opacity-30">
            <svg class="w-32 h-32 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
               <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
            </svg>
          </div>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 animate-fade-in-up" style="animation-delay: 0.1s">
        
        <div class="lg:col-span-1 space-y-6">
          <div class="bg-white rounded-2xl shadow-sm border border-gray-100 p-6 relative overflow-hidden group hover:shadow-md transition-shadow">
             <div class="absolute top-0 right-0 w-24 h-24 bg-gray-50 rounded-bl-full -mr-4 -mt-4 transition-transform group-hover:scale-110"></div>
             
             <div class="relative z-10">
                <h3 class="text-gray-400 text-xs font-bold uppercase tracking-widest mb-4">{{t.dashboard.yourCredential}}</h3>
                <div class="flex items-center gap-4 mb-6">
                   <div class="w-16 h-16 rounded-2xl bg-gradient-to-br from-gray-700 to-gray-900 flex items-center justify-center text-white text-2xl font-bold shadow-lg">
                      {{ user?.name?.charAt(0) }}
                   </div>
                   <div>
                      <p class="text-xl font-bold text-gray-900">{{ user?.name }}</p>
                      <p class="text-sm text-gray-500 font-mono">{{ user?.email }}</p>
                   </div>
                </div>
                
                <div class="border-t border-gray-100 pt-4 flex justify-between items-center">
                   <span class="text-sm text-gray-500">{{ t.dashboard.accessLevel }}</span>
                   <span 
                      class="px-3 py-1 rounded-full text-xs font-bold border"
                      :class="user?.role === 'admin' ? 'bg-gray-900 text-white border-gray-900' : 'bg-white text-gray-600 border-gray-200'"
                   >
                      {{ user?.role === 'admin' ? 'ADMINISTRADOR' : 'USUARIO' }}
                   </span>
                </div>
             </div>
          </div>

          <div class="bg-gradient-to-br from-gray-50 to-white rounded-2xl p-6 border border-gray-200">
              <h3 class="text-gray-900 font-bold mb-3 flex items-center gap-2">
                 <svg class="w-4 h-4 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                  {{ t.dashboard.systemState }}
                </h3>
              <div class="space-y-3">
                 <div class="flex justify-between text-sm">
                    <span class="text-gray-500">Versión</span>
                    <span class="font-mono font-medium text-gray-900">v1.0.0</span>
                 </div>
                 <div class="flex justify-between text-sm">
                    <span class="text-gray-500">Framework</span>
                    <span class="font-medium text-gray-700">Laravel 11 + Vue 3</span>
                 </div>
                 <div class="w-full bg-gray-200 rounded-full h-1.5 mt-2">
                    <div class="bg-green-500 h-1.5 rounded-full" style="width: 100%"></div>
                 </div>
                 <p class="text-[10px] text-gray-400 text-center mt-1">{{t.dashboard.servicesState}}</p>
              </div>
           </div>
        </div>

        <div class="lg:col-span-2">
           <h3 class="text-lg font-bold text-gray-900 mb-4 px-1">{{t.dashboard.quickActions}}</h3>
           
           <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div 
                @click="router.push('/users')"
                class="group bg-white p-6 rounded-2xl border border-gray-100 shadow-sm hover:shadow-xl hover:border-blue-100 transition-all duration-300 cursor-pointer relative overflow-hidden"
              >
                 <div class="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-20 transition-opacity">
                    <svg class="w-24 h-24 text-blue-600 transform translate-x-4 -translate-y-4" fill="currentColor" viewBox="0 0 20 20">
                       <path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v3h-3zM4.75 12.094A5.973 5.973 0 004 15v3H1v-3a3 3 0 013.75-2.906z"></path>
                    </svg>
                 </div>

                 <div class="relative z-10">
                    <div class="w-12 h-12 bg-blue-50 rounded-xl flex items-center justify-center mb-4 group-hover:bg-blue-600 transition-colors duration-300">
                       <svg class="w-6 h-6 text-blue-600 group-hover:text-white transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
                       </svg>
                    </div>
                    <h4 class="text-xl font-bold text-gray-900 mb-2">{{ t.dashboard.userGestions }}</h4>
                    <p class="text-sm text-gray-500 mb-6 pr-8">
                       {{ user?.role === 'admin' ? t.dashboard.adminRoleUse : t.dashboard.checkDirectory  }}
                    </p>
                    <span class="text-blue-600 text-sm font-bold flex items-center gap-2 group-hover:gap-3 transition-all">
                       {{t.dashboard.accessToModule}}
                       <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"></path></svg>
                    </span>
                 </div>
              </div>
            <div 
                v-if="isAdmin"
                @click="onExportClick"
                class="relative group bg-white p-6 rounded-2xl border border-gray-100 shadow-sm transition-all duration-300 overflow-hidden"
                :class="isExporting ? 'cursor-wait opacity-90' : 'hover:shadow-xl hover:-translate-y-1 hover:border-green-200 cursor-pointer'"
              >
                <div class="absolute top-0 right-0 -mr-8 -mt-8 w-24 h-24 bg-green-50 rounded-full blur-2xl opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>

                <div class="flex items-start space-x-5 relative z-10">
                  
                  <div 
                    class="w-14 h-14 rounded-xl flex items-center justify-center flex-shrink-0 transition-colors duration-300"
                    :class="isExporting ? 'bg-gray-50' : 'bg-green-50 group-hover:bg-green-100'"
                  >
                    <svg v-if="isExporting" class="animate-spin h-6 w-6 text-green-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                      <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                    
                    <svg v-else class="w-7 h-7 text-green-600 transition-transform duration-300 group-hover:scale-110" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                  </div>

                  <div class="flex-1">
                    <h3 
                      class="text-lg font-bold text-gray-900 mb-1 transition-colors"
                      :class="{ 'text-green-700': isExporting }"
                    >
                      {{ isExporting ? t.dashboard.generatingFile : t.dashboard.exportUsers }}
                    </h3>
                    
                    <p class="text-sm text-gray-500 leading-relaxed mb-3">
                      {{ isExporting ? t.dashboard.preparingDownload : t.dashboard.downloadCSVLarge }}
                    </p>

                    <div 
                      class="inline-flex items-center text-sm font-bold transition-colors"
                      :class="isExporting ? 'text-gray-400' : 'text-green-600 group-hover:text-green-700'"
                    >
                      <span>{{ isExporting ? t.dashboard.processing : t.dashboard.downloadCSV }}</span>
                      
                      <svg v-if="!isExporting" class="w-4 h-4 ml-2 transform group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"></path>
                      </svg>
                    </div>
                  </div>
                </div>
              </div>
           </div>
        </div>

      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useAuth } from '../composables/useAuth'
import moreliaBg from '../assets/morelia-skyline.png'
import { useLocale } from '../composables/useLocale'

const router = useRouter()
const { user, logout, isAdmin } = useAuth()
const { locale, t, setLocale } = useLocale()

const loggingOut = ref(false)

const handleLogout = async () => {
  loggingOut.value = true
  await logout()
  router.push('/login')
}

const badgeClass = computed(() => {
  return user.value?.role === 'admin'
    ? 'bg-purple-100 text-purple-800 border border-purple-200'
    : 'bg-blue-100 text-blue-800 border border-blue-200'
})


const isExporting = ref(false)

const onExportClick = async () => {
  if (isExporting.value) return

  isExporting.value = true

  try {
    await handleExport()
  } catch (error) {
    console.error('Error al exportar:', error)
  } finally {
    isExporting.value = false
  }
}

const handleExport = async () => {
  try {
    const token = localStorage.getItem('token')
    const response = await fetch('http://localhost:8000/api/users-export', {
      headers: {
        Authorization: `Bearer ${token}`,
        Accept: 'application/json'
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
    throw err
  }
}
</script>


<style scoped>
.animate-fade-in-up {
  animation: fadeInUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
  opacity: 0;
  transform: translateY(20px);
}

@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>