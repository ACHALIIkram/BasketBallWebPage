<template>
  <div class="player-details">
    <h1 class="text-center">Fiche joueur</h1>

    <section class="player-card-section">
      <div class="player-info">
        <div class="player-photo-container">
          <img :src="player.photo" :alt="player.lastName" class="player-photo" />
        </div>
        <div class="player-info-details">
          <h2 class="player-name">{{ player.firstName }} {{ player.lastName }}</h2>
          <button class="favoris-button" @click="toggleFavorite">
            <i class="fa fa-star" :class="{ 'active': isFavorite }"></i>
            {{ isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris' }}
          </button>
        </div>
      </div>
    </section>

    <section class="stats-section">
      <h2 class="stats-title">Statistiques</h2>
      <div class="stats-grid">
        <div class="stat-item">
          <span class="stat-label">Points : </span>
          <span class="stat-value">{{ player.stats.Points }}</span>
        </div>
        <div class="stat-item">
          <span class="stat-label">Rebonds : </span>
          <span class="stat-value">{{ player.stats.Rebounds }}</span>
        </div>
        <div class="stat-item">
          <span class="stat-label">3 Points : </span>
          <span class="stat-value">
            {{ player.stats.ThreePtsFieldGoalsMade }} /
            {{ player.stats.ThreePtsFieldGoalsAttempted }}
          </span>
        </div>
        <div class="stat-item">
          <span class="stat-label">Lancers francs : </span>
          <span class="stat-value">
            {{ player.stats.FreeThrowMade }} /
            {{ player.stats.FreeThrowAttempted }}
          </span>
        </div>
      </div>
    </section>

    <section class="dashboard-section">
      <h2 class="dashboard-title">Dashboard des Statistiques</h2>
      <div class="dashboard-grid">
        <div class="chart-container">
          <canvas id="pointsChart"></canvas>
        </div>
        <div class="chart-container">
          <canvas id="accuracyChart"></canvas>
        </div>
      </div>
    </section>
  </div>
</template>


<script>
  import { API_URL } from '../config';

  export default {
  name: "PlayerDetails",
  data() {
    return {
      player: null,
      isFavorite: false,
    };
  },
  async created() {
    const playerId = this.$route.params.id;
    await this.fetchPlayerDetails(playerId);
    this.createCharts();
  },
  methods: {
    async fetchPlayerDetails(playerId) {
      try {
        const response = await fetch(`${API_URL}/players/players/${playerId}`);
        if (!response.ok) {
          throw new Error("Erreur de chargement des données du joueur");
        }
        const playerData = await response.json();
        this.player = {
          id: playerData.idUser,
          firstName: playerData.user.FirstName,
          lastName: playerData.user.LastName,
          photo: `/src/assets/img_player/${playerData.user.LastName}.png`,
          stats: playerData.statistic,
        };
      } catch (error) {
        console.error("Erreur lors de la récupération des données du joueur:", error);
      }
    },
    toggleFavorite() {
      this.isFavorite = !this.isFavorite;
    },
    createCharts() {
      if (!this.player || !this.player.stats) return;

      new Chart(document.getElementById("pointsChart"), {
        type: "bar",
        data: {
          labels: ["Points", "Rebonds", "3 Points", "Lancers Francs"],
          datasets: [
            {
              label: "Statistiques",
              data: [
                this.player.stats.Points,
                this.player.stats.Rebounds,
                this.player.stats.ThreePtsFieldGoalsMade,
                this.player.stats.FreeThrowMade,
              ],
              backgroundColor: ["#3498db", "#1abc9c", "#f1c40f", "#e74c3c"],
            },
          ],
        },
        options: {
          responsive: true,
          plugins: {
            legend: {
              display: false,
            },
          },
        },
      });

      new Chart(document.getElementById("accuracyChart"), {
        type: "doughnut",
        data: {
          labels: [
            "3 Points réussis",
            "3 Points manqués",
            "LF réussis",
            "LF manqués",
          ],
          datasets: [
            {
              data: [
                this.player.stats.ThreePtsFieldGoalsMade,
                this.player.stats.ThreePtsFieldGoalsAttempted - this.player.stats.ThreePtsFieldGoalsMade,
                this.player.stats.FreeThrowMade,
                this.player.stats.FreeThrowAttempted - this.player.stats.FreeThrowMade,
              ],
              backgroundColor: ["#2ecc71", "#e74c3c", "#9b59b6", "#f39c12"],
            },
          ],
        },
        options: {
          responsive: true,
          plugins: {
            legend: {
              position: "bottom",
            },
          },
        },
      });
    },
  },
};

</script>

<style scoped>
.player-details {
  padding: 20px;
  margin: 0 100px;
}

h1 {
  font-size: 2.5rem;
  font-weight: bold;
  color: #333;
  margin-bottom: 30px;
}

.player-card-section {
  display: flex;
  justify-content: center;
  margin-bottom: 30px;
  margin-top: 50px;
}

.player-info {
  display: flex;
  align-items: center;
  gap: 20px;
  background-color: #ffffff;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.player-photo-container {
  display: flex;
  justify-content: center;
  align-items: center;
}

.player-photo {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  border: 3px solid #007bff;
  object-fit: cover;
}

.player-info-details {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
}

.player-name {
  font-size: 1.8rem;
  font-weight: bold;
  color: #333;
  margin-bottom: 10px;
}

.favoris-button {
  display: flex;
  align-items: center;
  gap: 8px;
  background-color: transparent;
  border: none;
  font-size: 1rem;
  color: #007bff;
  cursor: pointer;
  transition: color 0.3s;
}

.favoris-button i {
  transition: color 0.3s, transform 0.3s;
}

.favoris-button i.active {
  color: #ffc107;
  transform: scale(1.2);
}

.favoris-button:hover {
  color: #0056b3;
}

.favoris-button:hover i {
  color: #ffc107;
}

.stats-section {
  margin-top: 40px;
}

.stats-title {
  font-size: 1.8rem;
  color: #444;
  margin-bottom: 30px;
  text-align: center;
  margin-top: 80px;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
  gap: 15px;
}

.stat-item {
  background: #fff;
  padding: 15px;
  border-radius: 6px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
  text-align: center;
}

.dashboard-section {
  margin-top: 50px;
}

.dashboard-title {
  font-size: 1.8rem;
  color: #444;
  margin-bottom: 50px;
  text-align: center;
  margin-top: 80px;

}

.dashboard-grid {
  display: flex;
  justify-content: space-evenly;
  align-items: center;
  gap: 20px;
}

.chart-container {
  flex: 1;
  max-width: 280px;
}

.chart-container canvas {
  width: 100%;
  height: auto;
}

.chart-container {
  transition: transform 0.3s ease-in-out;
}

.chart-container:hover {
  transform: scale(1.05);
}
</style>
