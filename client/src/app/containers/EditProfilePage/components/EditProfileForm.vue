<template>
  <form @submit.prevent="handleSubmit">
    <fieldset class="form-group col-md-12">
      <label>Your Name</label>
      <div class="row">
        <input type="text" v-model="first_name" class="form-control col-md-4" placeholder="First Name" />
        <input type="text" v-model="middle_name" class="form-control col-md-4" placeholder="Middle Name" />
        <input type="text" v-model="last_name" class="form-control col-md-4" placeholder="Last Name" />
      </div>
    </fieldset>
    <fieldset class="form-group col-md-12">
      <label>Date Of Birth</label>
      <div class="row">
        <select v-model="bMonth" class="form-control col-md-3">
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
        <select v-model="bDay" class="form-control col-md-3">
          <option disabled value="">Date</option>
          <option v-for="d in 31" :value="d">{{ d }}</option>
        </select>
        <input type="number" v-model="bYear" class="form-control col-md-6" placeholder="Year" />
      </div>
    </fieldset>
    <fieldset class="form-group col-md-12">
      <label>Country</label>
      <div class="row">
        <input type="number" v-model="country_code" class="form-control col-md-4" placeholder="Country Code" />
        <input type="text" v-model="place_of_birth" class="form-control col-md-8" placeholder="Place of Birth" />
      </div>
    </fieldset>
    <fieldset class="form-group col-md-12">
      <label>Physique</label>
      <div class="row">
        <input type="number" v-model="weight" class="form-control col-md-4" placeholder="Weight" />
        <input type="number" v-model="height" class="form-control col-md-4" placeholder="Height" />
        <select v-model="preferred_foot" class="form-control col-md-4">
          <option disabled value="">Preferred Foot</option>
          <option value="R">Right</option>
          <option value="L">Left</option>
          <option value="B">Both</option>
        </select>
      </div>
    </fieldset>
    <fieldset class="form-group col-md-12">
      <button type="submit" class="bar-button center">Save</button>
    </fieldset>
  </form>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.form-group {
  label {
    color: $main-text-color;
  }
  .bar-button {
    color: $main-text-color;
    border: 1px solid $main-text-color;
  }
}
</style>

<script>
export default {
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
      });
    },
  },
};
</script>
