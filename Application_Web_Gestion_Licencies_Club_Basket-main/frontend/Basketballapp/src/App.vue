<template>
  <div id="app" class="container-fluid px-0">
    <NavBar />
    <router-view></router-view>
    <FooterClub />
  </div>
</template>

<script>
import NavBar from './components/NavBar.vue';
import Footer from './components/Footer.vue';


export default {
  components: {
    NavBar,
    FooterClub: Footer,
  }
};
</script>

<style>

#app {
  max-width: 100% !important;
  width: 100%;
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

</style>
