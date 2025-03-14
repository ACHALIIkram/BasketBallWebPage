import './assets/main.css';
import router from './router';

import { createApp } from 'vue';
import App from './App.vue';

// Import Bootstrap CSS
import 'bootstrap/dist/css/bootstrap.min.css';

// Import Bootstrap JavaScript
import 'bootstrap/dist/js/bootstrap.bundle.min.js';

// Import Fontawesome
import 'https://kit.fontawesome.com/aa744576be.js'

// Import chart.js
import 'https://cdn.jsdelivr.net/npm/chart.js'

createApp(App).use(router).mount('#app');
