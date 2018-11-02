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
                <span class="col-lg-6" v-if="report.team">{{report.team.team_name}}</span>
                <span class="col-lg-6" v-if="!report.team && report.search">{{report.search.club}}</span>
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
              <span class="field row" v-if="report.meta_data.player_info.playing_position.length">
                <span class="col-lg-4">Position in: </span>
                <playerposition class="col-lg-8" :value="report.meta_data.player_info.playing_position" readonly />
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
          <button class="btn-round" v-if="own && report.status == 'publish' && !report.has_request" @click="UpdateReport('private',report.id)">Unpublish</button>
          <button v-if="own && report.status == 'private' && !report.has_request" class="ft-action" @click="UpdateReport('publish',report.id)">Publish</button>
          <button v-if="report.orders_status == null && !report.is_free &&  buyAction" class="ft-button ft-button-success " @click="buyAction(report)">Buy report</button>
          <button v-if="summaryAction" class="btn-round" @click="summaryAction(report)">View Summary</button>
          <button v-if="report.orders_status == 'completed' && refundAction" class="btn-round" @click="refundAction(report.id)">Refund</button>
          <button v-if="own || report.orders_status == 'completed' || report.is_free" class="btn-round" @click="viewAction(report)">View report</button>
          <p v-if="report.orders_status == 'pending'">Payment in pending</p>

        </div>
      </div>
    </div>
    <tr v-if="report.type_report && mode == 'table'" class="report-tr table-item" :class="{'purchased' : isPurchased}">
      <td v-for="field in widgets" :key="field.id">
        <span v-if="field == 'id'" class="contents">
          {{report.id | reportId(report.type_report) }}
        </span>
        <span v-if="field == 'type2c'" class="contents">
          {{report.type_report == 'player'? 'PL':'TM' }}
        </span>
        <span v-if="field == 'player2c' && report.type_report == 'player'" class="contents highlight" :title="playerName">
          <router-link v-if="report.player" :to="{ name: 'userProfilePage', params: { id: report.player.id }}"> {{ playerName | twoChars}}
          </router-link>
          <span v-if="!report.player" >
            {{ playerName | twoChars}}
          </span>
        </span>
        <span v-if="field == 'position' && report.type_report == 'player' " class="contents positions">
          <playerposition class="col-lg-8 capitalize highlight" :value="positions" :readonly="true" v-if="positions" />
        </span>
        <span v-if="field == 'foot' && report.type_report == 'player' " class="contents">
          {{playerInfo.preferred_foot | preferredFoot }}
        </span>
        <span v-if="field == 'height' && report.type_report == 'player'" class="contents">
          {{playerInfo.height }}
        </span>
        <span v-if="field == 'weight' && report.type_report == 'player'" class="contents">
          {{playerInfo.weight }}
        </span>
        <span v-if="field == 'nationality' && report.type_report == 'player'" class="contents">
          {{getNationality(playerInfo.nationality_country_code) }}
        </span>
        <span v-if="field == 'scout'" class="contents">
          <p class="capitalize highlight">
            <router-link :to="{ name: 'userProfilePage', params: { id: report.user.id }}" target="_blank">{{report.user.first_name}} {{report.user.last_name}}</router-link>
          </p>
        </span>
        <span v-if="field == 'submitted'" class="contents">
          {{ report.created_at | moment }}
        </span>
        <span v-if="field == 'updated'" class="contents" :title="titleDate">
          {{ report.updated_at | moment }}
          <span class="icon-inner icon-inner-update" v-if="titleDate">
            <icon name="exclamation-triangle"></icon>
          </span>
        </span>
        <span v-if="field == 'headline'" class="contents">
          {{report.headline}}
        </span>
        <span v-if="field == 'club'" class="contents highlight">
          {{clubName}}
        </span>
        <span v-if="field == 'category'" class="contents capitalize">
          {{teamName}}
        </span>
        <span v-if="field == 'competition'" class="contents">
          <span class="list capitalize highlight" v-for="c in competitionName" :key="c.id">{{c}} </span>
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
          <div class="table-action row buttons-inner">
            <div class="col col-lg-8 first-action">
              <a v-if="canAction(!own && buyAction && (report.orders_status != 'completed' && !report.is_free),'buy', true)" class="ft-action col-lg-12">
                <button class="btn-round" @click="buyAction(report)">Purchase</button>
              </a>
              <div v-if="canAction(!own && buyActionWithPrice && (report.orders_status != 'completed' && !report.is_free),'buy', true)">
                <button class="ft-button-success col-lg-8" @click="buyActionWithPrice(report)">Purchase</button>
                <span class="price col-lg-12">{{report.price.currency | currency}}{{report.price.value}}</span>
              </div>

              <a v-if="canAction(own || report.orders_status == 'completed' || report.is_free,'view_report',true)  && viewAction" class="ft-action col-lg-12">
                <button class="ft-button-third" @click="viewAction(report)">View report</button>
              </a>
              <a v-if="canAction(report.orders_status == 'completed' || (report.completion_status == 'pending' && !own ), 'refund', true)  && refundAction"
                class="ft-action col-lg-12">
                <button class="btn-round" @click="refundAsked ? null : refundAction(report.id )" :title="refundAsked ? 'You refund enquiry has already been sent' : ''">Refund</button>
              </a>
              <p v-if="canAction(report.orders_status == 'pending', 'in_pending', true)" class="ft-action col-lg-10">Payment in pending</p>
            </div>
            <div class="more col-lg-1" v-if="listAction">
              <icon name="ellipsis-v"></icon>
              <div class="action">
                <div class="content">
                  <a v-if="canAction(summaryAction, 'view_summary', false)" @click="summaryAction(report)">
                    View Summary
                  </a>
                  <a v-if="canAction(own && report.status == 'publish' && !report.has_request, 'unpublish', false)" @click="UpdateReport('private',report.id)">
                    Unpublish
                  </a>
                  <a v-if="canAction(own && report.status == 'private' && !report.has_request, 'publish', false)" @click="UpdateReport('publish',report.id)">
                    Publish
                  </a>
                  <a v-if="canAction(canRefund(), 'refund', false)" @click="refundAsked ? null : refundAction(report.id )" :title="refundAsked ? 'You refund enquiry has already been sent' : ''">
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
<style lang="scss">
  .report-tr {
    .positions {
      .read {
        max-width: 130px;
        .list {
          display: block;
          white-space: nowrap;
          overflow: hidden;
          text-overflow: ellipsis;
        }
      }
    }
  }
