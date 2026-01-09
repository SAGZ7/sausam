<template>
  <div class="min-h-screen relative flex items-center justify-center bg-gradient-to-b from-gray-50 via-white to-white overflow-hidden">
    
    <div 
      class="absolute inset-0 w-full h-full bg-cover bg-center bg-no-repeat z-0 opacity-90 transition-all duration-1000"
      :class="{ 'scale-105 filter blur-sm': showModal, 'scale-100 blur-0': !showModal }"
      :style="{ backgroundImage: `url(${moreliaBg})` }"
    ></div>

    <Transition name="fade">
      <div v-if="loading" class="absolute bottom-24 left-1/2 transform -translate-x-1/2 z-50 flex flex-col items-center justify-center">
        <svg class="animate-spin h-10 w-10 text-gray-800 mb-3" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
          <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
        </svg>
        <span class="text-gray-600 font-medium text-sm animate-pulse tracking-widest uppercase">
          {{ t.login.loading || 'Cargando...' }}
        </span>
      </div>
    </Transition>
    
    <Transition name="fade-slide">
      <div v-if="showModal" class="absolute top-6 right-6 z-20">
        <div class="flex gap-1 bg-white/90 backdrop-blur-sm rounded-full shadow-lg p-1 border border-gray-100">
          <button
            @click="setLocale('es')"
            class="px-4 py-1.5 rounded-full text-xs font-bold transition-all duration-300 transform"
            :class="locale === 'es' ? 'bg-gray-800 text-white shadow-md scale-105' : 'text-gray-600 hover:bg-gray-100'"
          >
            MX
          </button>
          <button
            @click="setLocale('en')"
            class="px-4 py-1.5 rounded-full text-xs font-bold transition-all duration-300 transform"
            :class="locale === 'en' ? 'bg-gray-800 text-white shadow-md scale-105' : 'text-gray-600 hover:bg-gray-100'"
          >
            US
          </button>
        </div>
      </div>
    </Transition>

    <div class="relative z-10 w-full max-w-md mx-4 flex flex-col items-center">
      
      <Transition name="fade-scale" mode="out-in">
        <div v-if="showModal" class="w-full bg-white/90 backdrop-blur-md rounded-2xl shadow-[0_8px_30px_rgb(0,0,0,0.12)] border border-white/50 p-8">
          
          <div class="text-center mb-8">
            <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-tr from-gray-700 to-gray-900 rounded-2xl shadow-lg mb-4 transform rotate-3 hover:rotate-0 transition-transform duration-300">
              <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path>
              </svg>
            </div>
            <h1 class="text-3xl font-extrabold text-gray-800 tracking-tight">
              {{ t.login.title }}
            </h1>
            <p class="text-gray-600 text-sm mt-2 font-medium">
              {{ t.login.subtitle }}
            </p>
          </div>

          <form @submit.prevent="handleLogin" class="space-y-5">
            <div>
              <label class="block text-gray-700 text-xs font-bold uppercase tracking-wide mb-1.5 ml-1">
                {{ t.login.email }}
              </label>
              <div class="relative group">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none transition-colors group-focus-within:text-gray-800">
                  <svg class="h-5 w-5 text-gray-400 group-focus-within:text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"></path>
                  </svg>
                </div>
                <input
                  v-model="form.email"
                  type="email"
                  class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-xl leading-5 bg-white/70 text-gray-900 placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-gray-500/50 focus:border-gray-700 focus:bg-white transition-all duration-200"
                  placeholder="admin@sausam.com"
                  required
                />
              </div>
            </div>

            <div>
              <label class="block text-gray-700 text-xs font-bold uppercase tracking-wide mb-1.5 ml-1">
                {{ t.login.password }}
              </label>
              <div class="relative group">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <svg class="h-5 w-5 text-gray-400 group-focus-within:text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                  </svg>
                </div>
                <input
                  v-model="form.password"
                  :type="showPassword ? 'text' : 'password'"
                  class="block w-full pl-10 pr-10 py-3 border border-gray-300 rounded-xl leading-5 bg-white/70 text-gray-900 placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-gray-500/50 focus:border-gray-700 focus:bg-white transition-all duration-200"
                  placeholder="••••••••"
                  required
                />
                <button
                  type="button"
                  @click="showPassword = !showPassword"
                  class="absolute inset-y-0 right-0 pr-3 flex items-center cursor-pointer"
                >
                  <svg v-if="!showPassword" class="h-5 w-5 text-gray-400 hover:text-gray-800 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                  </svg>
                  <svg v-else class="h-5 w-5 text-gray-700 hover:text-gray-900 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21"></path>
                  </svg>
                </button>
              </div>
            </div>

            <div v-if="error" class="p-3 bg-red-50/90 backdrop-blur-sm border border-red-200 rounded-lg animate-shake flex items-center">
              <svg class="h-5 w-5 text-red-600 mr-2 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
              </svg>
              <span class="text-sm text-red-700 font-medium">{{ error || t.login.error }}</span>
            </div>

            <button
              type="submit"
              class="w-full flex items-center justify-center space-x-2 py-3.5 px-4 border border-transparent rounded-xl shadow-md text-sm font-bold text-white bg-gray-800 hover:bg-gray-900 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 transform hover:-translate-y-0.5 transition-all duration-200"
              :disabled="loading"
              :class="{ 'opacity-75 cursor-wait': loading }"
            >
              <svg v-if="loading" class="animate-spin -ml-1 mr-2 h-5 w-5 text-white" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              <span>{{ loading ? t.login.loading : t.login.submit }}</span>
            </button>
          </form>

          <div class="mt-8 pt-6 border-t border-gray-200">
            <p class="text-center text-xs text-gray-500 uppercase tracking-widest font-semibold mb-4">{{ t.login.demoUsers }}</p>
            <div class="grid grid-cols-1 gap-2 text-xs">
              <div class="flex items-center justify-between p-2.5 bg-gray-50 rounded-lg border border-gray-200 hover:bg-white transition-colors cursor-help group">
                <div class="flex items-center">
                  <div class="w-2 h-2 rounded-full bg-gray-600 mr-2 group-hover:animate-pulse"></div>
                  <span class="font-bold text-gray-700">{{ t.login.admin }}</span>
                </div>
                <span class="font-mono text-gray-600 bg-white px-2 py-0.5 rounded border border-gray-200">admin@sausam.com</span>
              </div>
              <div class="flex items-center justify-between p-2.5 bg-gray-50 rounded-lg border border-gray-200 hover:bg-white transition-colors">
                <div class="flex items-center">
                  <div class="w-2 h-2 rounded-full bg-gray-800 mr-2 group-hover:animate-pulse"></div>
                  <span class="font-bold text-gray-700">{{ t.login.user }}</span>
                </div>
                <span class="font-mono text-gray-600 bg-white px-2 py-0.5 rounded border border-gray-200">user@sausam.com</span>
              </div>
            </div>
          </div>
        </div>
      </Transition>
      
      <Transition name="fade">
        <div v-if="showModal" class="text-center mt-4 relative z-10">
          <p class="text-xs text-gray-500 font-medium">© 2026 SAUSAM - Morelia, Mich.</p>
        </div>
      </Transition>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuth } from '../composables/useAuth'
