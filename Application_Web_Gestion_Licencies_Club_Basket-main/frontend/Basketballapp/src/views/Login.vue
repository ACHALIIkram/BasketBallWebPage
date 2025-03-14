<template>
  <div v-if="isAuthenticated" class="d-flex justify-content-center align-items-center vh-100">
    <div class="box">
      <div class="text-center">
        <h1>Déjà connecté</h1>
        <p>Vous êtes déjà connecté. <router-link to="/add-player">Accéder à la page d'ajout de joueur</router-link></p>
        <button @click="logout" class="btn btn-danger mt-4 w-100">Se déconnecter</button>
      </div>
    </div>
  </div>

  <div v-else class="d-flex justify-content-center align-items-center vh-100">
    <div class="box">
      <div class="text-center">
        <h1 class="mb-1">Formulaire de connexion</h1>
        <p class="mb-4">pour les admins</p>
      </div>
      <form @submit.prevent="login">
        <div class="form-group">
          <label for="login">Login</label>
          <input
            type="text"
            v-model="loginData.login"
            class="form-control mt-2"
            id="login"
            placeholder="lebron"
          />
        </div>
        <div class="form-group mt-4">
          <label for="password">Mot de passe</label>
          <input
            type="password"
            v-model="loginData.password"
            class="form-control mt-2"
            id="password"
            placeholder="jaimelebasket"
          />
        </div>
        <button type="submit" class="btn btn-primary mt-4 w-100">Se connecter</button>
      </form>
    </div>
  </div>
</template>

<script>

import { API_URL } from '../config';

export default {
  data() {
    return {
      loginData: {
        login: '',
        password: ''
      },
      isAuthenticated: localStorage.getItem('isAuthenticated') === 'true' // Checking the connection status
    };
  },
  methods: {
    async login() {
      // Call to API for connection
      try {
        const response = await fetch(`${API_URL}/admin/login`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(this.loginData)
        });

        if (response.ok) {
          localStorage.setItem('isAuthenticated', 'true'); // Connection successful, storage in localStorage
          this.isAuthenticated = true;
          this.$router.push('/add-player');
        } else {
          alert('Login ou mot de passe incorrect');
        }
      } catch (error) {
        alert('Erreur de connexion');
      }
    },
    logout() {
      // Remove 'isAuthenticated' element from localStorage
      localStorage.removeItem('isAuthenticated');
      this.isAuthenticated = false;
      this.$router.push('/login');
    }
  }
};
</script>

<style>
.box {
  width: 100%;
  max-width: 400px;
  padding: 20px;
  background-color: #fff;
  border: 1px solid #ddd;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
</style>
