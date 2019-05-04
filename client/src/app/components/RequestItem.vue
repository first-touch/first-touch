<template>
  <div class="item-container">
    <div class="ft-item" v-if="!mode || mode == 'widget'">
      <div class="header-wrapper">
        <div class="header col-lg-10">
          <div class="img-container">
            <img class="img-fluid avatar" :src="src" />
          </div>
          <div class="info col-lg-8" v-if="position">
            <h2 class="title">
              <playerposition class="col-lg-8" :value="request.meta_data.playing_position" :readonly="true" />
            </h2>
            <p class="extra">
              <span class="field row">
                <span class="col-lg-4">Request Id:</span>
                <span class="col-lg-6"> {{request.id | requestId(request.type_request) }}
                </span>
              </span>
              <span class="field row" v-if="!own">
                <span class="col-lg-4">Requested by:</span>
                <span class="col-lg-6"> TBA </span>
              </span>

              <span class="field row">
                <span class="col-lg-4">Job request type</span>
                <span class="col-lg-6 capitalize"> {{request.type_request}} job request
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Price range</span>
                <span class="col-lg-6 capitalize"> {{request.price.value}} to {{request.price.max}} {{request.price.currency | currency}}
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Position:</span>
                <span class="col-lg-6">
                  <playerposition class="col-lg-8" :value="request.meta_data.playing_position" :readonly="true" />
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Based in: </span>
                <span class="col-lg-6">{{getNationality(request.meta_data.residence_country_code)}}
                </span>
              </span>

              <span class="field row">
                <span class="col-lg-4">Deadline </span>
                <span class="col-lg-6">{{request.deadline | moment}}
                </span>
              </span>
              <span class="field yes row" v-if="request.meta_data.loan == 'yes'">
                <span class="col-lg-12">Interested In Loan</span>
              </span>
              <span class="field yes row" v-if="request.meta_data.transfer == 'yes'">
                <span class="col-lg-12">Interested In Transfer</span>
              </span>
              <span class="field row" v-if="request.meta_data.expiring_contract == 'yes'">
                <span class="col-lg-4">Expiring Contract: </span>
                <span class="col-lg-6">
                  {{request.meta_data.expiring_contract_min | moment}} to {{request.meta_data.expiring_contract_max | moment}}
                </span>
              </span>
            </p>
          </div>
          <div class="info col-lg-8" v-if="request.type_request == 'player'">
            <h2 class="title">
              <span class="target" v-if="request.player">{{request.player.first_name}} {{request.player.last_name}} </span>
              <span class="target" v-if="!request.player">{{request.meta_data.search.player}}</span>
            </h2>
            <span class="pending" v-if="!own && request.bid_status && request.bid_status =='pending'">Bid pending</span>
            <p class="extra">
              <span class="field row">
                <span class="col-lg-4">Request Id:</span>
                <span class="col-lg-6"> {{request.id | requestId(request.type_request) }}
                </span>
              </span>
              <span class="field row" v-if="!own">
                <span class="col-lg-4">Requested by:</span>
                <span class="col-lg-6"> TBA </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Job request type</span>
                <span class="col-lg-6 capitalize"> {{request.type_request}} job request
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Price range</span>
                <span class="col-lg-6 capitalize"> {{request.price.value}} to {{request.price.max}} {{request.price.currency | currency}}
                </span>
              </span>
              <span class="field row" v-if="haveBid">
                <span class="col-lg-4">Bid Price:</span>
                <span class="col-lg-6"> {{request.bid_price.value}} {{request.bid_price.currency | currency}}
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Position:</span>
                <span class="col-lg-6" v-if="request.player">
                  <playerposition class="col-lg-8" :value="request.player.playing_position" :readonly="true" />
                </span>
                <span class="col-lg-6" v-if="!request.player">
                  <playerposition class="col-lg-8" :value="request.meta_data.playing_position" :readonly="true" />
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Based in: </span>
                <span class="col-lg-6" v-if="request.player">{{getNationality(request.player.residence_country_code)}} </span>
                <span class="col-lg-6" v-if="!request.player">{{getNationality(request.meta_data.residence_country_code)}}
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Deadline </span>
                <span class="col-lg-6">{{request.deadline | moment}}
                </span>
              </span>
            </p>
          </div>

          <div class="info col-lg-8" v-if="request.type_request == 'team'">
            <h2 class="title" v-if="request.team">{{request.team.team_name}}</h2>
            <h2 class="title" v-if="!request.team"> {{request.meta_data.search.club}} </h2>
            <span class="pending" v-if="!own && request.bid_status && request.bid_status.status =='pending'">Bid pending</span>
            <p class="extra">
              <span class="field row">
                <span class="col-lg-4">Request Id:</span>
                <span class="col-lg-6"> {{request.id | requestId(request.type_request) }}
                </span>
              </span>
              <span class="field row" v-if="!own">
                <span class="col-lg-4">Requested by:</span>
                <span class="col-lg-6"> TBA </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Job request type</span>
                <span class="col-lg-6 capitalize"> {{request.type_request}} job request
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Price range</span>
                <span class="col-lg-6 capitalize"> {{request.price.value}} to {{request.price.max}} {{request.price.currency | currency}}
                </span>
              </span>
              <span class="field row" v-if="haveBid && request.bid_price.value">
                <span class="col-lg-4">Bid Price:</span>
                <span class="col-lg-6"> {{request.bid_price.value}} {{request.price.currency | currency}}
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">League:</span>
                <span class="col-lg-6" v-if="!request.team">
                  {{request.meta_data.search.league}}
                </span>
                <span class="col-lg-6" v-if="request.team">
                  <span class="list" v-for="cp in request.team.competitions.competitions" :key="cp.id"> TBA </span>
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Created</span>
                <span class="col-lg-6">{{request.created_at | moment}}
                </span>
              </span>
              <span class="field row">
                <span class="col-lg-4">Deadline </span>
                <span class="col-lg-6">{{request.deadline | moment}}
                </span>
              </span>
            </p>
          </div>
        </div>
        <div class="widget col-lg-2 buttons-inner">
          <router-link v-if="own" :to="{ name: 'clubRequest', params: { id: request.id }}" class="ft-action">
            <button class="btn-round">Edit</button>
          </router-link>
          <router-link v-if="own && !position" :to="{ name: 'clubRequestBids', params: { id: request.id }}" class="ft-action">
            <button class="btn-round">View Bids</button>
          </router-link>
          <router-link v-if="own && position" :to="{ name: 'clubReportProposed', params: { request: request }}" class="ft-action">
            <button class="btn-round">View Proposed Reports</button>
          </router-link>

          <a v-if="request.status == 'publish' && own" @click="update(request.id, 'private')" class="ft-action">
            <button class="btn-round">Unpublish</button>
          </a>
          <a v-if="request.status == 'private' && own" @click="update(request.id, 'publish')" class="ft-action">
            <button class="btn-round">Publish</button>
          </a>
          <a v-if="own" @click="update(request.id, 'deleted')" class="ft-action">
            <button class="btn-round">Delete</button>
          </a>
          <a v-if="!own" @click="viewSummary(request)" class="ft-action">
            <button class="btn-round">View Details</button>
          </a>
          <a v-if="!own && !position && addBid && bidStatus == 'N'" @click="addBid(request)" class="ft-action">
            <button class="btn-round" v-if="bidStatus == 'U'">Update Bid</button>
            <button class="btn-round" v-if="bidStatus == 'N'">Bid</button>
          </a>
          <router-link v-if="bidStatus == 'C' && position && createReport" :to="{ name: 'scoutJobsList' }" class="ft-action">
            <button class="btn-round">See jobs list</button>
          </router-link>
          <router-link v-if="!own && !position && addBid && bidStatus == 'U'" :to="{ name: 'ScoutJobBidPage' }" class="ft-action">
            <button class="btn-round">See my bids</button>
          </router-link>
          <a v-if="!own && !haveBid && position && addBid" @click="addBid(request)" class="ft-action">
            <button class="btn-round">+ To job list</button>
          </a>
          <a v-if="bidStatus == 'C' && !position && createReport" @click="createReport(request)" class="ft-action">
            <button class="btn-round">Create Report</button>
          </a>
          <a v-if="bidStatus == 'C' && cancelReport" @click="cancelReport(request)" class="ft-action">
            <button class="btn-round">Cancel Report</button>
          </a>
          <a v-if="bidStatus == 'R' && viewReport" @click="viewReport(request.report_id)" class="ft-action">
            <button class="btn-round">View Report</button>
          </a>
        </div>
      </div>
    </div>
    <tr v-if="mode == 'table'" class="request-tr table-item">
      <td v-for="field in widgets" :key="field.id">
        <span v-if="field == 'id'" class="contents">
          {{request.id | requestId(request.type_request) }}
        </span>
        <span v-if="field == 'type'" class="contents">
          <p class="capitalize">
            {{ request.type_request }} job request
          </p>
        </span>
        <span v-if="field == 'created_at'" class="contents">
          {{ request.created_at | moment }}
        </span>
        <span v-if="field == 'club'" class="contents">
          TBA
        </span>
        <span v-if="field == 'deadline'" class="contents">
          {{ request.deadline | moment }}
        </span>
        <span v-if="field == 'bid_status'" class="contents">
          <p class="capitalize">
            {{ request.bid_status}}
          </p>
        </span>
        <span v-if="field == 'bid_price'" class="contents">
          <span v-if="position">
            From {{request.price.value}} to {{request.price.max}} {{request.price.currency}}
          </span>
          <span v-if="!position">
            {{request.bid_price.value}} {{request.price.currency}}
          </span>
        </span>
        <span v-if="field == 'bids'" class="contents">
          {{request.request_bids_count}}
        </span>
        <span v-if="field == 'action'" class="contents">
          <div class="table-action row">
            <div class="col col-lg-8 first-action buttons-inner">
              <router-link v-if="canAction(own && !position, 'view_bids', true)" :to="{ name: 'clubRequestBids', params: { id: request.id }}"
                class="ft-action">
                <button class="btn-round">View Bids</button>
              </router-link>
              <router-link v-if="canAction(own && position, 'view_proposed', true)" :to="{ name: 'clubReportProposed', params: { requestId: request.id }}"
                class="ft-action">
                <button class="btn-round">View Proposed Reports</button>
              </router-link>
              <a v-if="canAction(!own && !position && addBid, 'bid',true)" @click="addBid(request)" class="ft-action">
                <button class="btn-round" v-if="bidStatus == 'U'">Update Bid</button>
                <button class="btn-round" v-if="bidStatus == 'N'">Bid</button>
              </a>
              <a v-if="canAction(!own && !haveBid && position && addBid, 'to_job', true)" class="ft-action" @click="addBid(request)">
                <button class="btn-round">+ To job list</button>
              </a>
              <a v-if="canAction(bidStatus == 'C' && typeof createReport !== 'undefined' , 'create_report', true)" class="ft-action" @click="createReport(request)">
                <button class="btn-round">Create Report</button>
              </a>
              <a v-if="canAction(bidStatus == 'C' && typeof cancelReport !== 'undefined' , 'cancel_report', true)" @click="cancelReport(request)">
                <button class="btn-round">Cancel Report</button>
              </a>
              <a v-if="canAction(bidStatus == 'R' && typeof viewReport !== 'undefined', 'view_report', true)" @click="viewReport(request.report_id)">
                <button class="btn-round">View Report</button>
              </a>
              <a v-if="canAction(!own, 'view_details', true)" @click="viewSummary(request)">
                <button class="btn-round">View Details</button>
              </a>
              <a v-if="canAction(request.status == 'publish' && own, 'unpublish', true)" @click="update(request.id, 'private')">
                <button class="btn-round">Unpublish</button>
              </a>
              <a v-if="canAction(request.status == 'private' && own, 'publish', true)" @click="update(request.id, 'publish')">
                <button class="btn-round"> Publish</button>
              </a>
              <a v-if="canAction(own, 'delete', true)" @click="update(request.id, 'deleted')">
                <button class="btn-round"> Delete</button>
              </a>
              <router-link v-if="canAction(own, 'edit', true)" :to="{ name: 'clubRequest', params: { id: request.id }}">
                <button class="btn-round"> Edit</button>
              </router-link>
            </div>
            <div class="more col-lg-1" v-if="listAction">
              <icon name="ellipsis-v"></icon>
              <div class="action">
                <div class="content" ref="listAction">
                  <a v-if="canAction(bidStatus == 'C' && typeof cancelReport !== 'undefined', 'cancel_report', false)" @click="cancelReport(request)">
                    Cancel Report
                  </a>
                  <a v-if="canAction(bidStatus == 'R' && typeof viewReport !== 'undefined', 'view_report', false)" @click="viewReport(request.report_id)">
                    View Report
                  </a>
                  <a v-if="canAction(!own, 'view_details', false)" @click="viewSummary(request)">
                    View Details
                  </a>
                  <a v-if="canAction(request.status == 'publish' && own, 'unpublish', false)" @click="update(request.id, 'private')">
                    Unpublish
                  </a>
                  <a v-if="canAction(request.status == 'private' && own, 'publish', false)" @click="update(request.id, 'publish')">
                    Publish
                  </a>
                  <a v-if="canAction(own, 'delete', false)" @click="update(request.id, 'deleted')">
                    Delete
                  </a>
                  <router-link v-if="canAction(own, 'edit', false)" :to="{ name: 'clubRequest', params: { id: request.id }}">
                    Edit
                  </router-link>
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
  @import '~stylesheets/light_item';
  @import '~stylesheets/variables';
  .capitalize:first-letter {
    text-transform: capitalize;
  }

  .table-action {
    .col {
      &.first-action {
        float: left;
        padding: 0;
        button {
          margin: 0;
        }
      }
    }
  }

  .contents {
    display: contents;
  }
