<template>
  <nav
    class="navbar navbar-expand-lg navbar-light container"
    style="background-color: white"
  >
    <div class="container-fluid">
      <router-link to="/" class="navbar-brand" style="color: black"
        >TechBallers</router-link
      >

      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarNav"
        aria-controls="navbarNav"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item">
            <router-link
              to="/players"
              class="nav-link"
              :class="{ 'text-muted': isActivePage('/players') }"
              style="color: black"
              >Joueurs</router-link
            >
          </li>
          <li class="nav-item">
            <router-link
              to="/club-info"
              class="nav-link"
              :class="{ 'text-muted': isActivePage('/club-info') }"
              style="color: black"
              >Info du Club</router-link
            >
          </li>
          <li class="nav-item">
            <router-link
              to="/news"
              class="nav-link"
              :class="{ 'text-muted': isActivePage('/news') }"
              style="color: black"
              >Actualité</router-link
            >
          </li>
          <li class="nav-item">
            <router-link
              to="/manage-team"
              class="nav-link"
              :class="{ 'text-muted': isActivePage('/manage-team') }"
              style="color: black"
              >Équipes</router-link
            >
          </li>

          <li class="nav-item">
            <router-link
              to="/add-player"
              class="nav-link"
              :class="{ 'text-muted': isActivePage('/add-player') }"
              style="color: black"
              >Ajouter Joueur</router-link
            >
          </li>

          <li class="nav-item">
            <router-link
              to="/login"
              class="nav-link"
              :class="{ 'text-muted': isActivePage('/login') }"
              style="color: black"
              >Connexion</router-link
            >
          </li>
          
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  data() {
    return {
      isAuthenticated: localStorage.getItem('isAuthenticated') === 'true'
    };
  },
  methods: {
    isActivePage(page) {
      return this.$route.path === page || (this.$route.path === '/' && page === '/players');
    },

    login() {
      this.isAuthenticated = true;
      localStorage.setItem('isAuthenticated', 'true'); // Storage in localStorage
      this.$router.push('/add-player'); // Redirect to the "Add Player" page
    },

    // Logout method to remove authentication
    logout() {
      this.isAuthenticated = false;
      localStorage.removeItem('isAuthenticated');
      this.$router.push('/login');
    }
  }
};
</script>

<style scoped>
  .navbar-nav .nav-link:hover {
    color: #b0afaf !important;
  }

  .navbar-nav .nav-link.text-muted {
    color: #e0e0e0 !important;
  }
</style>
