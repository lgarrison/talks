// vite.config.js
// ...existing code...
import { defineConfig } from 'vite'

export default defineConfig({
  server: {
    allowedHosts: ['scclin021'],
    // optionally also allow these if you use them:
    // allowedHosts: ['scclin021', 'localhost', '127.0.0.1', '[::1]'],
  },
})
