<template>
  <footer class="footer bg-dark text-light py-4 mt-5">
    <div class="container-fluid px-5">
      <div class="d-flex justify-content-between align-items-center">
        <div class="footer-logo">
          <router-link to="/" class="navbar-brand text-light fs-5">
            TechBallers
          </router-link>
        </div>

        <div class="d-flex flex-column align-items-end">
          <div class="mb-2">
            <a
              :href="networks.facebook"
              target="_blank"
              class="social-icon me-2"
              aria-label="Facebook"
            >
              <i class="fa-brands fa-facebook-f"></i>
            </a>
            <a
              :href="networks.instagram"
              target="_blank"
              class="social-icon me-2"
              aria-label="Instagram"
            >
              <i class="fa-brands fa-instagram"></i>
            </a>
            <a
              :href="networks.twitter"
              target="_blank"
              class="social-icon"
              aria-label="Twitter"
            >
              <i class="fa-brands fa-twitter"></i>
            </a>
          </div>
          <div>
            <a
              :href="`mailto:${email}`"
              class="text-decoration-none text-light fw-semibold"
            >
              {{ email }}
            </a>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script>
  import clubData from '@/assets/clubInfo.json';
  export default {
    name: 'FooterClub',
    data() {
      return {
        email: clubData.contact.email,
        networks: {
          facebook: '#',
          instagram: '#',
          twitter: '#',
        },
      };
    },
  };
</script>

<style scoped>
  .footer {
    width: 100%;
    border-top: 1px solid #444;
  }

  .footer-logo .club-logo {
    width: 40px;
    height: auto;
  }

  .social-icon {
    font-size: 1.2rem;
    color: #ffffff;
    transition: color 0.3s ease;
  }

  .social-icon:hover {
    color: #007bff;
  }

  a.text-light:hover {
    color: #007bff;
    text-decoration: underline;
  }
</style>
