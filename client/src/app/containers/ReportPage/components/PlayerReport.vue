<template>
  <div class="report col-md-12">
  <div v-if="report.id">
    <div class="row">
      <p class="col-sm-4">Purchassed Price (IN SGD) {{report.price}} </p>
    </div>
    <div class="row">
      <span class="col-sm-12">Player Name :
    <router-link :to="'/users/' + report.player.id + '/profile'">{{report.player.first_name}} {{report.player.last_name}}</router-link>
           </span>
    </div>
    <div class="row">
      <span class="col-sm-12">Report Name : {{report.headline}} </span>
    </div>
    <div class="reportDate">
      <div class="row">
        <span class="col-sm-4">Create on {{report.report_data.created_at}} </span>
      </div>
      <div class="row">
        <span class="col-sm-4">Updated on {{report.report_data.updated_at}} </span>
      </div>
    </div>
    <div class="metas">
      <div class="row">
        <label class="col-sm-2">Age </label>
        <span class="col-sm-4"> {{report.report_data.meta_data.userinfo.age}} </span>
      </div>
      <div class="row">
        <label class="col-sm-2">Approximate Height </label>
        <span class="col-sm-4">{{report.report_data.meta_data.userinfo.weight}}</span>
      </div>
      <div class="row">
        <label class="col-sm-2">Approximate Weight </label>
        <span class="col-sm-4"> {{report.report_data.meta_data.userinfo.height}}</span>
      </div>

      <div class="row">
        <label class="col-sm-2">Nationality </label>
        <span class="col-sm-4">{{getNationality(report.report_data.meta_data.userinfo.nationality_country_code)}} </span>
      </div>

      <div class="row">
        <label class="col-sm-2">Based In</label>
        <span class="col-sm-4"> {{report.report_data.meta_data.userinfo.residence_country_code}}</span>
      </div>
      <div class="row">
        <label class="col-sm-2">Language(s) </label>
        <span class="col-sm-4"> <span v-for="language in report.report_data.meta_data.userinfo.languages" class="list" :key="language.id"> {{getLanguage(language)}} </span> </span>
      </div>
      <div class="row">
        <label class="col-sm-2">Position(s) </label>
        <span class="col-sm-4"> <span v-for="position in report.report_data.meta_data.userinfo.playing_position" class="list" :key="position.id">{{position}}</span> </span>
      </div>

      <div class="row">
        <label class="col-sm-2">Preferred Foot </label>
        <span class="col-sm-4"> {{report.report_data.meta_data.userinfo.preferred_foot == "R" ? "Right" : "Left"}} </span>
      </div>

      <div class="meta">
        <label class="row col-sm-12">Analyzed Matches</label>
        <p class="row col-sm-12"> </p>
      </div>
      <div class="meta">
        <label class="row col-sm-12">Current Ability Overview</label>
        <p class="row col-sm-12">{{report.report_data.meta_data.overview}} </p>
      </div>
      <div class="meta">
        <label class="row col-sm-12">Physical Attribute(s)</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.physical_attributes}} </p>
      </div>
      <div class="meta">
        <label class="row col-sm-12">Mental Attribute(s)</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.mental_attributes}} </p>
      </div>
      <div class="meta">
        <label class="row col-sm-12">Technical Attribute(s)</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.technical_attributes}} </p>
      </div>
      <div class="meta">
        <label class="row col-sm-12">Personality</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.personality}}</p>
      </div>
      <div class="meta">
        <label class="row col-sm-12">Potential</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.potential}} </p>
      </div>
      <div class="meta">
        <label class="row col-sm-12">Other Observations & Viewpoints To Note</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.observations}} </p>
      </div>
      <div class="meta">
        <label class="row col-sm-12">Conclusion</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.conclusion}} </p>
      </div>
      <div>
        <label class="row col-sm-12">Attachments</label>
        <div class="row col-sm-12">
          <button v-for="attachment in report.report_data.attachments.attachments" :key="attachment.id" class="btn-info btn-attachments" @click="downloadFile(attachment.id, attachment.filename)"> {{attachment.filename}}</button>

        </div>
      </div>
    </div>
     </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .report {
    background: white;
    color: black;
    padding: 50px;
    .reportDate {
      margin-left: 30px;
      margin-bottom: 20px;
    }
    .btn-attachments{
      cursor: pointer;
      padding: 20px;
      margin-right:20px;
    }
    .list {
      text-transform: capitalize;
    }
    .meta {
      margin: 20px 0;
      p {
        margin-left: 20px;
      }
    }
  }
</style>

<script>
  import countrydata from 'country-data';
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  export default {
    name: 'PlayerReport',
    props: [
      'report',
    ],
    data() {
      return {};
    },
    methods: {
      ...mapActions(['getAttachment']),
      downloadFile(id, filename){
        this.getAttachment({id, filename});
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