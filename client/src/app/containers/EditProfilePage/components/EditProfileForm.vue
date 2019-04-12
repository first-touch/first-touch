<template>
  <div class="profile-form">
    <form @submit.prevent="updateProfilePic" enctype="multipart/form-data">
      <fieldset class="form-group">
        <label>Your Profile Picture</label>
        <div class="row">
          <div class="col-4">
            <input
              type="file"
              id="avatar"
              name="avatar"
              accept="image/*"
              @change="filePickerUpdated($event.target.files)"
              class="input-file"
            >
            <img :src="currentAvatar" class="rounded-circle img-fluid">
          </div>
          <div class="col-8">
            <button
              type="submit"
              :disabled="noNewAvatar"
              class="form-control a-bar-button"
            >Update my picture</button>
          </div>
        </div>
      </fieldset>
    </form>
    <form @submit.prevent="handleSubmit">
      <fieldset class="form-group">
        <label>Your Name</label>
        <div class="row">
          <div class="col">
            <input
              type="text"
              v-model="profile_form.first_name"
              class="form-control m-field-input"
              placeholder="First Name"
            >
          </div>
          <div class="col">
            <input
              type="text"
              v-model="profile_form.middle_name"
              class="form-control m-field-input"
              placeholder="Middle Name"
            >
          </div>
          <div class="col">
            <input
              type="text"
              v-model="profile_form.last_name"
              class="form-control m-field-input"
              placeholder="Last Name"
            >
          </div>
        </div>
      </fieldset>
      <fieldset class="form-group">
        <label>Date Of Birth</label>
        <div class="row">
          <div class="col"> 
            <select v-model="bMonth" class="form-control m-field-input">
              <option disabled value>Month</option>
              <option value="1">January</option>
              <option value="2">February</option>
              <option value="3">March</option>
              <option value="4">April</option>
              <option value="5">May</option>
              <option value="6">June</option>
              <option value="7">July</option>
              <option value="8">August</option>
              <option value="9">September</option>
              <option value="10">October</option>
              <option value="11">November</option>
              <option value="12">December</option>
            </select>
          </div>
          <div class="col">
            <select v-model="bDay" class="form-control m-field-input">
              <option disabled value>Date</option>
              <option v-for="d in 31" :key="d" :value="d">{{ d }}</option>
            </select>
          </div>
          <div class="col">
            <input
              type="number"
              v-model="bYear"
              class="form-control m-field-input"
              placeholder="Year"
            >
          </div>
        </div>
      </fieldset>
      <fieldset class="form-group">
        <label>Nationality</label>
        <div class="row">
          <div class="col">
            <select v-model="profile_form.nationality_country_code" class="form-control m-field-input">
              <option disabled value selected>Country of Birth</option>
              <option
                v-for="c in countries"
                :key="c.country_code"
                :value="c.country_code"
              >{{ c.country_name }}</option>
            </select>
          </div>
          <div class="col">
            <input
              type="text"
              v-model="profile_form.place_of_birth"
              class="form-control m-field-input"
              placeholder="Place of Birth"
            >
          </div>
        </div>
      </fieldset>
      <fieldset class="form-group" v-if="isPlayer">
        <label>Physique</label>
        <div class="row">
          <div class="col">
            <div class="input-group mb-3">
              <input
                type="number"
                v-model="profile_form.weight"
                class="form-control m-field-input"
                placeholder="Weight"
              >
              <div class="input-group-append">
                <span class="input-group-text" id="basic-addon2">Kg</span>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="input-group mb-3">
              <input
                type="number"
                v-model="profile_form.height"
                class="form-control m-field-input"
                placeholder="Height"
              >
              <div class="input-group-append">
                <span class="input-group-text" id="basic-addon2">cm</span>
              </div>
            </div>
          </div>
          <div class="col">
            <select v-model="profile_form.preferred_foot" class="form-control m-field-input">
              <option disabled value>Preferred Foot</option>
              <option value="R">Right</option>
              <option value="L">Left</option>
              <option value="B">Both</option>
            </select>
          </div>
        </div>
      </fieldset>

      <fieldset class="form-group">
        <label for="qualifications">Biography</label>
        <textarea class="form-control" id="biography" rows="4" v-model="profile_form.biography"></textarea>
      </fieldset>

      <fieldset class="form-group" v-if="isAgent">
        <label for="qualifications">Qualifications</label>
        <textarea class="form-control" id="qualifications" rows="4" v-model="profile_form.qualifications"></textarea>
      </fieldset>

      <fieldset class="form-group" v-if="isAgent">
        <label for="affiliations">Affiliations</label>
        <textarea class="form-control" id="affiliations" rows="4" v-model="profile_form.affiliations"></textarea>
      </fieldset>

      <fieldset class="form-group" v-if="isScout">
        <label for="scouting_badges">Scouting Badges</label>
        <textarea class="form-control" id="scouting_badges" rows="4" v-model="profile_form.scouting_badges"></textarea>
      </fieldset>
      
      <fieldset class="form-group" v-if="isAgent || isScout">
        <label for="scope_of_operations">Scope of Operations</label>
        <input-list v-model="profile_form.scope_of_operation" />
      </fieldset>

      <fieldset class="form-group">
        <button type="submit" class="col-2 float-right form-control a-bar-button">Save</button>
      </fieldset>
      
      <hr class="section-separator" />

      <fieldset class="form-group">
        <div class="mb-2 clearfix">
          <div class="a-button fr" @click="selectedCareerEntry=null; showCareerForm = true">+ New Entry</div>
          <h4 >Career Entries</h4>
        </div>
        <career-entries 
          :career_histories="career_histories" 
          :countries="countries" 
          :roles="roles"
          @delete="deleteCareerEntry"
          @edit="editCareerEntry" />
      </fieldset>
      
    </form>

    <ft-dialog :visible.sync="showCareerForm" >
      <div slot="title">
        <span v-if="selectedCareerEntry != null">Edit entry</span>
        <span v-else>Create new entry</span>
      </div>
      <career-entry-form 
        :entry="selectedCareerEntry" 
        :countries="countries" 
        @save="saveCareerEntry"
        @delete="deleteCareerEntry" 
        @close="showCareerForm = false"/>
    </ft-dialog>
  </div>
