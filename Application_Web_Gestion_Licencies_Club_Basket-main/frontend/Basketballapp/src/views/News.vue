<template>
  <div class="container mt-4">
    <h1 class="text-center mb-1">Actualités</h1>
    <p class="text-center mb-5">Dernières actualités du club...</p>

    <div class="news-slider">
      <div
        v-for="event in events"
        :key="event.id"
        class="event-card"
      >
        <img :src="event.image" :alt="event.title" class="event-image" />
        <h3 class="event-title">{{ event.title }}</h3>
        <p class="event-description">{{ event.description }}</p>
        <p class="event-date">{{ event.date }}</p>
      </div>
    </div>

    <div class="d-flex mt-3 justify-content-between align-items-center">
      <h2 class="mt-5">Compétitions</h2>
      <a @click="openAddMatchModal()">
        <i class="fa-solid fa-plus"></i>
      </a>
    </div>
    
    <div class="news-slider">
      <div
        v-for="event in competitions"
        :key="event.id"
        class="event-card"
      >
        <img :src="event.image" :alt="event.title" class="event-image" />
        <h3 class="event-title">{{ event.championship }} - {{ event.stage }}</h3>
        <div class="event-description" v-html="event.description"></div>
        <p class="event-date">{{ event.date ?? '-'}}</p>
        <p class="event-date">{{ event.place ?? '-' }}</p>
      </div>
    </div>

    <!-- Custom Modal for Adding a Player -->
    <div v-if="showModal" class="custom-modal-overlay">
      <div class="custom-modal">
        <form @submit.prevent="submitNewMatch">
          <!-- Section Coordonnées -->
          <h5 class="mb-3">Match</h5>
          <div class="modal-row">
            <div class="modal-col">
              <label class="form-label">Championnat</label>
              <input
                v-model="newMatch.championship"
                type="text"
                class="form-control"
                required
              />
            </div>
            <div class="modal-col">
              <label class="form-label">Stage</label>
              <input
                v-model="newMatch.stage"
                type="text"
                class="form-control"
                required
              />
            </div>
          </div>

          <div class="modal-row">
            <div class="modal-col">
              <label class="form-label">Date</label>
              <input
                v-model="newMatch.date"
                type="datetime-local"
                class="form-control"
              />
            </div>
            <div class="modal-col">
              <label class="form-label">Place</label>
              <input
                v-model="newMatch.place"
                type="text"
                class="form-control"
                required
              />
            </div>
          </div>

          <div class="modal-row">
            <div class="modal-col">
              <label class="form-label">Score</label>
              <input
                v-model="newMatch.score"
                type="number"
                class="form-control"
                min="0"
              />
            </div>
          </div>

          <div class="modal-row">
            <div class="modal-col">
              <label class="form-label">Image</label>
              <input
                @change="onFileChange"
                type="file"
                class="form-control"
              />
            </div>
          </div>

          <div class="modal-row">
            <label class="form-label">Description</label>
          </div>
          <div class="modal-row">
            <!-- <Editor
                v-model="newMatch.description"
                :init="editorConfig"
                tinymce-script-src="/tinymce/tinymce.min.js"
                class="form-control"

            /> -->
            <textarea
                v-model="newMatch.description"
                type="text"
                class="form-control input-enhanced"
                rows="3"
                maxlength="200"
            ></textarea>
            
            <!-- <div ref="editor" id="quill-editor" class="form-control"></div> -->
          </div>
          <small>{{ newMatch.description.length }}/200 caractères</small>
          
          <div class="d-flex justify-content-end mt-4">
            <button
              type="button"
              class="btn btn-secondary me-2"
              @click="closeAddMatchModal"
            >
              Annuler
            </button>
            <button type="submit" class="btn btn-primary">
              Ajouter un match
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>


<script>
// import Editor  from '@tinymce/tinymce-vue';


import { API_URL } from '../config';
//import { QuillEditor} from 'quill';


