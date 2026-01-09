import { ref, computed } from 'vue'
import es from '../locales/es'
import en from '../locales/en'

const locale = ref(localStorage.getItem('locale') || 'es')

const translations = {
  es,
  en
}

export function useLocale() {
  const t = computed(() => translations[locale.value])

  const setLocale = (newLocale) => {
    locale.value = newLocale
    localStorage.setItem('locale', newLocale)
  }

  const translate = (key, params = {}) => {
    const keys = key.split('.')
    let value = t.value
    
    for (const k of keys) {
      value = value[k]
      if (!value) return key
    }
    
    // Reemplazar parámetros {name}
    if (typeof value === 'string' && params) {
      Object.keys(params).forEach(param => {
        value = value.replace(`{${param}}`, params[param])
      })
    }
    
    return value
  }

  return {
    locale,
    t,
    setLocale,
    translate
  }
}