import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'
import path from 'path'


// https://vite.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    vueDevTools(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
      '@tinymce':fileURLToPath(new URL('./node_modules/@tinymce', import.meta.url)),
    },
  },
  optimizeDeps: {
    include: ['@tinymce/tinymce-vue'], 
  },
})
