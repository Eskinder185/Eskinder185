import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// CHANGE THIS to the exact repo name (case-sensitive)
const repo = 'YOUR_REPO_NAME' // e.g., 'QuizForge', 'neon-meme-machine', 'CodeRush'

export default defineConfig({
  plugins: [react()],
  base: `/${repo}/`,
})