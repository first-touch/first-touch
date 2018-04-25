<template>
  <div class="report col-md-12">
    <div v-if="report.id">
      <timeline-item>
        <h5 class="col-md-9">{{report.headline}}</h5>
        <div class="header row col-md-12">
          <div class="row col col-sm-6">
            <p class="col-sm-2">UPDATED </p>
            <p class="col-md-5"> {{report.created_at | moment}}</p>
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
              <h4 class="name" v-if="report.player">{{report.player.first_name}} {{report.player.last_name}}</h4>
              <p class="role">Football Player</p>
              <p class="club">Real Madrid FC, Spain</p>
              <p class="detail">
                <span class="detail-title">Age:</span>
                {{ report.meta_data.userinfo.age }}
              </p>
              <p class="detail">
                <span class="detail-title">Nationality:</span>
                {{getNationality(report.meta_data.userinfo.nationality_country_code)}}
              </p>
              <p class="detail">
                <span class="detail-title">Place of birth:</span>
                {{getNationality(report.meta_data.userinfo.nationality_country_code)}}
              </p>
            </div>
          </div>
          <hr />
          <div class="bottom">
            <div class="summary">
              <h5 class="summary-title">Summary</h5>
              <p class="summary-field" v-if="report.player">{{report.player.first_name}} {{report.player.last_name}}</p>
              <p class="summary-field">
                <span class="summary-field-title">Height:</span>
                {{report.meta_data.userinfo.height}} cm
              </p>
              <p class="summary-field">
                <span class="summary-field-title">Weight:</span>
                {{report.meta_data.userinfo.weight}} kg
              </p>
              <p class="summary-field">
                <span class="summary-field-title">Preferred Foot:</span>
                {{report.meta_data.userinfo.preferred_foot | preferredFoot}}
              </p>
              <p class="summary-field">
                <label class="summary-field-title">Language(s): </label>
                <span class="">
                  <span v-for="language in report.meta_data.userinfo.languages" class="list" :key="language.id">{{getLanguage(language)}}</span>
                </span>
              </p>
              <p class="summary-field">
                <span class="summary-field-title">Based in:</span>
                {{getNationality(report.meta_data.userinfo.residence_country_code)}}
              </p>
            </div>
            <div class="position">
              <p class="position-title">Playing position(s):</p>
              <p class="position-content">
                <span v-for="position in report.meta_data.userinfo.playing_position" class="list" :key="position.id">{{position}}</span>
              </p>
              <img class="img-fluid position-map" src="http://www.conceptdraw.com/solution-park/resource/images/solutions/soccer/Sport-Soccer-Football-Formation-4-4-1-1.png"
              />
            </div>
          </div>
        </div>
      </timeline-item>
      <timeline-item>
        <div class="content">
          <h5 class="summary-title">
            Contract Summary
          </h5>
          <div class="contract-summary">
            <div class="row" v-if="report.meta_data.transfer_sum.wage.value">
              <label class="col-sm-4 summary-title">Wage </label>
              <span class="col-sm-4 summary-field"> {{report.meta_data.transfer_sum.wage.value}} {{report.meta_data.transfer_sum.wage.currency
                | currency}} </span>
            </div>
            <div class="row">
              <span class="col col-md-12 transfer-title summary-title">
                <icon v-if="report.meta_data.transfer_sum.transfer_interested !== 'No'" name="check"></icon>
                <icon v-if="report.meta_data.transfer_sum.transfer_interested === 'No'" name="times"></icon>
                Interested in Transfer</span>
            </div>
            <div class="row values" v-if="report.meta_data.transfer_sum.transfer_interested !== 'No'">
              <div class="col-md-6">
                <label class="col-sm-8 summary-title">Availability for transfer</label>
                <span class="col-sm-4 summary-field"> {{report.meta_data.transfer_sum.transfer_availability.value }} {{report.meta_data.transfer_sum.transfer_availability.currency
                  | currency }}</span>
              </div>
              <div class="col-md-6">
                <label class="col-sm-6 summary-title">Transfer Budget</label>
                <span class="col-sm-6 summary-field"> {{report.meta_data.transfer_sum.transfer_budget.value}} {{report.meta_data.transfer_sum.transfer_budget.currency
                  | currency}}</span>
              </div>
            </div>
            <div class="row">
              <label class="col-sm-4 transfer-title summary-title">
                <icon v-if="report.meta_data.transfer_sum.loan_interested !== 'No'" name="check"></icon>
                <icon v-if="report.meta_data.transfer_sum.loan_interested === 'No'" name="times"></icon>Interested in Loan</label>
            </div>
            <div class="row values" v-if="report.meta_data.transfer_sum.loan_interested !== 'No'">
              <div class="col-md-6" v-if="report.meta_data.transfer_sum.loan_availability.value">
                <label class="col-sm-6 summary-title">Availability for Loan</label>
                <span class="col-sm-4 summary-field"> {{report.meta_data.transfer_sum.loan_availability.value}} {{report.meta_data.transfer_sum.loan_availability.currency
                  | currency}}</span>
              </div>
              <div class="col-md-6" v-if="report.meta_data.transfer_sum.contract_end">
                <label class="col-sm-4 summary-title">End of Contract</label>
                <span class="col-sm-4 summary-field"> {{report.meta_data.transfer_sum.contract_end}} </span>
              </div>
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
            <matchanalyzed :analyzed_matches="report.meta_data.analyzed_matches" type="player" mode="read" />
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Current Ability Overview</label>
            <p class="row col-sm-12">{{report.meta_data.overview}} </p>
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Physical Attribute(s)</label>
            <p class="row col-sm-12"> {{report.meta_data.physical_attributes}} </p>
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Mental Attribute(s)</label>
            <p class="row col-sm-12"> {{report.meta_data.mental_attributes}} </p>
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Technical Attribute(s)</label>
            <p class="row col-sm-12"> {{report.meta_data.technical_attributes}} </p>
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Personality</label>
            <p class="row col-sm-12"> {{report.meta_data.personality}}</p>
          </div>
          <div class="meta">
            <label class="row col-sm-12 summary-title">Potential</label>
            <p class="row col-sm-12"> {{report.meta_data.potential}} </p>
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
            <div class="row col-sm-12 buttons-inner">
              <button v-for="attachment in report.attachments.attachments" :key="attachment.id" class="btn-info btn-attachments ft-button"
                @click="downloadFile(attachment.id, attachment.filename)"> {{attachment.filename}}</button>

            </div>
          </div>
        </div>
      </timeline-item>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
@import '~stylesheets/form';

h5 {
  color: $main-text-color;
  font-size: 1.5em;
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
    .role,
    .club,
    .detail {
      color: $main-text-color;
    }
    .role {
      font-size: 1.2em;
    }
    .detail-title {
      color: $secondary-text-color;
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
  .position {
    flex: 1 0 45%;
    display: flex;
    flex-direction: column;
    align-items: center;
    .position-title {
      color: $secondary-text-color;
      font-size: 1.2em;
      margin-bottom: 0;
    }
    .position-content {
      color: $main-text-color;
      font-size: 1.2em;
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
    .player-summary,
    .contract-summary {
      padding: 20px;
      .transfer-title {
        color: $main-text-color;
        padding: 0;
        margin: 0;
      }
      .values {
        padding: 10px 40px;
        .summary-title {
          color: $main-text-color;
        }
        .summary-field {
          padding: 0;
          margin: 0;
        }
      }
    }
    .list {
      text-transform: capitalize;
      &:not(:last-child):after {
        content: ', ';
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
