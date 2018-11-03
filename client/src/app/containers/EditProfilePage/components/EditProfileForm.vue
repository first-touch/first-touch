<template>
  <div class="page-wrapper">
    <feedback-message ref="feedbackMessage"></feedback-message>
    <form @submit.prevent="handleSubmit">
      <fieldset class="form-group">
        <label>Your Name</label>
        <div class="row">
          <div class="col">
            <input type="text" v-model="first_name" class="form-control m-field-input" placeholder="First Name" />
          </div>
          <div class="col">
            <input type="text" v-model="middle_name" class="form-control m-field-input" placeholder="Middle Name" />
          </div>
          <div class="col">
            <input type="text" v-model="last_name" class="form-control m-field-input" placeholder="Last Name" />
          </div>
        </div>
      </fieldset>
      <fieldset class="form-group">
        <label>Date Of Birth</label>
        <div class="row">
          <div class="col">
            <select v-model="bMonth" class="form-control m-field-input">
              <option disabled value="">Month</option>
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
              <option disabled value="">Date</option>
              <option v-for="d in 31" :value="d">{{ d }}</option>
            </select>
          </div>
          <div class="col">
            <input type="number" v-model="bYear" class="form-control m-field-input" placeholder="Year" />
          </div>
        </div>
      </fieldset>
      <fieldset class="form-group">
        <label>Nationality</label>
        <div class="row">
          <div class="col">
            <select v-model="country_code" class="form-control m-field-input">
              <option disabled value="" selected>Country of Birth</option>
              <option v-for="c in countries" :key="c.country_code" :value="c.country_code">{{ c.country_name }}</option>
            </select>
          </div>
          <div class="col">
            <input type="text" v-model="place_of_birth" class="form-control m-field-input" placeholder="Place of Birth" />
          </div>
        </div>
      </fieldset>
      <fieldset class="form-group">
        <label>Physique</label>
        <div class="row">
          <div class="col">
            <div class="input-group mb-3">
              <input type="number" v-model="weight" class="form-control m-field-input" placeholder="Weight" />
              <div class="input-group-append">
                <span class="input-group-text" id="basic-addon2">Kg</span>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="input-group mb-3">
              <input type="number" v-model="height" class="form-control m-field-input" placeholder="Height" />
              <div class="input-group-append">
                <span class="input-group-text" id="basic-addon2">cm</span>
              </div>
            </div>
          </div>
          <div class="col">
            <select v-model="preferred_foot" class="form-control m-field-input">
              <option disabled value="">Preferred Foot</option>
              <option value="R">Right</option>
              <option value="L">Left</option>
              <option value="B">Both</option>
            </select>
          </div>
        </div>
      </fieldset>
      <fieldset class="form-group">
        <button type="submit" class="a-bar-button">Save</button>
      </fieldset>
    </form>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.form-group {
  label {
    color: $main-text-color;
  }
}
</style>

<script>
import FeedbackMessage from 'app/components/FeedbackMessage';
import ClubService from 'app/services/ClubService';

export default {
  components: {
    "feedback-message": FeedbackMessage
  },
  name: 'EditProfileForm',
  props: [
    'firstName',
    'middleName',
    'lastName',
    'month',
    'day',
    'year',
    'countryCode',
    'placeOfBirth',
    'pWeight',
    'pHeight',
    'preferredFoot',
    'updateUserInfo',
  ],
  data() {
    return {
      first_name: this.firstName || '',
      middle_name: this.middleName || '',
      last_name: this.lastName || '',
      bMonth: this.month || '',
      bDay: this.day || '',
      bYear: this.year || '',
      country_code: this.countryCode || '',
      place_of_birth: this.placeOfBirth || '',
      weight: this.pWeight || '',
      height: this.pHeight || '',
      preferred_foot: this.preferredFoot || '',
      countries: []
    };
  },
  methods: {
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
      } = this;
      const nationality_country_code = this.country_code;
      const residence_country_code = this.country_code;
      const birthday = new Date(Date.UTC(this.bYear, bMonth, bDay));
      this.updateUserInfo({
        first_name,
        middle_name,
        last_name,
        birthday,
        nationality_country_code,
        residence_country_code,
        place_of_birth,
        weight,
        height,
        preferred_foot,
      }).then(response => {
        this.$refs.feedbackMessage.displayMessage("Saved successfully");
      })
    },
    fetchCountries() {
      ClubService.countriesForClubs().then(response => {
        this.$set(this, 'countries',
                  response.countries.sort((a, b) => a.country_name > b.country_name))
      });
    },
  },
  mounted() {
    this.fetchCountries();
  }
};
</script>
