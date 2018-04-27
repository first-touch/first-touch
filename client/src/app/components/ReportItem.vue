<template>
  <div class="ft-item">
    <div class="header-wrapper">
      <div class="header col-md-10">
        <div class="img-container">
          <img class="img-fluid avatar" src="https://unsplash.it/500/500" />
        </div>
        <div class="info col-md-8">
          <h2 class="title" :title="report.headline">{{report.headline}}</h2>
          <p class="extra" v-if="report.type_report =='team'">
            <span class="field row">
              <span class="col-md-4">Report Id:</span>
              <span class="col-md-6"> {{report.id | reportId(report.type_report) }}
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Team Name:</span>
              <p class="col-md-6" v-if="report.team">{{report.team.team_name}}</p>
              <p class="col-md-6" v-if="!report.team">{{report.meta_data.search.team}}</p>
            </span>
            <span class="field row">
              <span class="col-md-4">Price:</span>
              <span class="col-md-6"> {{report.price.value}} {{report.price.currency | currency}}
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Last Update on:</span>
              <span class="col-md-6">{{report.updated_at | moment}}
              </span>
            </span>
          </p>
          <p class="extra" v-if="report.type_report =='player'">
            <span class="field row">
              <span class="col-md-4">Report Id:</span>
              <span class="col-md-6"> {{report.id | reportId(report.type_report) }}
              </span>
            </span>
            <span class="field row" v-if="report.player">
              <span class="col-md-4">Player name:</span>
              <span class="col-md-6" v-if="report.player">{{report.player.first_name}} {{report.player.last_name}}
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Based in: </span>
              <span class="col-md-6">{{getNationality(report.meta_data.userinfo.residence_country_code)}}
              </span>
            </span>
            <span class="field row" v-if="report.meta_data.userinfo.playing_position.length">
              <span class="col-md-4">Position in: </span>
              <span class="col-md-8">
                <span class="list" v-for="position in report.meta_data.userinfo.playing_position" :key="position.id">{{position}}</span>
              </span>
            </span>
            <span class="field yes row" v-if="report.meta_data.transfer_sum.loan_interested == 'yes'">
              <span class="col-md-12">Interested In Loan</span>
            </span>
            <span class="field yes row" v-if="report.meta_data.transfer_sum.transfer_interested  == 'yes'">
              <span class="col-md-12">Interested In Transfer</span>
            </span>
            <span class="field row">
              <span class="col-md-4">Price:</span>
              <span class="col-md-6" v-if="!report.is_free"> {{report.price.value}} {{report.price.currency | currency}}
              </span>
              <span class="col-md-6 yes" v-if="report.is_free"> Free
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Last Update on:</span>
              <span class="col-md-6">{{report.updated_at | moment}}
              </span>
            </span>
          </p>
        </div>
      </div>
      <div class="widget">
        <a v-if="own && report.status == 'publish'" @click="UpdateReport('private',report.id)">
          <button class="btn-round">Unpublish</button>
        </a>
        <a v-if="own && report.status == 'private'" @click="UpdateReport('publish',report.id)">
          <button class="btn-round">Publish</button>
        </a>


        <a v-if="report.orders_status == null && typeof BuyAction === 'function'">
          <button class="btn-round" @click="BuyAction(report)">Buy report</button>
        </a>
        <a v-if="typeof summaryAction === 'function'">
          <button class="btn-round" @click="summaryAction(report)">View Summary</button>
        </a>
        <a v-if="report.orders_status == 'completed'">
          <button class="btn-round" @click="refundAction(report)">Refund</button>
        </a>
        <a v-if="own || report.orders_status == 'completed' || report.is_free">
          <button class="btn-round" @click="viewAction(report)">View report</button>
        </a>
        <p v-if="report.orders_status == 'pending'">Payment in pending</p>

      </div>
    </div>
  </div>
</template>
<style lang="scss" scoped>
@import '~stylesheets/variables';
@import '~stylesheets/light_item';
</style>
<script>
import countrydata from 'country-data';

export default {
  name: 'ReportItem',
  props: [
    'report',
    'UpdateReport',
    'viewAction',
    'summaryAction',
    'BuyAction',
    'refundAction',
    'own'
  ],
  methods: {
    getLanguage(key) {
      return countrydata.languages[key] ? countrydata.languages[key].name : key;
    },
    getNationality(key) {
      return countrydata.countries[key] ? countrydata.countries[key].name : key;
    }
  }
};
</script>
