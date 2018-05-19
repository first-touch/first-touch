<template>
  <div class="item-container">
    <div class="ft-item" v-if="report && (!mode || mode == 'widget')">
      <div class="header-wrapper">
        <div class="header col-md-10">
          <div class="img-container">
            <img class="img-fluid avatar" src="https://unsplash.it/500/500" />
            <router-link v-if="!own" :to="{ name: 'userProfilePage', params: { id: report.user.id }}" target="_blank">{{report.user.first_name}} {{report.user.last_name}}</router-link>
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
                <span class="col-md-4">Report Type:</span>
                <span class="col-md-6 capitalize"> {{report.type_report}}
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Team Name:</span>
                <p class="col-md-6" v-if="report.team">{{report.team.team_name}}</p>
                <p class="col-md-6" v-if="!report.team && report.search">{{report.search.team}}</p>
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
            <p class="extra" v-if="report.type_report =='player'">
              <span class="field row">
                <span class="col-md-4">Report Id:</span>
                <span class="col-md-6"> {{report.id | reportId(report.type_report) }}
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Report Type:</span>
                <span class="col-md-6 capitalize"> {{report.type_report}}
                </span>
              </span>
              <span class="field row" v-if="report.player || report.search">
                <span class="col-md-4">Player name:</span>
                <span class="col-md-6" v-if="report.player">{{report.player.first_name}} {{report.player.last_name}}
                </span>
                <span class="col-md-6" v-if="report.search">{{report.search.player}}
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Based in: </span>
                <span class="col-md-6">{{getNationality(report.meta_data.player_info.residence_country_code)}}
                </span>
              </span>
              <span class="field row" v-if="report.meta_data.player_info.playing_position.length">
                <span class="col-md-4">Position in: </span>
                <span class="col-md-8">
                  <span class="list" v-for="position in report.meta_data.player_info.playing_position" :key="position.id">{{position}}</span>
                </span>
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
        <div class="widget buttons-inner">
          <a v-if="own && report.status == 'publish'" @click="UpdateReport('private',report.id)">
            <button class="btn-round">Unpublish</button>
          </a>
          <a v-if="own && report.status == 'private'" @click="UpdateReport('publish',report.id)">
            <button class="btn-round">Publish</button>
          </a>
          <a v-if="report.orders_status == null && !report.is_free &&  typeof buyAction === 'function'">
            <button class="btn-round" @click="buyAction(report)">Buy report</button>
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
    <tr v-if="mode == 'table'" class="report-tr table-item">
      <td v-if="fields.indexOf('id') >=0">{{report.id | reportId(report.type_report) }}</td>
      <td class="capitalize" v-if="fields.indexOf('scout') >=0">
        <router-link :to="{ name: 'userProfilePage', params: { id: report.user.id }}" target="_blank">{{report.user.first_name}} {{report.user.last_name}}</router-link>
      </td>
      <td v-if="fields.indexOf('submitted') >=0"> {{ report.created_at | moment }} </td>
      <td v-if="fields.indexOf('headline') >=0"> {{report.headline}}</td>
      <td v-if="fields.indexOf('price') >=0">
        <span v-if="report.is_free" class="yes">Free</span>
        <span v-if="!report.is_free"> {{report.price.value}} </span>
      </td>
      <td v-if="fields.indexOf('priceCurrency') >=0">
        <span v-if="report.is_free" class="yes">Free</span>
        <span v-if="!report.is_free"> {{report.price.value}} {{report.price.currency | currency}}</span>
      </td>
      <td v-if="fields.indexOf('status') >=0" class="capitalize">
        {{report.status}}
      </td>
      <td class="table-action widget col-lg-12" v-if="fields.indexOf('action') >=0">
        <a v-if="!own && typeof buyAction === 'function' && (report.orders_status != 'completed' && !report.is_free)" class="ft-action col-lg-8">
          <button class="btn-round" @click="buyAction(report)">Buy</button>
        </a>
        <a v-if="own || report.orders_status == 'completed' || report.is_free" class="ft-action col-lg-8">
          <button class="btn-round" @click="viewAction(report)">View report</button>
        </a>
        <a v-if="report.status == 'pending'" class="ft-action col-lg-8">
          <button class="btn-round" @click="viewAction(report)">Refund</button>
        </a>
        <p v-if="report.orders_status == 'pending'" class="ft-action col-lg-10">Payment in pending</p>

        <div class="more col-lg-2">
          <icon name="ellipsis-v"></icon>
          <div class="action">
            <div class="content">
              <a v-if="typeof summaryAction === 'function'" @click="summaryAction(report)">
                View Summary
              </a>
              <a v-if="own && report.status == 'publish'" @click="UpdateReport('private',report.id)">
                Unpublish
              </a>
              <a v-if="own && report.status == 'private'" @click="UpdateReport('publish',report.id)">
                Publish
              </a>
              <a v-if="report.orders_status == 'completed'">
                Refund
              </a>
            </div>
            <span class="down-arrow"></span>
          </div>
        </div>
      </td>
    </tr>
  </div>
</template>
<style lang="scss" scoped>
  @import '~stylesheets/variables';
  @import '~stylesheets/light_item';
  .buttons-inner {
    a {
      button {
        padding: 5px;
        width: 150px
      }
    }
  }

  svg {
    margin: 2px;
  }

  button {
    width: 100%;
  }

  td {
    // font-size: 12px;
    color: $secondary-text-color;
  }

  .item-container {
    display: contents;
  }
</style>
<script>
  import countrydata from 'country-data';
  import 'vue-awesome/icons/ellipsis-v';
  import Icon from 'vue-awesome/components/Icon';

  export default {
    name: 'ReportItem',
    props: [
      'report',
      'UpdateReport',
      'viewAction',
      'summaryAction',
      'buyAction',
      'refundAction',
      'own',
      'mode',
      'fields'
    ],
    components: {
      icon: Icon,
    },
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
