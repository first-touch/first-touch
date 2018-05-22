<template>
  <div class="item-container">
    <div class="ft-item" v-if="report && (!mode || mode == 'widget')">
      <div class="header-wrapper">
        <div class="header col-lg-10">
          <div class="img-container">
            <img class="img-fluid avatar" src="https://unsplash.it/500/500" />
            <router-link v-if="!own" :to="{ name: 'userProfilePage', params: { id: report.user.id }}" target="_blank">{{report.user.first_name}} {{report.user.last_name}}</router-link>
          </div>
          <div class="info col-lg-8 col-md-10">
            <h2 class="title" :title="report.headline">{{report.headline}}</h2>
            <p class="extra" v-if="report.type_report =='team'">
              <span class="field row">
                <span class="col-lg-4">Report Id:</span>
                <span class="col-lg-6"> {{report.id | reportId(report.type_report) }}
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Report Type:</span>
                <span class="col-lg-6 capitalize"> {{report.type_report}}
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Team Name:</span>
                <p class="col-lg-6" v-if="report.team">{{report.team.team_name}}</p>
                <p class="col-lg-6" v-if="!report.team && report.search">{{report.search.team}}</p>
              </span>
              <span class="field row">
                <span class="col-lg-4">Price:</span>
                <span class="col-lg-6" v-if="!report.is_free"> {{report.price.value}} {{report.price.currency | currency}}
                </span>
                <span class="col-lg-6 yes" v-if="report.is_free"> Free
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Last Update on:</span>
                <span class="col-lg-6">{{report.updated_at | moment}}
                </span>
              </span>
            </p>
            <p class="extra" v-if="report.type_report =='player'">
              <span class="field row">
                <span class="col-lg-4">Report Id:</span>
                <span class="col-lg-6"> {{report.id | reportId(report.type_report) }}
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Report Type:</span>
                <span class="col-lg-6 capitalize"> {{report.type_report}}
                </span>
              </span>
              <span class="field row" v-if="report.player || report.search">
                <span class="col-lg-4">Player name:</span>
                <span class="col-lg-6" v-if="report.player">{{report.player.first_name}} {{report.player.last_name}}
                </span>
                <span class="col-lg-6" v-if="report.search">{{report.search.player}}
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Based in: </span>
                <span class="col-lg-6">{{getNationality(report.meta_data.player_info.residence_country_code)}}
                </span>
              </span>
              <span class="field row" v-if="report.meta_data.player_info.playing_position.length">
                <span class="col-lg-4">Position in: </span>
                <span class="col-lg-8">
                  <span class="list" v-for="position in report.meta_data.player_info.playing_position" :key="position.id">{{position}}</span>
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Price:</span>
                <span class="col-lg-6" v-if="!report.is_free"> {{report.price.value}} {{report.price.currency | currency}}
                </span>
                <span class="col-lg-6 yes" v-if="report.is_free"> Free
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Last Update on:</span>
                <span class="col-lg-6">{{report.updated_at | moment}}
                </span>
              </span>
            </p>
          </div>
        </div>
        <div class="widget buttons-inner col-lg-2 col-md-5 col-sm-4">
          <button class="btn-round" v-if="own && report.status == 'publish'" @click="UpdateReport('private',report.id)">Unpublish</button>
          <button v-if="own && report.status == 'private'" class="ft-action" @click="UpdateReport('publish',report.id)">Publish</button>
          <button v-if="report.orders_status == null && !report.is_free &&  typeof buyAction === 'function'" class="ft-button ft-button-success "
            @click="buyAction(report)">Buy report</button>
          <button v-if="typeof summaryAction === 'function'" class="btn-round" @click="summaryAction(report)">View Summary</button>
          <button v-if="report.orders_status == 'completed'" class="btn-round" @click="refundAction(report)">Refund</button>
          <button v-if="own || report.orders_status == 'completed' || report.is_free" class="btn-round" @click="viewAction(report)">View report</button>
          <p v-if="report.orders_status == 'pending'">Payment in pending</p>

        </div>
      </div>
    </div>
    <tr v-if="report.type_report && mode == 'table'" class="report-tr table-item">
      <td v-for="field in fields" :key="field.id">
        <span v-if="field == 'id'" class="contents">
          {{report.id | reportId(report.type_report) }}
        </span>
        <span v-if="field == 'scout'" class="contents">
          <p class="capitalize">
            <router-link :to="{ name: 'userProfilePage', params: { id: report.user.id }}" target="_blank">{{report.user.first_name}} {{report.user.last_name}}</router-link>
          </p>
        </span>
        <span v-if="field == 'submitted'" class="contents">
          {{ report.created_at | moment }}
        </span>
        <span v-if="field == 'headline'" class="contents">
          {{report.headline}}
        </span>
        <span v-if="field == 'price'" class="contents">
          <span v-if="report.is_free" class="yes">Free</span>
          <span v-if="!report.is_free"> {{report.price.value}} </span>
        </span>
        <span v-if="field == 'priceCurrency'" class="contents">
          <span>{{report.price.value}} {{report.price.currency}} </span>
        </span>
        <span v-if="field == 'status'" class="contents">
          <p class="capitalize">
            {{report.status}}
          </p>
        </span>
        <span v-if="field == 'completion_status'" class="contents">
          <p class="capitalize">
            {{report.completion_status}}
          </p>
        </span>
        <span v-if="field == 'action'" class="contents">
          <div class="table-action row">
            <div class="col col-lg-8 first-action">
              <a v-if="canAction(!own && typeof buyAction === 'function' && (report.orders_status != 'completed' && !report.is_free),'buy', true)"
                class="ft-action col-lg-8">
                <button class="btn-round" @click="buyAction(report)">Buy</button>
              </a>
              <a v-if="canAction(own || report.orders_status == 'completed' || report.is_free,'view_report',true)" class="ft-action col-lg-8">
                <button class="btn-round" @click="viewAction(report)">View report</button>
              </a>
              <a v-if="canAction(report.orders_status == 'completed' || (report.completion_status == 'pending' && !own ), 'refund', true)"
                class="ft-action col-lg-8">
                <button class="btn-round" @click="viewAction(report)">Refund</button>
              </a>
              <p v-if="canAction(report.orders_status == 'pending', 'in_pending', true)" class="ft-action col-lg-10">Payment in pending</p>
            </div>
            <div class="more col-lg-1" v-if="listAction">
              <icon name="ellipsis-v"></icon>
              <div class="action">
                <div class="content">
                  <a v-if="canAction(typeof summaryAction === 'function', 'view_summary', false)" @click="summaryAction(report)">
                    View Summary
                  </a>
                  <a v-if="canAction(own && report.status == 'publish', 'unpublish', false)" @click="UpdateReport('private',report.id)">
                    Unpublish
                  </a>
                  <a v-if="canAction(own && report.status == 'private', 'publish', false)" @click="UpdateReport('publish',report.id)">
                    Publish
                  </a>
                  <a v-if="canAction(report.orders_status == 'completed' || (report.completion_status == 'pending' && !own ), 'refund', false)">
                    Refund
                  </a>
                </div>
                <span class="down-arrow"></span>
              </div>
            </div>
          </div>
        </span>
      </td>
    </tr>
  </div>
</template>
<style lang="scss" scoped>
  @import '~stylesheets/variables';
  @import '~stylesheets/light_item';
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
    data() {
      return {
        firstAction: '',
        listAction: true,
        afterMountedAction: false
      }
    },
    mounted() {
      this.listAction = this.afterMountedAction;
    },
    methods: {
      getLanguage(key) {
        return countrydata.languages[key] ? countrydata.languages[key].name : key;
      },
      getNationality(key) {
        return countrydata.countries[key] ? countrydata.countries[key].name : key;
      },
      canAction(condition, actionName, first) {
        if (condition == true) {
          if (first) {
            if (this.firstAction != '' && this.firstAction != actionName)
              return false;
            this.firstAction = actionName;
            return true;
          } else if (!first && this.firstAction != actionName) {
            this.afterMountedAction = true;
            return true;
          }
        }
        return false;
      },
    }
  };
</script>
