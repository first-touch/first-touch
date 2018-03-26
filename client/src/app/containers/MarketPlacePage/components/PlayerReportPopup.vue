<template>
  <div>
    <h5> PLAYER DETAILS </h5>
    <div class="reportHeadline">
      <div class="row">
        <p class="col col-sm-12">Report Name: {{report.headline}} </p>
      </div>
      <div class="row">
        <p class="col col-sm-12">Report Id: PR{{idFilter(report.id,5)}} </p>
      </div>
    </div>
    <div class="infos">
      <div class="row">
        <label class="col-sm-6">Player Name</label>
        <p class="col col-sm-4"> {{report.player.first_name}} {{report.player.last_name}} </p>
      </div>
      <div class="row">
        <label class="col-sm-6">Age</label>
        <p class="col col-sm-4"> {{report.report_data.meta_data.age}} </p>
      </div>
      <div class="row">
        <label class="col-sm-6">Approximate Height (cm) </label>
        <p class="col col-sm-4"> {{report.report_data.meta_data.height}} </p>
      </div>
      <div class="row">
        <label class="col-sm-6">Approximate Weight (kg) </label>
        <p class="col col-sm-4"> {{report.report_data.meta_data.weight}} </p>
      </div>
      <div class="row">
        <label class="col-sm-6">Nationality </label>
        <p class="col col-sm-4"> {{getNationality(report.report_data.meta_data.nationality_country_code)}} </p>
      </div>

      <div class="row">
        <label class="col-sm-6">Language spoken</label>
        <p class="col col-sm-4"> <span v-for="language in report.report_data.meta_data.languages" class="list" :key="language.id">{{getLanguage(language)}}</span></p>
      </div>
      <div class="row">
        <label class="col-sm-6">Position</label>
        <p class="col col-sm-4"> <span v-for="position in report.report_data.meta_data.playing_position" class="list" :key="position.id">{{position}}</span> </p>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .list{
    text-transform: capitalize;
      &::after{
    content: ', '
    }
    &:last-child::after{
        content: ''
    }
  }

</style>

<script>
  import countrydata from 'country-data';

  export default {
    name: 'PlayerReportPopup',
    props: ['report'],
      methods: {
      idFilter(s, size) {
        s = s.toString();
        while (s.length < (size || 2)) {
          s = "0" + s;
        }
        console.log(s.length);
        return s;
      },
      getLanguage(key) {
        return countrydata.languages[key].name;
      },
      getNationality(key) {
        return countrydata.countries[key].name;
      }
    },
  };
</script>