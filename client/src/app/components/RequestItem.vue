<template>
  <div class="item-container">
    <div class="ft-item" v-if="!mode || mode == 'widget'">
      <div class="header-wrapper">
        <div class="header col-md-10">
          <div class="img-container">
            <img class="img-fluid avatar" :src="src" />
          </div>
          <div class="info col-md-8" v-if="position">
            <h2 class="title">
              <span class="list" v-for="position in request.meta_data.playing_position" :key="position.id">{{position}}</span>
            </h2>
            <p class="extra">
              <span class="field row">
                <span class="col-md-4">Request Id:</span>
                <span class="col-md-6"> {{request.id | requestId(request.type_request) }}
                </span>
              </span>
              <span class="field row" v-if="haveBid">
                <span class="col-md-4">Bid Price:</span>
                <span class="col-md-6"> {{request.bid_price.price}} {{request.bid_price.currency | currency}}
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Position:</span>
                <span class="col-md-6">
                  <span class="list" v-for="position in request.meta_data.playing_position" :key="position.id">{{position}}</span>
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Based in: </span>
                <span class="col-md-6">{{getNationality(request.meta_data.residence_country_code)}}
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Deadline </span>
                <span class="col-md-6">{{request.deadline | moment}}
                </span>
              </span>
              <span class="field yes row" v-if="request.meta_data.loan == 'yes'">
                <span class="col-md-12">Interested In Loan</span>
              </span>
              <span class="field yes row" v-if="request.meta_data.transfer == 'yes'">
                <span class="col-md-12">Interested In Transfer</span>
              </span>
              <span class="field row" v-if="request.meta_data.expiring_contract == 'yes'">
                <span class="col-md-4">Expiring Contract: </span>
                <span class="col-md-6">
                  {{request.meta_data.expiring_contract_min | moment}} to {{request.meta_data.expiring_contract_max | moment}}
                </span>
              </span>
            </p>
          </div>
          <div class="info col-md-8" v-if="request.type_request == 'player'">
            <h2 class="title">
              <span class="target" v-if="request.player">{{request.player.first_name}} {{request.player.last_name}} </span>
              <span class="target" v-if="!request.player">{{request.meta_data.search.player}}</span>
            </h2>
            <span class="pending" v-if="!own && request.bid_status && request.bid_status =='pending'">Bid pending</span>
            <p class="extra">
              <span class="field row">
                <span class="col-md-4">Request Id:</span>
                <span class="col-md-6"> {{request.id | requestId(request.type_request) }}
                </span>
              </span>
              <span class="field row" v-if="haveBid">
                <span class="col-md-4">Bid Price:</span>
                <span class="col-md-6"> {{request.bid_price.price}} {{request.bid_price.currency | currency}}
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Position:</span>
                <span class="col-md-6" v-if="request.player">
                  <span class="list" v-for="position in request.player.playing_position" :key="position.id">{{position}}</span>
                </span>
                <span class="col-md-6" v-if="!request.player">
                  <span class="list" v-for="position in request.meta_data.playing_position" :key="position.id">{{position}}</span>
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Based in: </span>
                <span class="col-md-6" v-if="request.player">{{getNationality(request.player.residence_country_code)}} </span>
                <span class="col-md-6" v-if="!request.player">{{getNationality(request.meta_data.residence_country_code)}}
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Deadline </span>
                <span class="col-md-6">{{request.deadline | moment}}
                </span>
              </span>
            </p>
          </div>
          <div class="info col-md-8" v-if="request.type_request == 'team'">
            <h2 class="title" v-if="request.team">{{request.team.team_name}}</h2>
            <h2 class="title" v-if="!request.team"> {{request.meta_data.search.team}} </h2>
            <span class="pending" v-if="!own && request.bid_status && request.bid_status.status =='pending'">Bid pending</span>
            <p class="extra">
              <span class="field row">
                <span class="col-md-4">Request Id:</span>
                <span class="col-md-6"> {{request.id | requestId(request.type_request) }}
                </span>
              </span>
              <span class="field row" v-if="haveBid">
                <span class="col-md-4">Bid Price:</span>
                <span class="col-md-6"> {{request.bid_price.price}} {{request.price.currency | currency}}
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">League:</span>
                <span class="col-md-6" v-if="!request.team">
                  {{request.meta_data.search.league}}
                </span>
                <span class="col-md-6" v-if="request.team">
                  <span class="list" v-for="cp in request.team.competitions.competitions" :key="cp.id">{{cp.name}} </span>
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Created</span>
                <span class="col-md-6">{{request.created_at | moment}}
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Deadline </span>
                <span class="col-md-6">{{request.deadline | moment}}
                </span>
              </span>
            </p>
          </div>
        </div>
        <div class="widget col-md-2">
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
          <a v-if="!own && !position && addBid" @click="addBid(request)" class="ft-action">
            <button class="btn-round" v-if="bidStatus == 'U'">Update Bid</button>
            <button class="btn-round" v-if="bidStatus == 'N'">Bid</button>
          </a>
          <a v-if="!own && !haveBid && position && addBid" @click="addBid(request)" class="ft-action">
            <button class="btn-round">+ To job list</button>
          </a>
          <a v-if="bidStatus == 'C' && createReport" @click="createReport(request)" class="ft-action">
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
      <td v-if="fields.indexOf('id') >=0">{{request.id | requestId(request.type_request) }}</td>
      <td class="capitalize" v-if="fields.indexOf('type') >=0">{{ request.type_request }} job request</td>
      <td v-if="fields.indexOf('created_at') >=0"> {{ request.created_at | moment }} </td>
      <td v-if="fields.indexOf('club') >=0"> {{ request.user.first_name }} {{ request.user.last_name }} </td>
      <td v-if="fields.indexOf('deadline') >=0"> {{ request.deadline | moment }} </td>

      <td v-if="fields.indexOf('bids') >=0"> {{request.request_bids_count}}</td>
      <td v-if="fields.indexOf('action') >=0" class="table-action widget col-lg-12">
        <router-link v-if="own && !position" :to="{ name: 'clubRequestBids', params: { id: request.id }}" class="ft-action col-lg-10">
          <button class="btn-round">View Bids</button>
        </router-link>
        <router-link v-if="own && position" :to="{ name: 'clubReportProposed', params: { requestId: request.id }}" class="ft-action col-lg-10">
          <button class="btn-round">View Proposed Reports</button>
        </router-link>
        <a v-if="!own && !position && addBid" @click="addBid(request)" class="ft-action col-lg-10">
          <button class="btn-round" v-if="bidStatus == 'U'">Update Bid</button>
          <button class="btn-round" v-if="bidStatus == 'N'">Bid</button>
        </a>
        <a v-if="!own && !haveBid && position && addBid" class="ft-action col-lg-10" @click="addBid(request)">
          <button class="btn-round">+ To job list</button>
        </a>
        <a v-if="bidStatus == 'C' && createReport" class="ft-action col-lg-10" @click="createReport(request)">
          <button class="btn-round">Create Report</button>
        </a>
        <div class="more col-lg-1">
          <icon name="ellipsis-v"></icon>
          <div class="action">
            <div class="content">
              <a v-if="bidStatus == 'C' && cancelReport" @click="cancelReport(request)">
                Cancel Report
              </a>
              <a v-if="bidStatus == 'R' && viewReport" @click="viewReport(request.report_id)">
                View Report
              </a>
              <a v-if="!own" @click="viewSummary(request)">
                View Details
              </a>
              <a v-if="request.status == 'publish' && own" @click="update(request.id, 'private')">
                Unpublish
              </a>
              <a v-if="request.status == 'private' && own" @click="update(request.id, 'publish')">
                Publish
              </a>
              <a v-if="own" @click="update(request.id, 'deleted')">
                Delete
              </a>
              <router-link v-if="own" :to="{ name: 'clubRequest', params: { id: request.id }}">
                Edit
              </router-link>
            </div>
            <span class="down-arrow"></span>
          </div>
        </div>
      </td>
    </tr>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/light_item';
  @import '~stylesheets/variables';
</style>
<script>
  import countrydata from 'country-data';
  import 'vue-awesome/icons/ellipsis-v';
  import Icon from 'vue-awesome/components/Icon';

  export default {
    name: 'RequestItem',
    props: ['request', 'update', 'own', 'viewSummary', 'addBid', 'createReport', 'viewReport', 'cancelReport', 'mode',
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
      canUpdate() {
        if (this.request.bid_status)
          if (this.request.bid_status != 'pending') return true;
        return false;
      },
      position() {
        if (this.request.type_request == 'position')
          return true;
        return false;
      },
      haveBid() {
        return this.request.bid_status;
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