</style>
<style lang="scss" scoped>
  @import '~stylesheets/variables';
  @import '~stylesheets/light_item';
  .icon-inner-update {
    color: rebeccapurple;
  }

  .item-container {
    display: contents;
    .table-item {
      font-size: 0.8em;
    }
    .list {
      display: block;
    }
    .purchased {
      a,
      .highlight {
        color: $third-header-color;
      }
    }
    a,
    .highlight {
      color: $main-header-color;
    }
    .buttons-inner {
      text-align: center;
      float: none;
      .price {
        color: $main-text-color;
        padding: 0;
      }
    }
  }
</style>
<script>
  import countrydata from 'country-data';
  import 'vue-awesome/icons/ellipsis-v';
  import 'vue-awesome/icons/exclamation-triangle';
  import Icon from 'vue-awesome/components/Icon';
  import PlayerPosition from 'app/components/Input/PlayerPosition';

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
      'widgets',
      'buyActionWithPrice'
    ],
    components: {
      icon: Icon,
      playerposition: PlayerPosition,

    },
    computed: {
      refundAsked() {
        return this.report.orders_refund_status == 'asked';
      },
      isPurchased() {
        return this.report.orders_status == 'completed';
      },
      clubName() {
        if (this.report.team) {
          return this.report.team.team_name;
        }
        if (this.report.search)
          return this.report.search.club;
        return '';
      },
      titleDate() {
        if (this.report.created_at != this.report.updated_at)
          return ('Originally published on ' + this.$options.filters.moment(this.report.created_at))
        return null;
      },
      teamName() {
        return this.report.meta_data.category;
      },
      competitionName() {
        if (this.report.team && this.report.team.competitions) {
          var arr = [];
          for (var i in this.report.team.competitions.competitions)
            arr.push(this.report.team.competitions.competitions[i].name)
          return arr;
        }
        if (this.report.search)
          return [this.report.search.league];
        return '';
      },
      playerInfo() {
        if (this.report.type_report == 'player') {
          if (this.report.player)
            return this.report.player;
          return this.report.meta_data.player_info;
        }
      },
      playerName() {
        if (this.playerInfo.first_name)
          return this.playerInfo.first_name + ' ' + this.playerInfo.last_name ;
        if (this.report.search) {
          return this.report.search.player;
        }
        return '';
      },
      positions() {
        if (this.report.player)
          return [this.playerInfo.playing_position]
        if (this.report.meta_data)
          return this.playerInfo.playing_position
      }
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
      canRefund() {
        if ((this.report.orders_status == 'completed' || (this.report.completion_status == 'pending' && !this.own)) &&
          this.refundAction) {
          if (this.report.orders_completed_date) {
            var week = new Date(this.report.orders_completed_date);
            week.setDate(week.getDate() + 7);
            var today = new Date()
            if (week < today)
              return false
            return true;
          }
        }
        return false;
      },

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
