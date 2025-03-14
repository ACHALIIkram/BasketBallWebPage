<template>
  <div class="container mt-4">
    <h1 class="text-center mb-1">Informations du Club</h1>
    <p class="text-center mb-5">Détails sur le club</p>

    <h2 class="text-body-emphasis mb-4">Nos Séances</h2>
    <div class="table-responsive">
      <table
        class="table table-bordered table-striped align-middle text-center"
      >
        <thead class="table-dark">
          <tr>
            <th v-for="(sessions, day) in weeks" :key="day">
              {{ formatDay(day) }}
            </th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td v-for="(sessions, day) in weeks" :key="day">
              <div
                class="mb-3"
                v-for="(session, index) in sessions"
                :key="index"
              >
                <span
                  class="badge me-1 mb-2"
                  :class="getLevelBadge(session.team)"
                >
                  {{ getTeamLevel(session.team) }} </span
                ><br />
                {{ session.schedule }}<br />
                <span class="text-muted">{{ session.place }}</span>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <h2 class="text-body-emphasis mt-5 mb-4">Modalités d'inscription</h2>
    <p>
      Pour rejoindre notre club, envoyez les documents requis à
      <a :href="`mailto:${email}`" class="text-primary fw-semibold">{{
        email
      }}</a
      >.
    </p>
    <ul class="list-group">
      <li
        v-for="(doc, index) in registration.docs"
        :key="index"
        class="list-group-item d-flex justify-content-between align-items-center"
      >
        {{ doc }}
        <a href="#" class="btn btn-outline-primary btn-sm">
          <i class="bi bi-file-earmark-word"></i> Télécharger
        </a>
      </li>
    </ul>

    <h2 class="text-body-emphasis mt-5 mb-4">Cotisation annuelle :</h2>
    <table class="table table-striped">
      <thead>
        <tr>
          <th><strong>Catégorie</strong></th>
          <th><strong>Tarif</strong></th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(categories, fee) in registration.fees" :key="fee">
          <td>Pour les {{ formatCategories(categories) }}</td>
          <td>{{ fee }}</td>
        </tr>
      </tbody>
    </table>

    <h2 class="text-body-emphasis mt-5 mb-4">Nos Gymnases</h2>

    <div class="mb-5 d-flex justify-content-center">
      <iframe
        src="https://www.google.com/maps/d/u/1/embed?mid=1bZg00z0pifadp5lRX1QmM1B6pzH4PZ4&ehbc=2E312F&noprof=1"
        width="100%"
        height="450px"
        style="border: 0; border-radius: 10px"
        allowfullscreen=""
        loading="lazy"
        class="shadow-sm"
      ></iframe>
    </div>

    <div class="row gy-4 align-items-stretch">
      <div
        class="col-lg-4 col-md-6"
        v-for="(gym, index) in gymnases"
        :key="index"
      >
        <div class="card shadow-sm h-100 border-0">
          <div class="card-body d-flex flex-column">
            <h5 class="card-title mb-3 text-center">{{ gym.name }}</h5>
            <p class="card-text text-center flex-grow-1">
              {{ gym.address }}<br />
              {{ gym.city }}
            </p>
            <div class="text-center mt-auto">
              <a
                :href="gym.site"
                class="btn btn-outline-primary btn-sm"
                target="_blank"
              >
                Voir sur Google Maps
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="row mt-5 gy-4">


      <div class="col-lg-6">
        <div class="card shadow-sm border-0 h-100">
          <div class="card-body p-4">
            <h2 class="text-body-emphasis mb-4">Nos Contacts</h2>
            <p class="mb-3">
              <strong class="d-block mb-2">Bureau :</strong>
              <span class="text-muted">{{ office }}</span>
            </p>
            <p class="mb-3">
              <strong class="d-block mb-2">Email :</strong>
              <a
                :href="`mailto:${email}`"
                class="text-decoration-none text-primary fw-semibold"
              >
                {{ email }}
              </a>
            </p>
            <p>
              <strong class="d-block mb-2">Réseaux :</strong>
              <a
                :href="networks.facebook"
                target="_blank"
                class="social-icon me-2"
              >
                <i class="fa-brands fa-facebook-f"></i>
              </a>
              <a
                :href="networks.instagram"
                target="_blank"
                class="social-icon me-2"
              >
                <i class="fa-brands fa-instagram"></i>
              </a>
              <a :href="networks.twitter" target="_blank" class="social-icon">
                <i class="fa-brands fa-twitter"></i>
              </a>
            </p>
          </div>
        </div>
      </div>

      <div class="col-lg-6">
        <div class="card shadow-sm border-0 h-100">
          <div class="card-body p-4">
            <h2 class="text-body-emphasis mb-4">Nos Partenaires</h2>
            <ul class="list-unstyled d-flex flex-column align-items-center">
              <li
                v-for="(partner, index) in partners"
                :key="index"
                class="mb-3 d-flex align-items-center w-100"
              >
                <a
                  :href="partner.site"
                  target="_blank"
                  class="d-flex align-items-center text-decoration-none w-100 link-hover"
                >
                  <img
                    :src="partner.logo"
                    class="partner-logo me-3 flex-shrink-0"
                    alt="Logo partenaire"
                  />
                  <span class="fw-semibold text-secondary">{{
                    partner.name
                  }}</span>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import clubData from '@/assets/clubInfo.json';

  export default {
    name: 'ClubInfo',

    data() {
      return {
        weeks: {},
        gymnases: clubData.gymnases,
        partners: clubData.partners,
        networks: clubData.contact.networks,
        registration: clubData.registration,
        email: clubData.contact.email,
        office: clubData.contact.office,
      };
    },

    async created() {
      try {
        // 1. Collect the trainings
        const response = await fetch(
          'http://127.0.0.1:8000/api/training/trainings/'
        );
        const sessions = await response.json();

        // 2. Extract unique team IDs
        const teamIds = [...new Set(sessions.map((session) => session.idTeam))];

        // 3. Retrieve the details of each team
        const teamsData = await Promise.all(
          teamIds.map(async (teamId) => {
            const teamResponse = await fetch(
              `http://127.0.0.1:8000/api/teams/teams/${teamId}`
            );
            return teamResponse.json();
          })
        );

        // 4. Map team names to their ID for quick access
        const teamsMap = teamsData.reduce((map, team) => {
          map[team.idTeam] = team.Name;
          return map;
        }, {});

        // 5. Organize sessions by day of the week
        const daysMap = [
          'lundi',
          'mardi',
          'mercredi',
          'jeudi',
          'vendredi',
          'samedi',
          'dimanche',
        ];
        sessions.forEach((session) => {
          const schedule = `${session.StartHour.slice(0, 5)}-${session.EndHour.slice(0, 5)}`;
          const weekDay = daysMap[session.WeekDay - 1];

          if (!this.weeks[weekDay]) this.weeks[weekDay] = [];

          this.weeks[weekDay].push({
            schedule,
            team: teamsMap[session.idTeam] || 'Équipe inconnue',
            place: session.Place,
          });
        });
      } catch (error) {
        console.error('Erreur lors du chargement des entraînements :', error);
      }
    },
    methods: {
      formatDay(day) {
        return day.charAt(0).toUpperCase() + day.slice(1);
      },
      formatCategories(categories) {
        if (Array.isArray(categories)) {
          const copy = [...categories];
          if (copy.length > 1) {
            const last = copy.pop();
            return `${copy.join(', ')} et ${last}`;
          }
          return copy[0];
        }
        return categories.charAt(0).toUpperCase() + categories.slice(1);
      },
      getLevelBadge(teamName) {
        if (teamName.toLowerCase().includes('poussin')) return 'bg-info';
        if (teamName.toLowerCase().includes('benjamin')) return 'bg-warning';
        if (teamName.toLowerCase().includes('minime')) return 'bg-primary';
        if (teamName.toLowerCase().includes('cadet')) return 'bg-secondary';
        if (teamName.toLowerCase().includes('seniors')) return 'bg-danger';
        if (teamName.toLowerCase().includes('détente')) return 'bg-success';
        return 'bg-light';
      },
      getTeamLevel(teamName) {
        if (teamName.toLowerCase().includes('poussin')) return 'Poussin';
        if (teamName.toLowerCase().includes('benjamin')) return 'Benjamin';
        if (teamName.toLowerCase().includes('minime')) return 'Minime';
        if (teamName.toLowerCase().includes('cadet')) return 'Cadet';
        if (teamName.toLowerCase().includes('seniors')) return 'Seniors';
        if (teamName.toLowerCase().includes('détente')) return 'Loisir';
        return 'Autre';
      },
    },
  };
</script>

<style>
  th {
    padding: 8px;
    text-align: center;
    background-color: #f4f4f4;
  }

  .link-hover {
    text-decoration: none;
    color: inherit;
    transition: all 0.3s ease;
  }
  .link-hover:hover {
    color: #007bff;
    text-decoration: underline;
  }

  .partner-logo {
    width: 60px;
    height: 30px;
    object-fit: contain;
  }
  .card {
    border-radius: 12px;
  }

  .social-icon {
    font-size: 1.5rem;
    color: #495057;
    transition: color 0.3s ease;
  }

  .social-icon:hover {
    color: #007bff;
  }

  .link-hover:hover {
    color: #007bff;
    text-decoration: underline;
  }
</style>
