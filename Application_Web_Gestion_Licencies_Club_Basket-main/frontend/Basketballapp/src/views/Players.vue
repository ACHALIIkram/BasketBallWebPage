<template>
  <div class="container mt-4">
    <h1 class="text-center">Page des Joueurs</h1>
    <p class="text-center mb-5">Liste des joueurs du club</p>

    <div class="row row-cols-1 row-cols-md-3 g-4">
      <div
        v-for="player in players"
        :key="player.FirstName + player.LastName"
        class="col"
      >
        <div
          class="card player-card"
          @click="goToPlayerDetails(player.idUser)"
        >
          <div class="card-body">
            <div class="info-joueur-carousel">
              <div class="head-info">
                <div class="name-and-button">
                  <span class="name-player">
                    {{ player.FirstName }} {{ player.LastName }}
                  </span>
                </div>
              </div>
              <div class="bottom-info">
                <div class="info-section">
                  <div class="info-line">
                    <span class="label-player">Points : </span>
                    <span class="info">{{ player.stats.Points ?? 'N/A' }}</span>
                  </div>
                  <div class="info-line">
                    <span class="label-player">Rebonds : </span>
                    <span class="info">{{ player.stats.Rebounds ?? 'N/A' }}</span>
                  </div>
                  <div class="info-line">
                    <span class="label-player">3 Points : </span>
                    <span class="info">{{ player.stats.ThreePtsFieldGoalsMade ?? 'N/A'}} /
                      {{ player.stats.ThreePtsFieldGoalsAttempted ?? 'N/A'}}</span>
                  </div>
                  <div class="info-line">
                    <span class="label-player">Lancers francs : </span>
                    <span class="info">{{ player.stats.FreeThrowMade ?? 'N/A' }} /
                      {{ player.stats.FreeThrowAttempted ?? 'N/A' }}</span>
                  </div>
                </div>
              </div>
            </div>
            <div class="player-logo">
              <img
                :src="getPlayerPhoto(player.LastName)"
                class="player-img-rectangular"
                alt="Player photo"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>



<script>
export default {
  name: 'Players',
  data() {
    return {
      players: [],
    };
  },
  async created() {
    try {
      const response = await fetch('http://127.0.0.1:8000/api/users/users');
      if (!response.ok) {
        throw new Error('Erreur de chargement des joueurs');
      }
      const playersData = await response.json();

      const teamIds = playersData.map(player => player.idTeam);
      const uniqueTeamIds = [...new Set(teamIds)];

      const teamsData = await Promise.all(
        uniqueTeamIds.map(teamId => this.getTeamById(teamId))
      );

      this.players = await Promise.all(
        playersData.map(async (player) => {
          const team = teamsData.find(team => team.idTeam === player.idTeam);

          const stats = await this.getPlayerStats(player.idUser);

          return {
            ...player,
            teamName: team ? team.Name : 'Unknown Team',
            stats: stats || {},
          };
        })
      );
    } catch (error) {
      console.error('Erreur lors de la récupération des joueurs:', error);
    }
  },

  methods: {
    getPlayerPhoto(lastName) {
      const logos = {
        Doncic: '/src/assets/img_player/Doncic.avif',
        Antetokounmpo: '/src/assets/img_player/Antetokounmpo.webp',
        James: '/src/assets/img_player/James.png',
        Curry: '/src/assets/img_player/Curry.png',
        Durant: '/src/assets/img_player/Durant.webp',
        Leonard: '/src/assets/img_player/Leonard.png',
        Tatum: '/src/assets/img_player/Tatum.avif',
        Embiid: '/src/assets/img_player/Embiid.webp',
        Lillard: '/src/assets/img_player/Lillard.webp',
        Jokic: '/src/assets/img_player/Jokic.avif',
        Kerr: '/src/assets/img_player/Kerr.avif',
        Spoelstra: '/src/assets/img_player/Spoelstra.webp',
        Rivers: '/src/assets/img_player/Rivers.webp',
        Popovich: '/src/assets/img_player/Popovich.webp',
        Nurse: '/src/assets/img_player/Nurse.webp',
      };
      return logos[lastName] || '/src/assets/img_player/default-player.png';
    },

    async getTeamById(teamId) {
      try {
        const response = await fetch(`http://127.0.0.1:8000/api/teams/teams/${teamId}`);
        if (!response.ok) {
          throw new Error('Erreur de chargement de l\'équipe');
        }
        const teamData = await response.json();
        return teamData;
      } catch (error) {
        console.error('Erreur lors de la récupération des données de l\'équipe:', error);
        return { id: teamId, name: 'Unknown Team' };
      }
    },

    async getPlayerStats(playerId) {
      try {
        const response = await fetch(`http://127.0.0.1:8000/api/players/players/${playerId}`);
        if (!response.ok) {
          throw new Error(`Erreur de chargement des statistiques du joueur: ${response.statusText}`);
        }
        const statsData = await response.json();
        return statsData.statistic || {};
      } catch (error) {
        console.error('Erreur lors de la récupération des statistiques du joueur:', error);
        return {};
      }
    },

    goToPlayerDetails(playerId) {
      this.$router.push({ name: 'PlayerDetails', params: { id: playerId } });
    },
  },
};
</script>

<style scoped>

.player-card {
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  background-color: #fff;
  position: relative;
  display: flex;
  flex-direction: row;
  cursor: pointer;
}

.player-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
}


.card-body {
  padding: 20px;
  background: linear-gradient(145deg, #f5f5f5, #e2e2e2);
  display: flex;
  align-items: center;
  width: 100%;
}

.info-joueur-carousel {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  flex-grow: 1;
  margin-right: 20px;
}

.head-info {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.name-and-button {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.name-player {
  font-size: 1.5rem;
  font-weight: bold;
}

.bottom-info {
  margin-top: 15px;
  position: relative;
}

.bottom-info .info-section {
  padding-left: 25px;
}

.bottom-info .info-section:before {
  content: "";
  position: absolute;
  top: 10px;
  left: 0;
  height: 86%;
  width: 1px;
  background-color: #e0e0e0;
}

.info-line {
  margin-bottom: 12px;
}

.label-player {
  font-size: 0.9rem;
  color: #777;
  margin-bottom: 6px;
  margin-right: 5px;
}

.info {
  font-weight: 600;
  color: #555;
}

.player-logo {
  display: flex;
  justify-content: center;
  height: 100%;
}

.player-img-rectangular {
  width: 100%;
  height: auto;
  object-fit: cover;
  border-radius: 0;
  max-width: 150px;
}

.card:hover {
  transform: translateY(-10px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
}

.title {
  font-size: 2.5rem;
  font-weight: 800;
  color: #1e2a38;
}

.subtitle {
  font-size: 1.2rem;
  color: #666;
}


</style>
