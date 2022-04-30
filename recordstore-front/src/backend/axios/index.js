import axios from 'axios'

const API_URL = 'http://localhost:3000'

const securedAxiosInstance = axios.create({
  baseURL: API_URL,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json'
  }
})

const plainAxiosInstance = axios.create({
  baseURL: API_URL,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json'
  }
})

securedAxiosInstance.interceptors.request.use(config => {
  const method = config.method.toUpperCase()
  if (method !== 'OPTIONS' && method !== 'GET') {
    config.headers = {
      ...config.headers,
      'X-CSRF-TOKEN': this.$store.state.csrf
    }
  }
  return config
})

securedAxiosInstance.interceptors.response.use(null, error => {
  if (error.response && error.response.config && error.response.status === 401) {
    return plainAxiosInstance.post('/refresh', {}, { headers: { 'X-CSRF-TOKEN': this.$store.state.csrf } })
        .then(response => {
            this.$store.state.csrf = response.data.csrf
            this.$store.state.signedIn = true

          let retryConfig = error.response.config
          retryConfig.headers['X-CSRF-TOKEN'] = this.$store.state.csrf
          return plainAxiosInstance.request(retryConfig)
        }).catch(error => {
          delete this.$store.state.csrf
          delete this.$store.state.signedIn

          location.replace('/')
          return Promise.reject(error)
        })
  } else {
    return Promise.reject(error)
  }
})

export { securedAxiosInstance, plainAxiosInstance }
