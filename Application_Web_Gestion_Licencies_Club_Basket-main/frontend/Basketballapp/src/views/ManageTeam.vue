<template>
  <div class="container mt-4">
    <h1 class="text-center mb-1">Team and Training Management</h1>

    <!-- Team Management -->
    <div v-for="(team, index) in teams" :key="team.id" class="row mb-3">
      <div class="d-flex mt-3 justify-content-between align-items-center">
        <h2>Manage {{ team.name }}</h2>
        <a @click="openAddPlayerModal(team.id)">
          <i class="fa-solid fa-plus"></i>
        </a>
      </div>
      <table class="table table-hover">
        <thead>
          <tr class="table-secondary">
            <th scope="col">Last Name</th>
            <th scope="col">First Name</th>
            <th scope="col">Actions</th>
          </tr>
        </thead>
        <tbody class="table-group-divider">
          <!-- Display if no players exist -->
          <tr
            v-if="
              !playersByTeam[team.id] || playersByTeam[team.id].length === 0
            "
          >
            <td colspan="3" class="text-center text-muted">
              No players in this team
            </td>
          </tr>

          <!-- Display players -->
          <tr v-for="player in playersByTeam[team.id]" :key="player.idUser">
            <td>{{ player.LastName }}</td>
            <td>{{ player.FirstName }}</td>
            <td>
              <a @click="goToPlayerDetails(player.idUser)">
                <i class="fa-regular fa-eye"></i>
              </a>
              <a @click="editPlayer(player.idUser)">
                <i class="fa-regular fa-pen-to-square"></i>
              </a>
              <a @click="deletePlayer(player.idUser, player.FirstName, player.LastName, team.id)">
                <i class="fa-solid fa-trash-can"></i>
              </a>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Custom Modal for Adding a Player -->
    <div v-if="showModal" class="custom-modal-overlay">
      <div class="custom-modal">
        <form @submit.prevent="submitNewPlayer">
          <!-- Section Coordonnées -->
          <h5 class="mb-3">Coordonnées</h5>
          <div class="modal-row">
            <div class="modal-col">
              <label class="form-label">Prénom</label>
              <input
                v-model="newPlayer.user.FirstName"
                type="text"
                class="form-control"
                required
              />
            </div>
            <div class="modal-col">
              <label class="form-label">Nom</label>
              <input
                v-model="newPlayer.user.LastName"
                type="text"
                class="form-control"
                required
              />
            </div>
          </div>

          <!-- Section Statistiques -->
          <h5 class="mt-4 mb-3">Statistiques</h5>
          <div class="modal-row">
            <div class="modal-col">
              <label class="form-label">Rebonds</label>
              <input
                v-model="newPlayer.statistic.Rebounds"
                type="number"
                class="form-control"
              />
            </div>
            <div class="modal-col">
              <label class="form-label">Points</label>
              <input
                v-model="newPlayer.statistic.Points"
                type="number"
                class="form-control"
              />
            </div>
          </div>

          <div class="modal-row">
            <div class="modal-col">
              <label class="form-label">3 points marqués</label>
              <input
                v-model="newPlayer.statistic.ThreePtsFieldGoalsMade"
                type="number"
                class="form-control"
              />
            </div>
            <div class="modal-col">
              <label class="form-label">3 points tentés</label>
              <input
                v-model="newPlayer.statistic.ThreePtsFieldGoalsAttempted"
                type="number"
                class="form-control"
              />
            </div>
          </div>

          <div class="modal-row">
            <div class="modal-col">
              <label class="form-label">Lancers francs</label>
              <input
                v-model="newPlayer.statistic.FreeThrowMade"
                type="number"
                class="form-control"
              />
            </div>
            <div class="modal-col">
              <label class="form-label">Lancers francs tentés</label>
              <input
                v-model="newPlayer.statistic.FreeThrowAttempted"
                type="number"
                class="form-control"
              />
            </div>
          </div>

          <div class="d-flex justify-content-end mt-4">
            <button
              type="button"
              class="btn btn-secondary me-2"
              @click="closeAddPlayerModal"
            >
              Annuler
            </button>
            <button type="submit" class="btn btn-primary">
              Ajouter un joueur
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
  import { API_URL } from '../config';

  export default {
    name: 'ManageTeam',

    data() {
      return {
        teams: [],
        playersByTeam: {},
        showModal: false,
        newPlayer: {
          idUser: null, // Initialize idUser as null because auto-generated by server
          user: {
            FirstName: '',
            LastName: '',
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
      };
    },
    methods: {
      // Fetch all teams
      async fetchTeams() {
        try {
          const response = await fetch(`${API_URL}/teams/teams`);
          if (!response.ok) throw new Error('Failed to fetch teams');

          const data = await response.json();
          this.teams = data.map((team) => ({
            id: team.idTeam,
            name: team.Name,
          }));
          this.fetchPlayersByTeam();
        } catch (error) {
          console.error('Error fetching teams:', error);
        }
      },

      // Fetch players by team
      async fetchPlayersByTeam() {
        for (const team of this.teams) {
          try {
            const response = await fetch(
              `${API_URL}/users/users/team/${team.id}`
            );
            if (!response.ok) throw new Error('Failed to fetch players');

            const data = await response.json();
            this.playersByTeam[team.id] = data;
          } catch (error) {
            console.error(`Error fetching players for team ${team.id}:`, error);
          }
        }
      },

      // Open the add player modal
      openAddPlayerModal(teamId) {
        this.resetNewPlayer();
        this.newPlayer.user.idTeam = teamId;
        this.showModal = true;
      },

      // Close the add player modal
      closeAddPlayerModal() {
        this.showModal = false;
      },

      // Submit a new player
      async submitNewPlayer() {
        try {
          const payload = {
            user: {
              FirstName: this.newPlayer.user.FirstName,
              LastName: this.newPlayer.user.LastName,
              idTeam: this.newPlayer.user.idTeam,
            },
            statistic: this.newPlayer.statistic,
          };

          console.log('Adding player:', payload);

          const response = await fetch(`${API_URL}/players/players`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(payload),
          });

          if (!response.ok) throw new Error('Failed to add player');

          alert('Player successfully added!');
          this.fetchPlayersByTeam();
          this.closeAddPlayerModal();
        } catch (error) {
          console.error('Error adding player:', error);
        }
      },

      // Delete a player from a team
      async deletePlayer(userId, firstname, lastname, idteam) {
        // Display a confirmation dialog to confirm deletion.
        const resp = confirm(`Do you want to delete ${firstname} ${lastname} from this team?`);
        
        if(resp){
          // Send a DELETE request to the API to remove the player from the team.
          const response = await fetch(`${API_URL}/users/users/${userId}/team`, {
            method: 'DELETE',
            headers: { 'Content-Type': 'application/json' }
          });
          if (!response.ok) {
            throw new Error('Error during the player deletion.');
          }
          
          alert('Player successfully deleted!');

           // Update the local list of players by removing the player with the given userId.
          this.playersByTeam[idteam] = this.playersByTeam[idteam].filter(
            user => user.idUser !== userId
          );
        }
      },

      // Reset the new player form
      resetNewPlayer() {
        this.newPlayer = {
          idUser: null,
          user: {
            FirstName: '',
            LastName: '',
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
      },

      goToPlayerDetails(playerId) {
        this.$router.push({ name: 'PlayerDetails', params: { id: playerId } });
      },

      editPlayer(userId) {
        alert(`Edit player with ID: ${userId}`);
      },
    },

    mounted() {
      this.fetchTeams();
    },
  };
</script>

<style>
  .custom-modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }

  .custom-modal {
    background-color: white;
    padding: 20px;
    border-radius: 8px;
    width: 100%;
    max-width: 800px;
    max-height: 90vh;
    overflow-y: auto;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
  }

  .modal-row {
    display: flex;
    gap: 20px;
    margin-bottom: 15px;
  }

  .modal-col {
    flex: 1;
  }

  .custom-modal .form-label {
    font-weight: bold;
  }

  .custom-modal button {
    margin-top: 10px;
  }
</style>