const DefaultToolbarOptions = {
  modules:{
    toolbar:[
      ['bold', 'italic', 'underline', 'strike'],
      [{'list':'ordered'}, {'list':'bullet'}],
      [{'indent': '-1'}, {'indent':'+1'}],
      [{'color':[]}, {'background':[]}],
      ['link']
    ],
  },
  theme:'snow',
  bounds: '#quill-editor'
};

// @Component
// export default class Quill extends Vue {
//   @Prop() public value: string; 

//   public currentValue: string="";

  
// }


export default {
  //components: { Editor },
  name: "News",
  props: {
    value: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      // Event data for the cards
      events: [
        {
          id: 1,
          title: "Barbecue Party",
          description: "Join us for a fun BBQ party at the club!",
          date: "2024-12-01",
          image: "https://stratevent.com/imgs/content/medium/team-building-solidaire-ile-de-france-0004204.jpg",
        },
        {
          id: 2,
          title: "Basketball Championship",
          description: "Cheer for your team in the grand finals!",
          date: "2024-12-15",
          image: "https://image.discovery.indazn.com/ca/v2/ca/image?id=1qwmi8zy3tcg71tfiayjczigcg_image-header_pRow_1705919326000",
        },
        {
          id: 3,
          title: "New Year Celebration",
          description: "Celebrate the new year with us at the club.",
          date: "2024-12-31",
          image: "https://c.myholidays.com/blog/blog/content/images/2020/11/New-year-celebration.webp", 
        },
        {
          id: 3,
          title: "Finals",
          description: "Join us",
          date: "2025-01-31",
          image: "https://espnevents.com/wp-content/uploads/2023/11/2023-Myrtle-Beach-Liberty-Champs-Header-scaled.jpg", 
        },
        {
          id: 3,
          title: "New Year Celebration",
          description: "Celebrate the new year with us at the club.",
          date: "2024-12-31",
          image: "https://c.myholidays.com/blog/blog/content/images/2020/11/New-year-celebration.webp", 
        },
      ],
      competitions :[],
      selectedFile : null,
      newMatch : {
        championship : "Championnat",
        stage : "",
        date : null,
        place : "",
        score: 0,
        image: "",
        description : ""
      },
      showModal: false,
      editorOptions: {
        modules: {
          toolbar: [
            [
              {
                header: [1, 2, 3, 4, false],
              },
            ],
            ["bold", "italic", "underline", "link"],
          ],
        },
        //theme: 'bubble',
        theme: "snow",
        formats: ["bold", "underline", "header", "italic", "link"],
        placeholder: "Type something in here!",
      },
      // editorConfig: {
        
      //   menubar: false,
      //   plugins: 'lists link image table',
      //   toolbar: 'undo redo | formatselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | table'
      // },

    };
  },
  async created(){
    await this.resetCompetitionsList();
  },
  // mounted() {
  //   const element = this.$refs.editor;

  //   const quill = new Quill(element, {...DefaultToolbarOptions});

  //   element.firstChild.innerHTML = this.value;
    
  //   quill.on('text-change', ()=>{
  //     this.newMatch.description = element.firstChild.innerHTML;
  //     this.$emit('input', this.newMatch.description);
  //   });

  //   this.newMatch.description = this.value;
  // },
  // watch(newValue){
  //   this.newMatch.description = newValue;
  // },
  methods: {
    scrollLeft() {
      const slider = this.$refs.slider;
      slider.scrollLeft -= 300; // Scroll left by 300px
    },
    scrollRight() {
      const slider = this.$refs.slider;
      slider.scrollLeft += 300; // Scroll right by 300px
    },
    resetNewMatch(){
      this.newMatch = {
        championship : "",
        stage : "",
        date : null,
        place : "",
        score: 0,
        image: "",
        description : ""
      };
    },
    onFileChange(event) {
      this.selectedFile = event.target.files[0]; 
    },
    async resetCompetitionsList(){
      try{
        const response = await fetch("http://127.0.0.1:8000/api/matches/matches/");
        if (!response.ok) {
          throw new Error("Failed to retrieve matches");
        }
        const competitionData = await response.json();
        
        competitionData.forEach((competition) => {
            const rawDate = new Date(competition.Date); 
            const formattedDate = rawDate.toLocaleDateString("fr-FR", { 
              year: "numeric", 
              month: "long", 
              day: "numeric", 
              hour: "2-digit", 
              minute: "2-digit" 
            }); 

            this.competitions.push({
              championship : competition.Championship ?? "Sans titre",
              date : formattedDate,
              stage : competition.Stage ?? "",
              score : competition.Score ?? 0,
              description : competition.Description,
              image : competition.Image ?? "/src/assets/img_matches/competition_intern.jpg",
              place: competition.Place ?? "",
            });
          });

      }catch(error){
        console.error('Error during the news loading :', error);
      }
    },
    openAddMatchModal() {
      this.resetNewMatch();
      this.showModal = true;
    },
    closeAddMatchModal(){
      this.showModal = false;
    },
    async submitNewMatch(){
      if (!this.selectedFile) {
        alert("Veuillez sélectionner une image.");
        return;
      }
      
      const allowedExtensions = ["png", "jpg", "jpeg"];
      const fileExtension = this.selectedFile.name.split(".").pop().toLowerCase();

      if (!allowedExtensions.includes(fileExtension)) {
        alert("Seuls les fichiers PNG, JPG et JPEG sont acceptés.");
        this.selectedFile = null;
        return;
      }

      // Limit image size
      if (this.selectedFile.size > 2 * 1024 * 1024) {
        alert("Le fichier ne doit pas dépasser 2 Mo.");
        this.selectedFile = null;
        return;
      }

      const formData = new FormData();
      formData.append("image", this.selectedFile);

      // Save the image and get its path
      const response = await fetch(`${API_URL}/matches/matches/image`, {
            method: 'POST',
            body: formData,
          });

      if (!response.ok) throw new Error('Failed to add match - Failed to download the image');

      const path = await response.json();
        
      // Send the request to save the match on the database
      const resp = await fetch(`${API_URL}/matches/matches`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
              "Championship": this.newMatch.championship ?? "",
              "Stage": this.newMatch.stage ?? "",
              "Score": this.newMatch.score ?? 0,
              "Date": this.newMatch.date,
              "Place": this.newMatch.place,
              "Description": this.newMatch.description,
              "Image": `${path.path}`
            }),
          });

      if (!resp.ok) throw new Error('Failed to add match');
      
      console.log('Adding match:', this.newMatch);
      await this.resetCompetitionsList();
      this.closeAddMatchModal();
      
    },
    
  },
};
</script>