</style>
<script>
  import countrydata from 'country-data';
  import 'vue-awesome/icons/ellipsis-v';
  import Icon from 'vue-awesome/components/Icon';
  import PlayerPosition from 'app/components/Input/PlayerPosition';

  export default {
    name: 'RequestItem',
    props: ['request', 'update', 'own', 'viewSummary', 'addBid', 'createReport', 'viewReport', 'cancelReport', 'mode',
      'widgets'
    ],
    components: {
      icon: Icon,
      playerposition: PlayerPosition,

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
        if (condition) {
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
    },
    computed: {
      src: function () {
        var src = '';
        switch (this.request.type_request) {
          case 'player':
            src = '/images/landing-page/ft-icons-player.png';
            break;
          case 'team':
            src = '/images/landing-page/ft-icons-club.png';
            break;
          case 'position':
            src = '/images/landing-page/ft-icons-player.png';
            break;
        }
        return src;
      },
      bidStatus() {
        if (this.own) return false;
        if (this.request.bid_status) {
          if (
            this.request.bid_status == 'accepted' ||
            this.request.bid_status == 'joblist'
          )
            return 'C';
          if (this.request.bid_status == 'completed') return 'R';
          if (this.request.bid_status == 'pending') return 'U';
        }
        return 'N';
      },
      position() {
        if (this.request.type_request == 'position')
          return true;
        return false;
      },
      haveBid() {
        return this.request.bid_status;
      },
      clubProfile() {
        return this.$router.matcher.match({
          name: 'teamProfilePage'
        }).matched.length > 0
      },
      isAccepted() {
        if (this.request.bid_status) {
          if (
            this.request.bid_status == 'accepted' ||
            this.request.bid_status == 'joblist'
          )
            return true;
          return false;
        }
        return false;
      }
    }
  };
</script>