</template>

<style lang="scss">
@import "~stylesheets/variables";
.profile-form {
  .form-group {
    h3,h4,
    label {
      color: $main-text-color;
    }
  }

  .select-btn {
    width: 100%;
    display: inline-block;
    margin: 0 24px 24px 0px;
  }
}
</style>
<style lang="scss" scoped>
@import "~stylesheets/variables";

.input-file {
  opacity: 0; /* invisible but it's there! */
  width: 100%;
  padding-top: 100%;
  position: absolute;
  cursor: pointer;
  margin-top: -32px;
}
.seperation-box {
  border-top: 2px solid #7f8081;
  padding: 10px 0;
}
.seperation-box h3 {
  color: #7f8081;
  margin: 10px 0px;
  font-size: large;
}

</style>

<script>
import ClubService from "app/services/ClubService";
import UserService from "app/services/UserService";
import CareerEntriesService from "app/services/CareerEntries";
import CareerEntries from "./CareerEntries";
import CareerEntryForm from "./CareerEntryForm";
import FtDialog from "app/components/FtDialog";
import InputList from "./InputList";

export default {
  name: "EditProfileForm",
  components: {
    CareerEntries,
    CareerEntryForm,
    FtDialog,
    InputList
  },
  props: [
    "profile",
    "role",
    "preferredFoot",
    "avatarUrl",
    "clubId",
    "careerHistory"
  ],
  data() {
    return {
      isHidden: false,
      profile_form: {
        avatar_url: "",
        first_name: "",
        middle_name: "",
        last_name: "",
        birthday: "",
        nationality_country_code: "",
        residence_country_code: "",
        place_of_birth: "",
        weight: 0,
        height: 0,
        preferred_foot: "",
        biography: "",
        qualifications: "",
        affiliations: "",
        scouting_badges: "",
        scope_of_operations: ""
      },
      club_country_code: "",
      clubs: [],
      searchText: "",
      bMonth:  "",
      bDay: "",
      bYear: "",
      countries: [],
      avatar_url: this.avatarUrl,
      avatar: undefined,
      formData: {},
      roles: [
        { role_name: "player" },
        { role_name: "agent" },
        { role_name: "scout" },
        { role_name: "director" }
      ],
      career_histories: this.careerHistory || "",
      showCareerForm: false,
      selectedCareerEntry: null
    };
  },
  computed: {
    isPlayer(){ return this.role  == "player"; },
    isAgent(){ return this.role  == "agent"; },
    isScout(){ return this.role  == "scout"; },
    isDirector(){ return this.role  == "director"; },

    currentAvatar() {
      if (this.avatar) {
        return this.avatar.url;
      } else {
        return this.avatar_url;
      }
    },
    noNewAvatar() {
      return !this.avatar;
    }
  },
  watch: {
    profile: {
      immediate: true,
      handler: function(to){
        this.profile_form = to;

        if (this.profile_form.birthday){
          let dob = new Date(this.profile_form.birthday);
          this.bYear = dob.getUTCFullYear();
          this.bMonth = dob.getMonth() + 1;
          this.bDay = dob.getDate();
        }
      }
    }
  },
  methods: {
    filePickerUpdated(newFiles) {
      this.avatar = newFiles[0];
      this.avatar.url = "";
      let URL = window.URL || window.webkitURL;
      if (URL && URL.createObjectURL) {
        this.avatar.url = URL.createObjectURL(this.avatar);
      }
    },
    
    updateInfo() {
      CareerEntriesService.returnUserInfo().then(response => {
        this.career_histories = response.career_history;
      });
    },

    editCareerEntry(id, index){
      let entry = this.career_histories[index];
      let { role, start_date, end_date, club } = entry;
      this.selectedCareerEntry = {
        role, start_date, end_date,
        id: entry.id,
        club_id: club.id, 
        club_name: club.name,
        country_code: club.country_code
      };
      this.showCareerForm = true;
    },

    async saveCareerEntry({ id, club_id, start_date, end_date, role}) {
      let entry = this.career_histories.find((e)=>e.id==id);
      const isUpdate = entry != null;

      var careerInfo = {
        career_entry: {
          club_id, start_date, end_date, role
        }
      };
      
      try {
        let request;
        if (isUpdate){
          await CareerEntriesService.update(entry.id, careerInfo);
        } else {
          await CareerEntriesService.create(careerInfo);
        }
    
        this.updateInfo();
        let msg = isUpdate ? 'Updated entry successfully' : 'Added new entry successfully';
        this.flash(msg, "success", { timeout: 3000, important: true });
        this.showCareerForm = false;
      } catch(err){
        console.error(err);
        this.flash("Failed to add", "error", { timeout: 3000, important: true });
      } 
    },
    
    deleteCareerEntry({ id }) {
      let index = this.career_histories.findIndex((c)=>c.id == id);
      if (index == -1) return;

      this.showCareerForm = false;

      CareerEntriesService.deleteCareerEntries(id)
        .then(response => {
          this.flash("Delete successfully", "success", {
            timeout: 3000,
            important: true
          });
          this.$delete(this.career_histories, index);
        })
        .catch(response => {
          this.flash("Failed to delete", "error", {
            timeout: 3000,
            important: true
          });
        });
    },
    
    updateProfilePic() {
      if (this.avatar == undefined) {
        return;
      }
      this.formData = new FormData();
      this.formData.append("avatar", this.avatar);
      UserService.updateProfilePicture(this.formData)
        .then(response => {
          this.flash("Updated successfully", "success", {
            timeout: 3000,
            important: true
          });
        })
        .catch(response => {
          this.flash("Failed to update", "error", {
            timeout: 3000,
            important: true
          });
        });
    },

    handleSubmit() {
      const {
        first_name,
        last_name,
        middle_name,
        place_of_birth,
        nationality_country_code,
        weight,
        height,
        preferred_foot,
        career_histories
      } = this.profile_form;
      const residence_country_code = nationality_country_code;
      const birthday = new Date(Date.UTC(this.bYear, this.bMonth-1, this.bDay));

      const profile_update = {
        ...this.profile_form,
        //career_histories,
        birthday,
        nationality_country_code,
        residence_country_code,
      }

      this.$emit("save", profile_update);
    },
    fetchCountries() {
      ClubService.countriesForClubs().then(response => {
        this.$set(
          this,
          "countries",
          response.countries.sort((a, b) => a.country_name > b.country_name)
        );
      });
    },
    updateItems(text) {
      this.$set(this, "searchText", text);
      if (!text) return this.$set(this, "clubs", []);
      const params = {
        country: this.club_country_code,
        q: text
      };
      ClubService.searchClub(params).then(response => {
        this.$set(this, "clubs", response.clubs);
      });
    },
    getLabel(item) {
      return item ? item.name : this.searchText;
    }
  },
  mounted() {
    this.fetchCountries();
  }
};
</script>
