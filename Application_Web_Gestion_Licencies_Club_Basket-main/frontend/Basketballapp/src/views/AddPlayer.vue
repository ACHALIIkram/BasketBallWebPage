<template>
  <div class="container mt-4">
    <h1 class="text-center mb-4">Ajouter un Nouveau Joueur</h1>

    <!-- Player Form -->
    <form @submit.prevent="submitForm">
      <div class="form-group mb-3">
        <label for="firstName">Prénom</label>
        <input
          type="text"
          id="firstName"
          v-model="player.user.FirstName"
          class="form-control"
          placeholder="Entrez le prénom"
          required
        />
      </div>

      <div class="form-group mb-3">
        <label for="lastName">Nom</label>
        <input
          type="text"
          id="lastName"
          v-model="player.user.LastName"
          class="form-control"
          placeholder="Entrez le nom"
          required
        />
      </div>

      <div class="form-group mb-3">
        <label for="team">Équipe</label>
        <select
          id="team"
          v-model="player.user.idTeam"
          class="form-control"
          required
        >
          <option value="" disabled selected>Choisissez une équipe</option>
          <option v-for="team in teams" :key="team.idTeam" :value="team.idTeam">
            {{ team.Name }}
          </option>
        </select>
      </div>

      <!-- Statistics Section -->
      <h3 class="mt-4">Statistiques</h3>
      <div class="form-group mb-3">
        <label for="rebounds">Rebonds</label>
        <input
          type="number"
          id="rebounds"
          v-model.number="player.statistic.Rebounds"
          class="form-control"
          placeholder="Entrez les rebonds"
          min="0"
          required
        />
      </div>

      <div class="form-group mb-3">
        <label for="points">Points</label>
        <input
          type="number"
          id="points"
          v-model.number="player.statistic.Points"
          class="form-control"
          placeholder="Entrez les points"
          min="0"
          required
        />
      </div>

      <div class="form-group mb-3">
        <label for="threePtsFieldGoalsMade">3Pts Réussis</label>
        <input
          type="number"
          id="threePtsFieldGoalsMade"
          v-model.number="player.statistic.ThreePtsFieldGoalsMade"
          class="form-control"
          placeholder="Entrez les 3 points réussis"
          min="0"
          required
        />
      </div>

      <div class="form-group mb-3">
        <label for="threePtsFieldGoalsAttempted">3Pts Tentés</label>
        <input
          type="number"
          id="threePtsFieldGoalsAttempted"
          v-model.number="player.statistic.ThreePtsFieldGoalsAttempted"
          class="form-control"
          placeholder="Entrez les 3 points tentés"
          min="0"
          required
        />
      </div>

      <div class="form-group mb-3">
        <label for="freeThrowMade">Lancers Francs Réussis</label>
        <input
          type="number"
          id="freeThrowMade"
          v-model.number="player.statistic.FreeThrowMade"
          class="form-control"
          placeholder="Entrez les lancers francs réussis"
          min="0"
          required
        />
      </div>

      <div class="form-group mb-3">
        <label for="freeThrowAttempted">Lancers Francs Tentés</label>
        <input
          type="number"
          id="freeThrowAttempted"
          v-model.number="player.statistic.FreeThrowAttempted"
          class="form-control"
          placeholder="Entrez les lancers francs tentés"
          min="0"
          required
        />
      </div>
      <div v-if="error" class="alert alert-danger mt-3">{{ error }}</div>

      <button type="submit" class="btn btn-primary">Ajouter le Joueur</button>
    </form>
  </div>
</template>

<script>
export default {
  name: "AddPlayer",
  data() {
    return {
      player: {
        user: {
          FirstName: "",
          LastName: "",
          idTeam: null, // Set the team ID
        },
        statistic: {
          Rebounds: 0,
          Points: 0,
          ThreePtsFieldGoalsMade: 0,
          ThreePtsFieldGoalsAttempted: 0,
          FreeThrowMade: 0,
          FreeThrowAttempted: 0,
        },
      },
      teams: [], // Store the list of teams
      error: "",
    };
  },
  async created() {
    await this.fetchTeams();
  },
  methods: {
    async fetchTeams() {
      try {
        const response = await fetch("http://127.0.0.1:8000/api/teams/teams");
        if (!response.ok) {
          throw new Error("Failed to fetch teams");
        }
        this.teams = await response.json();
      } catch (error) {
        console.error(error);
        alert("Une erreur s'est produite lors de la récupération des équipes.");
      }
    },
    validateStatistics() {
      const stats = this.player.statistic;
      if (
        stats.ThreePtsFieldGoalsMade > stats.ThreePtsFieldGoalsAttempted ||
        stats.FreeThrowMade > stats.FreeThrowAttempted
      ) {
        this.error =
          "Les réussites doivent être inférieures ou égales aux tentatives.";
        return false;
      }
      this.error = ""; // Clear error if validation passes
      return true;
    },
    async submitForm() {
      if (!this.validateStatistics()) {
        return;
      }
      try {
        const response = await fetch("http://127.0.0.1:8000/api/players/players", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(this.player),
        });

        if (!response.ok) {
          throw new Error("Failed to add player");
        }

        alert("Le joueur a été ajouté avec succès !");
        this.resetForm();
      } catch (error) {
        console.error(error);
        alert("Une erreur s'est produite lors de l'ajout du joueur.");
      }
    },

    resetForm() {
      this.player = {
        user: {
          FirstName: "",
          LastName: "",
          idTeam: null,
        },
        statistic: {
          Rebounds: 0,
          Points: 0,
          ThreePtsFieldGoalsMade: 0,
          ThreePtsFieldGoalsAttempted: 0,
          FreeThrowMade: 0,
          FreeThrowAttempted: 0,
        },
      };
      this.error="";
    },
  },
};
</script>

<style scoped>
.container {
  max-width: 600px;
  margin: auto;
  background: #fff;
  padding: 2rem;
  border-radius: 8px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.form-control {
  padding: 0.5rem;
  font-size: 1rem;
}

.btn-primary {
  width: 100%;
  padding: 0.75rem;
  font-size: 1.2rem;
}
</style>
