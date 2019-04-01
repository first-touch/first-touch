<template>
  <div class="profile-form">
    <form @submit.prevent="updateProfilePic" enctype="multipart/form-data">
      <fieldset class="form-group">
        <label>Your Profile Picture</label>
        <div class="row">
          <div class="col-2">
            <input
              type="file"
              id="avatar"
              name="avatar"
              accept="image/*"
              @change="filePickerUpdated($event.target.files)"
              class="input-file"
            >
            <img data-v-8e1e5708 :src="currentAvatar" class="rounded-circle img-fluid">
          </div>
          <div class="col-4">
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
              v-model="first_name"
              class="form-control m-field-input"
              placeholder="First Name"
            >
          </div>
          <div class="col">
            <input
              type="text"
              v-model="middle_name"
              class="form-control m-field-input"
              placeholder="Middle Name"
            >
          </div>
          <div class="col">
            <input
              type="text"
              v-model="last_name"
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
              <option v-for="d in 31" :value="d">{{ d }}</option>
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
            <select v-model="country_code" class="form-control m-field-input">
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
              v-model="place_of_birth"
              class="form-control m-field-input"
              placeholder="Place of Birth"
            >
          </div>
        </div>
      </fieldset>
      <fieldset class="form-group">
        <label>Physique</label>
        <div class="row">
          <div class="col">
            <div class="input-group mb-3">
              <input
                type="number"
                v-model="weight"
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
                v-model="height"
                class="form-control m-field-input"
                placeholder="Height"
              >
              <div class="input-group-append">
                <span class="input-group-text" id="basic-addon2">cm</span>
              </div>
            </div>
          </div>
          <div class="col">
            <select v-model="preferred_foot" class="form-control m-field-input">
              <option disabled value>Preferred Foot</option>
              <option value="R">Right</option>
              <option value="L">Left</option>
              <option value="B">Both</option>
            </select>
          </div>
        </div>
      </fieldset>

      <fieldset class="form-group">
        <button type="submit" class="form-control a-bar-button">Save</button>
      </fieldset>
      
      <fieldset class="form-group">
        <div class="mb-2 clearfix">
          <div class="button fr">+ New Entry</div>
          <h4 >Career Entries</h4>
        </div>
        <career-entries 
          :career_histories="career_histories" 
          :countries="countries" 
          :searched_clubs="searched_clubs"
          :roles="roles"
          @delete="deleteCareerEntry" />
      </fieldset>
      
      
    </form>
    <br>
    <div class="seperation-box">
      <h3>CAREER ENTRIES</h3>
    </div>
    <fieldset class="form-group">
      <label>Enter New Career Entries</label>
      <fieldset class="form-group col-md-12">
        <career-entry-form :countries="countries" @save="addCareerEntry" />
      </fieldset>
    </fieldset>
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

  .remove-space {
    padding: 0 0 0 24px;
  }

  .remove-space-three {
    padding: 0;
  }
}
</style>
<style lang="scss" scoped>
@import "~stylesheets/variables";

.input-file {
  opacity: 0; /* invisible but it's there! */
  width: 100%;
  height: 100px;
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

.button {
  display: inline-block;
  padding: 0.3em;
  margin: 0.25em;
  border: 1px solid grey;
  color: grey;
  cursor: pointer;

  &:hover {
    color: white;
    background-color: grey;
  }
}
</style>

<script>
import ClubService from "app/services/ClubService";
import UserService from "app/services/UserService";
import CareerEntriesService from "app/services/CareerEntries";
import CareerEntries from "./CareerEntries";
import CareerEntryForm from "./CareerEntryForm";

import axios from "axios";
export default {
  name: "EditProfileForm",
  components: {
    CareerEntries,
    CareerEntryForm
  },
  props: [
    "firstName",
    "middleName",
    "lastName",
    "month",
    "day",
    "year",
    "countryCode",
    "placeOfBirth",
    "pWeight",
    "pHeight",
    "preferredFoot",
    "avatarUrl",
    "updateUserInfo",
    "clubId",
    "careerHistory"
  ],
  data() {
    return {
      isHidden: false,
      club_country_code: "",
      clubs: [],
      item: null,
      searchText: "",
      error: null,
      role_name: this.role,
      first_name: this.firstName || "",
      middle_name: this.middleName || "",
      last_name: this.lastName || "",
      bMonth: this.month || "",
      bDay: this.day || "",
      bYear: this.year || "",
      country_code: this.countryCode || "",
      place_of_birth: this.placeOfBirth || "",
      weight: this.pWeight || "",
      height: this.pHeight || "",
      preferred_foot: this.preferredFoot || "",
      countries: [],
      avatar_url: this.avatarUrl,
      avatar: undefined,
      formData: {},
      roles: [
        { role_name: "player" },
        { role_name: "manager" },
        { role_name: "coach" },
        { role_name: "scout" },
        { role_name: "director" }
      ],
      career_histories: this.careerHistory || "",
      searched_clubs: [],
      get_clubs: []
    };
  },
  computed: {
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
    addCareerEntry({ club_id, start_date, end_date, role}) {
      var careerInfo = {
        career_entry: {
          club_id, start_date, end_date, role
        }
      };
      CareerEntriesService.updateCareerEntries(careerInfo)
        .then(response => {
          this.updateInfo();
          this.flash("Added successfully", "success", {
            timeout: 3000,
            important: true
          });
        })
        .catch(response => {
          this.flash("Failed to add", "error", {
            timeout: 3000,
            important: true
          });
        });
    },
    
    deleteCareerEntry(id, index) {
      this.$delete(this.career_histories, index);
      CareerEntriesService.deleteCareerEntries(id)
        .then(response => {
          this.flash("Delete successfully", "success", {
            timeout: 3000,
            important: true
          });
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
        bMonth,
        bDay,
        bYear,
        place_of_birth,
        weight,
        height,
        preferred_foot,
        career_histories
      } = this;
      const nationality_country_code = this.country_code;
      const residence_country_code = this.country_code;
      const birthday = new Date(Date.UTC(bYear, bMonth, bDay));

      const profile_update = {
        career_histories,
        first_name,
        middle_name,
        last_name,
        birthday,
        nationality_country_code,
        residence_country_code,
        place_of_birth,
        weight,
        height,
        preferred_foot
      }
      this.$emit("save", profile_update);

      /*this.updateUserInfo().then(response => {
      });*/
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
