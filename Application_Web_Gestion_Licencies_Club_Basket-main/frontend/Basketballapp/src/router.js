import { createRouter, createWebHistory } from 'vue-router';
import Players from './views/Players.vue';
import News from './views/News.vue';
import ClubInfo from './views/ClubInfo.vue';
import AddPlayer from './views/AddPlayer.vue';
import Login from './views/Login.vue';
import ManageTeam from './views/ManageTeam.vue';
import PlayerDetails from './views/PlayerDetails.vue';

const routes = [
  { path: '/', component: Players },
  { path: '/players', component: Players },
  { path: '/news', component: News },
  { path: '/club-info', component: ClubInfo },
  { path: '/add-player', component: AddPlayer },
  
  // Protected route for adding players
  {
    path: '/add-player',
    component: AddPlayer,
    beforeEnter: (to, from, next) => {
      const isAuthenticated = localStorage.getItem('isAuthenticated');

      if (isAuthenticated) {
        next(); // Allows access to the page if the user is logged in
      } else {
        next('/login'); // Redirect to login page if user is not logged in
      }
    },
  },

  { path: '/login', component: Login },
  { path: '/manage-team', component: ManageTeam },
  {
    path: '/',
    name: 'Players',
    component: Players,
  },
  {
    path: '/player/:id',
    name: 'PlayerDetails',
    component: PlayerDetails,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
