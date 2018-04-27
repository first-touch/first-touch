<template>
  <div class="wrapper ft-item">
    <div class="header-wrapper col-md-12">
      <div class="header col-md-12 row">
        <div class="col-md-4">
          <h5 class="title">Player Report</h5>
          <p class="id">{{report.id | reportId(report.type_report) }}</p>
        </div>
        <div class="col-md-8 buttons-inner">
          <button class="ft-button" @click="closeAction(report)"  >Close</button>
          <button class="ft-button-success" v-if="!report.is_free" @click="buyAction(report)" >Buy Report</button>
        </div>
      </div>
    </div>
    <p class="date">
      CREATED {{report.created_at | moment}}
      <br/>
    </p>
    <div class="content-wrapper">
      <div class="content col-md-12">
        <div class="img-container">
          <img class="img-fluid avatar" src="https://unsplash.it/500/500" />
        </div>
        <div class="info col-md-8">
          <h2 class="title" :title="report.headline">{{report.headline}}</h2>
          <div class="extra">
            <p class="summary-field row" v-if="report.price">
              <span class="summary-field-title col-md-4">Price:</span>
              <span class="col-md-8">{{report.price.value}} {{report.price.currency | currency}}</span>
            </p>
            <p class="summary-field row" v-if="playerInfo.height">
              <span class="summary-field-title col-md-4">Height:</span>
              <span class="col-md-8">{{playerInfo.height}} cm</span>
            </p>
            <p class="summary-field row" v-if="playerInfo.weight">
              <span class="summary-field-title col-md-4">Weight:</span>
              <span class="col-md-8">{{playerInfo.weight}} kg</span>
            </p>
            <p class="summary-field row" v-if="playerInfo.preferred_foot">
              <span class="summary-field-title col-md-4">Preferred Foot:</span>
              <span v-if="playerInfo.preferred_foot" class="col-md-8">{{playerInfo.preferred_foot | preferredFoot}}</span>
            </p>
            <p class="summary-field row" v-if="playerInfo.preferred_foot">
              <span class="summary-field-title col-md-4">Playing position(s):</span>
              <span class="col-md-8">
                <span v-for="position in playerInfo.playing_position" class="list" :key="position.id">{{position}}</span>
              </span>
            </p>
            <p class="summary-field row" v-if="playerInfo.languages">
              <label class="summary-field-title col-md-4">Language(s): </label>
              <span class="col-md-8">
                <span v-for="language in playerInfo.languages" class="list" :key="language.id">{{getLanguage(language)}}</span>
              </span>
            </p>
            <p class="summary-field row" v-if="playerInfo.residence_country_code">
              <span class="summary-field-title col-md-4">Based in:</span>
              <span class="col-md-8">{{getNationality(playerInfo.residence_country_code)}} </span>
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<style lang="scss">
  @import '~stylesheets/variables';
  @import '~stylesheets/form';
  .buttons-inner {
    button {
      float: right;
      margin-right: 20px;
    }
  }
</style>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  @import '~stylesheets/item';

  .id {
    margin-left: 20px;
  }
</style>
<script>
  import countrydata from 'country-data';

  export default {
    name: 'ReportItem',
    props: ['report', 'buyAction', 'closeAction'],
    computed: {
      playerInfo() {
        if (this.report.player) return this.report.player;
        if (this.report.meta_data.userinfo) return this.report.meta_data.userinfo;
      }
    },
    methods: {
      getLanguage(key) {
        return countrydata.languages[key] ? countrydata.languages[key].name : '';
      },
      getNationality(key) {
        return countrydata.countries[key] ? countrydata.countries[key].name : '';
      }
    }
  };
</script>
