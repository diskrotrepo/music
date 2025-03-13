import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import CreateView from '../views/CreateView.vue'
import SettingsView from '../views/SettingsView.vue'
import LibraryView from '@/views/LibraryView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      component: HomeView
    },
    {
      path: '/create',
      component: CreateView
    },
    {
      path: '/library',
      component: LibraryView
    },
    {
      path: '/settings',
      component: SettingsView
    },

  ]
})

export default router
