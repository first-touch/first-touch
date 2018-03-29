<template>
  <div>
    <h5> CLUB DETAILS </h5>
    <div class="reportHeadline">
      <div class="row">
        <p class="col col-sm-12">Report Name: {{report.headline}} </p>
      </div>
      <div class="row">
        <p class="col col-sm-12">Report Id: {{report.id | reportId('team')}} </p>
      </div>
    </div>
    <div class="infos" v-if="report.report_data.meta_data">
      <div class="row">
        <label class="col-sm-6">Team Name</label>
        <p class="col col-sm-4"> WFI </p>
      </div>
      <div class="row">
        <label class="col-sm-6">Formation(s) Used & Playing Style </label>
        <p class="col col-sm-4"> {{report.report_data.meta_data.formation}} </p>
      </div>
      <div class="row">
        <label class="col-sm-6">Main threats </label>
        <p class="col col-sm-4"> {{report.report_data.meta_data.main_threats}} </p>
      </div>
      <div class="row" v-for="attachment in report.report_data.attachments.attachments" :key="attachment.id">
        <label class="col-sm-6">Attachment</label>
        <p class="col col-sm-4"> {{attachment.filename}} </p>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .list {
    text-transform: capitalize;
    &::after {
      content: ', '
    }
    &:last-child::after {
      content: ''
    }
  }

</style>

<script>
  import countrydata from 'country-data';

  export default {
    name: 'ClubReportPopup',
    props: ['report'],
    methods: {
      getLanguage(key) {
        return countrydata.languages[key].name;
      },
      getNationality(key) {
        return countrydata.countries[key].name;
      }
    },
  };
</script>