import { useLocale } from '../composables/useLocale'
import moreliaBg from '../assets/morelia-skyline.png'

const router = useRouter()
const { login } = useAuth()
const { locale, t, setLocale } = useLocale()

const form = ref({
  email: '',
  password: ''
})

const loading = ref(false)
const error = ref('')
const showPassword = ref(false)

// 👉 Control del modal
const showModal = ref(true)

const handleLogin = async () => {
  error.value = ''

  // 1. Ocultamos el modal
  showModal.value = false

  // 2. Esperamos un poco para que termine la animación del modal
  setTimeout(() => {
    loading.value = true
  }, 300)

  try {
    await login(form.value)
    router.push('/')
  } catch (err) {
    loading.value = false
    error.value = err.response?.data?.message || t.value.login.error

    // 3. Si falla, mostramos de nuevo el modal
    showModal.value = true
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.fade-scale-enter-active,
.fade-scale-leave-active {
  transition: all 0.5s ease;
}

.fade-scale-enter-from,
.fade-scale-leave-to {
  opacity: 0;
  transform: scale(0.95);
}

.fade-slide-enter-active,
.fade-slide-leave-active {
  transition: all 0.5s ease;
}

.fade-slide-enter-from,
.fade-slide-leave-to {
  opacity: 0;
  transform: translateY(-20px);
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>