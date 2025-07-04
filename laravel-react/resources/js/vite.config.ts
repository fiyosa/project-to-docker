import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig(({ command }) => {
  return {
    plugins: [react()],
    base: command === 'serve' ? '/' : '/build',

    publicDir: '../../public',
    envDir: '../..',

    server: {
      port: 3000,
      host: 'localhost',
    },

    preview: {
      port: 3001,
      host: 'localhost',
    },

    esbuild: {
      legalComments: 'none', // remove copyright notice from bundle
      drop: command === 'serve' ? [] : ['console'], // remove console.log in production
    },

    build: {
      outDir: '../../public/build',
      copyPublicDir: false,
      emptyOutDir: true,
      manifest: false,
      rollupOptions: {
        input: './src/main.tsx',
        output: {
          entryFileNames: 'main.js',
          assetFileNames: (assetInfo) => {
            if (assetInfo.name === 'main.css') return 'main.css'
            return 'assets/[hash].[ext]'
          },
        },
      },
    },
  }
})
