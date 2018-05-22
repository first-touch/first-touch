<template>
  <div class="wrapper">
    <div class="header-wrapper col-lg-12">
      <div class="header col-lg-12 row">
        <div class="col-lg-4">
          <h5 class="title">Team Report</h5>
          <p class="id">{{report.id | reportId(report.type_report) }}</p>
        </div>
        <div class="col-lg-8 buttons-inner">
          <button class="ft-button" @click="closeAction(report)">Close</button>
          <button class="ft-button-success" v-if="!report.orders_status && !report.is_free" @click="buyAction(report)">Buy Report</button>
        </div>
      </div>
    </div>
    <p class="date">
      CREATED {{report.created_at | moment}}
    </p>
    <div class="content-wrapper">
      <div class="content col-lg-12">
        <div class="img-container">
          <img class="img-fluid avatar" src="https://unsplash.it/500/500" />
        </div>
        <div class="info col-lg-8">
          <h2 class="title" :title="report.headline">{{report.headline}}</h2>
          <div class="extra">
            <p class="summary-field row" v-if="report.price">
              <span class="summary-field-title col-lg-4">Price:</span>
              <span class="col-lg-8">{{report.price.value}} {{report.price.currency | currency}}</span>
            </p>
            <p class="summary-field row">
              <span class="summary-field-title col-lg-4">Team Name:</span>
              <span class="col-lg-8" v-if="report.team">{{report.team.team_name}}</span>
              <span class="col-lg-8" v-if="!report.team">{{report.search.team}}</span>
            </p>
            <p class="summary-field row">
              <span class="summary-field-title col-lg-4">Formation Used</span>
              <span class="col-lg-8">{{report.meta_data.formation}}</span>
            </p>
            <p class="summary-field row">
              <span class="summary-field-title col-lg-4">Main threats</span>
              <span class="col-lg-8">{{report.meta_data.main_threats}}</span>
            </p>
            <p class="summary-field row">
              <span class="summary-field-title col-lg-4">League:</span>
              <span class="col-lg-8" v-if="report.team">
                <span class="list" v-for="cp in report.team.competitions.competitions" :key="cp.id">{{cp.name}} </span>
              </span>
              <span class="col-lg-8" v-if="!report.team">
                <span v-if="report.league">
                  {{report.league.name}}
                </span>
                <span v-if="!report.league && report.meta_data.search">
                  {{report.meta_data.search.league}}
                </span>
              </span>
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

  .wrapper {
    padding: 0 0;
    color: $main-text-alpha-50;
    .date {
      font-size: 1.3em;
      margin: 20px 0 40px 0;
      padding: 0 30px;
    }
    .header-wrapper {
      padding: 0 30px;
      .header {
        .btn {
          background: $main-header-color;
          color: white;
          border: 0;
          border-radius: 12px;
        }
      }
    }

    .avatar {
      height: 300px;
      border-radius: 50%;
    }

    .title {
      color: $popup-title-color;
      font-size: $popup-title-font-size;
    }
    .content-wrapper {
      padding: 0 30px;
      display: flex;
      justify-content: space-between;
      .content {
        display: flex;
        .img-container {
          height: 200px;
          max-width: 200px;
          margin-right: 100px;
          .img-fluid {
            max-height: 100%;
          }
          .price {
            text-align: center;
          }
        }
        .info {
          display: flex;
          flex-direction: column;
          justify-content: center;
          .extra {
            text-transform: none;
            .player_name {
              color: $secondary-header-color;
              text-transform: uppercase;
              letter-spacing: 3px;
            }
            .target {
              display: block;
            }
            .author {
              color: #000;
            }
          }
        }
      }
    }
  }
</style>
<script>
  import countrydata from 'country-data';

  export default {
    name: 'ReportItem',
    props: ['report', 'buyAction', 'closeAction'],
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
