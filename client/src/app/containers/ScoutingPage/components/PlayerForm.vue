<template>
  <div>
    <fieldset class="form-group col-md-12">
      <label>Player Name</label>
      <div class="row">
        <input type="text" v-model="personal_profile.first_name" class="form-control col-md-4" placeholder="First Name" />
        <input type="text" v-model="personal_profile.middle_name" class="form-control col-md-4" placeholder="Middle Name" />
        <input type="text" v-model="personal_profile.last_name" class="form-control col-md-4" placeholder="Last Name" />
      </div>
    </fieldset>
    <fieldset class="form-group col-md-12">
      <label>Date Of Birth</label>
      <div class="row">
        <select v-model="personal_profile.bMonth" class="form-control col-md-3">
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
        <select v-model="personal_profile.bDay" class="form-control col-md-3">
              <option disabled value="">Date</option>
              <option v-for="d in 31" :value="d" :key="d.id" >{{ d }}</option>
            </select>
        <input type="number" v-model="personal_profile.bYear" class="form-control col-md-6" placeholder="Year" />
      </div>
    </fieldset>
    <fieldset class="form-group col-md-12">
      <label>Country</label>
      <div class="row">
        <input type="number" v-model="personal_profile.residence_country_code" class="form-control col-md-4" placeholder="Country Code" />
        <input type="text" v-model="personal_profile.place_of_birth" class="form-control col-md-8" placeholder="Place of Birth" />
      </div>
    </fieldset>
    <fieldset class="form-group col-md-12">
      <label>Physique</label>
      <div class="row">
        <input type="number" v-model="personal_profile.weight" class="form-control col-md-4" placeholder="Weight" />
        <input type="number" v-model="personal_profile.height" class="form-control col-md-4" placeholder="Height" />
        <select v-model="personal_profile.preferred_foot" class="form-control col-md-4">
              <option disabled value="">Preferred Foot</option>
              <option value="R">Right</option>
              <option value="L">Left</option>
            </select>
      </div>
    </fieldset>
    <fieldset class="form-group col-md-12">
      <label>Playing Informations</label>
      <div class="row">
        <select v-model="personal_profile.playing_position" class="form-control col-md-4" multiple>
              <option disabled value="">Positions</option>
              <option value="keeper">GoalKeeper</option>
              <option value="defender">Defender</option>
              <option value="midfielder">Midfielder</option>
              <option value="winger">Winger</option>
              <option value="striker">Striker</option>
            </select>
        <input type="number" v-model="personal_profile.total_caps" class="form-control col-md-4" placeholder="Total Caps" />
      </div>
    </fieldset>
    <fieldset class="form-group col-md-12">
      <label>Personal Informations</label>
      <div class="row">
        <select v-model="personal_profile.pro_status" class="form-control col-md-4">
              <option disabled value="">Pro status</option>
              <option value="free">Free</option>
              <option value="engaged">Engaged</option>
            </select>
        <select v-model="personal_profile.languages" class="form-control col-md-4" multiple>
              <option disabled value="">Languages</option>
              <option value="eng">English</option>
              <option value="fra">French</option>
              <option value="spa">Spanish</option>
              <option value="deu">Deutsch</option>
              <option value="por">Portuguese</option>
            </select>
      </div>
    </fieldset>
  </div>
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
      'personal_profile',
    ],
  };
</script>