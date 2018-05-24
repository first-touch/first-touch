<template>
  <div class="report col-md-12">
    <div v-if="report.id">
      <timeline-item>
        <h5 class="col-md-12">{{report.headline}}</h5>
        <div class="header row col-md-12">
          <div class="row col col-sm-6">
            <p class="col-sm-4">UPDATED </p>
            <p class="col-md-5"> {{report.meta_data.created_at | moment}}</p>
          </div>
          <div class="row col col-sm-6">
            <p class="col-sm-5">Price: </p>
            <p class="col-md-7">{{report.price.value}} {{report.price.currency | currency}}</p>
          </div>
        </div>
        <div class="content">
          <div class="top">
            <img class="img-fluid avatar" src="https://unsplash.it/500/500" />
            <div class="info">
              <h4 class="name" v-if="report.team">{{report.team.team_name}}</h4>
              <h4 class="name" v-if="!report.team">{{report.meta_data.search.team}}</h4>
            </div>
          </div>
          <hr />
          <div class="bottom">
            <div class="summary">
              <h5 class="summary-title">Summary</h5>
              <p class="summary-field" v-if="report.team && report.team.competitions">
                <span class="summary-field-title">League:</span>
                <span class="list" v-for="cp in report.team.competitions.competitions" :key="cp.id">{{cp.name}} </span>
              </p>
              <p class="summary-field" v-if="!report.team">
                <span class="summary-field-title">League:</span>
                <span v-if="report.league">
                  {{report.league.name}}
                </span>
                <span v-if="!report.league">
                  {{report.meta_data.search.league}}
                </span>
              </p>
            </div>
          </div>
        </div>
      </timeline-item>
      <timeline-item>
        <div class="content">
          <h5 class="summary-title">
            Details
          </h5>
          <div>
            <label class="row col-sm-12 summary-title">Analyzed Matches</label>
            <matchanalyzed :analyzed_matches="report.meta_data.analyzed_matches" type="team" mode="read" />
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Formations(s) Used & playing Style</label>
            <p class="row col-sm-12">{{report.meta_data.formation}} </p>
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Attacking Organisation & Transition After winnig possession</label>
            <p class="row col-sm-12">{{report.meta_data.attacking_organisation}} </p>
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Defensive Organisation & Transition After losing possession</label>
            <p class="row col-sm-12"> {{report.meta_data.defensive_organisation}} </p>
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Set Plays - For</label>
            <p class="row col-sm-12"> {{report.meta_data.setplays_for}} </p>
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Set Plays - Against</label>
            <p class="row col-sm-12"> {{report.meta_data.setplays_against}}</p>
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Main Threats</label>
            <p class="row col-sm-12"> {{report.meta_data.main_threats}} </p>
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Other Observations & Viewpoints To Note</label>
            <p class="row col-sm-12"> {{report.meta_data.observations}} </p>
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Conclusion</label>
            <p class="row col-sm-12"> {{report.meta_data.conclusion}} </p>
          </div>
          <div>
            <label class="row col-sm-12 summary-title">Attachments</label>
            <div class="row col-sm-12">
              <button v-for="attachment in report.attachments.attachments" :key="attachment.id" class="btn-info btn-attachments" @click="downloadFile(attachment.id, attachment.filename)">
                {{attachment.filename}}</button>

            </div>
          </div>
        </div>
      </timeline-item>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  h5 {
    color: $main-text-color;
    font-size: 1.5em;
  }

  .summary-report {
    display: flex;
    border-left: 7px solid #a8cb5c;
    margin-top: 20px;
  }

  .arrow {
    width: 0;
    height: 0;
    margin-right: 20px;
    border-top: 7px solid transparent;
    border-bottom: 7px solid transparent;
    border-left: 7px solid;
    margin-top: 18px;
    border-left-color: $main-header-color;
  }

  .summary-report-container {
    background-color: $form-background;
    border-radius: 5px;
    width: 100%;
    padding: 20px 10px;
    flex: 1 0 55%;
    .summary-title {
      color: $secondary-text-color;
      text-transform: uppercase;
      margin-bottom: 20px;
    }
    .summary-field {
      color: $main-text-color;
      margin-bottom: 5px;
    }
  }

  .top {
    display: flex;
    .avatar {
      margin-right: 10%;
      height: 300px;
      border-radius: 50%;
    }
    .info {
      margin-top: 40px;
      margin-left: 20px;
      flex: 1 0 calc(100% - 320px);
      .name {
        color: $main-header-color;
        text-transform: uppercase;
      }
      .detail {
        color: $main-text-color;
      }
      .role {
        font-size: 1.2em;
      }
    }
  }

  .bottom {
    display: flex;
    margin-top: 30px;
    .summary {
      flex: 1 0 55%;
      .summary-title {
        color: $secondary-text-color;
        text-transform: uppercase;
        margin-bottom: 20px;
      }
      .summary-field {
        color: $main-text-color;
        margin-bottom: 5px;
      }
    }
  }

  .report {
    padding: 0;
    font-family: 'Ubuntu', sans-serif;
    font-size: 12pt;
    .header {
      padding: 20px;
    }
    .content {
      padding: 20px 50px;
      color: $main-text-color;
      .fa-icon {
        margin-right: 20px;
        color: #a8cb5c;
      }
      .btn-attachments {
        margin: 0;
        padding: 4px;
        border-radius: 4px;
        color: white;
        min-height: 20px;
        color: $main-text-color;
        border: 1px solid $main-text-color;
        background-color: $button-background;
        margin-right: 10px;
        cursor: pointer;
        &:hover {
          background-color: $button-background-hover;
        }
      }
      .meta {
        margin: 20px 0;
        p {
          margin-left: 20px;
        }
      }
    }
  }
</style>

<script>
  import 'vue-awesome/icons/user';
  import 'vue-awesome/icons/handshake';
  import 'vue-awesome/icons/check';
  import 'vue-awesome/icons/times';
  import MatchAnalyzed from 'app/components/Input/MatchAnalyzed';
  import Icon from 'vue-awesome/components/Icon';
  import countrydata from 'country-data';
  import TimelineItem from 'app/components/TimelineItem';

  export default {
    name: 'PlayerReport',
    props: ['report', 'downloadFile'],
    components: {
      icon: Icon,
      matchanalyzed: MatchAnalyzed,
      'timeline-item': TimelineItem
    },
    data() {
      return {};
    },
    methods: {
      getLanguage(key) {
        return countrydata.languages[key] ? countrydata.languages[key].name : 'key';
      },
      getNationality(key) {
        return countrydata.countries[key] ? countrydata.countries[key].name : 'key';
      }
    }
  };
</script>
