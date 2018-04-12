<template>
  <div class="custom-modal-content">
    <h5> PLAYER DETAILS </h5>
    <div class="reportHeadline">
      <div class="row">
        <p class="col col-sm-12">Report Name: {{report.headline}} </p>
      </div>
      <div class="row">
        <p class="col col-sm-12">Report Id: {{report.id | reportId('player')}} </p>
      </div>
    </div>
    <div class="infos" v-if="report.meta_data">
      <div class="row">
        <label class="col-sm-6">Player Name</label>
        <p class="col col-sm-4"> {{report.player.first_name}} {{report.player.last_name}} </p>
      </div>
      <div class="row">
        <label class="col-sm-6">Age</label>
        <p class="col col-sm-4"> {{report.meta_data.player_info.age}} </p>
      </div>
      <div class="row">
        <label class="col-sm-6">Approximate Height (cm) </label>
        <p class="col col-sm-4"> {{report.meta_data.player_info.height}} </p>
      </div>
      <div class="row">
        <label class="col-sm-6">Approximate Weight (kg) </label>
        <p class="col col-sm-4"> {{report.meta_data.player_info.weight}} </p>
      </div>
      <div class="row">
        <label class="col-sm-6">Nationality </label>
        <p class="col col-sm-4"> {{getNationality(report.meta_data.player_info.nationality_country_code)}} </p>
      </div>
      <div class="row">
        <label class="col-sm-6">Language spoken</label>
        <p class="col col-sm-4"> <span v-for="language in report.meta_data.player_info.languages" class="list" :key="language.id">{{getLanguage(language)}}</span></p>
      </div>
      <div class="row">
        <label class="col-sm-6">Position</label>
        <p class="col col-sm-4"> <span v-for="position in report.meta_data.player_info.playing_position" class="list" :key="position.id">{{position}}</span> </p>
      </div>
      <div class="row" v-for="attachment in report.attachments" :key="attachment.id">
        <label class="col-sm-6">Attachment</label>
        <p class="col col-sm-4"> {{attachment.filename}} </p>
      </div>
    </div>
    <div class="footer-modal">
      <button class="btn-primary close-modal"  @click="closeAction" >CLOSE</button>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.list {
  text-transform: capitalize;
  &::after {
    content: ', ';
  }
  &:last-child::after {
    content: '';
  }
}

.row {
  margin-top: 10px;
}
h5 {
  margin-bottom: 35px;
}
.custom-modal-content {
  padding: 50px 10px 20px 80px;
}
</style>

<script>
import countrydata from 'country-data';

export default {
  name: 'PlayerReportPopup',
  props: ['report', 'closeAction'],
  methods: {
    getLanguage(key) {
      var lang = countrydata.languages[key];
      return lang ? lang.name : key;
    },
    getNationality(key) {
      var lang = countrydata.countries[key];
      return lang ? lang.name : key;
    }
  }
};
</script>