<style scoped>
/* Style for the News component */
.news-slider {
  display: flex;
  overflow-x: auto;
  gap: 1rem;
  padding: 1rem;
  scroll-snap-type: x mandatory;
}

.event-card {
  flex: 0 0 auto;
  width: 300px;
  background: #f9f9f9;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  scroll-snap-align: start;
  overflow: hidden;
}

.event-image {
  width: 100%;
  height: 200px;
  object-fit: cover;
}

.event-title {
  margin: 1rem;
  font-size: 1.5rem;
  color: #333;
}

.event-description {
  margin: 0 1rem 1rem;
  color: #555;
}

.event-date {
  margin: 0 1rem 1rem;
  font-size: 0.9rem;
  color: #888;
}

/* Navigation Buttons */
.navigation-buttons {
  display: flex;
  justify-content: space-between;
  margin-bottom: 1rem;
}

.scroll-button {
  background: #007bff;
  color: #fff;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  cursor: pointer;
  font-size: 1.5rem;
}

.scroll-button:hover {
  background: #0056b3;
}

/* Add smooth scrolling */
.news-slider::-webkit-scrollbar {
  height: 8px;
}

.news-slider::-webkit-scrollbar-thumb {
  background: #ccc;
  border-radius: 4px;
}

.news-slider::-webkit-scrollbar-track {
  background: #f1f1f1;
}

.input-enhanced {
  border: 2px solid #ced4da;
  border-radius: 5px;
  padding: 10px;
  font-size: 16px;
  transition: border-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}
.input-enhanced:focus {
  border-color: #007bff;
  box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
  outline: none;
}
</style>