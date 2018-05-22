<template>
  <div class="widget-request ft-search-widget">
    <h4 class="header">Jobs Bank</h4>
    <timeline-item>
      <div class="widget-content col col-lg-12">
        <div class="row align-items-start">
          <div class="col-lg-2">
            <h6 class="list-title">Request Count</h6>
            <h1 class="list-count">{{listRequest.length}}</h1>
          </div>
          <form @submit.prevent="search" class="col-lg-10 row">
            <fieldset class="col-lg-4">
              <input type="number" class="col-lg-12 form-control" v-model="params.id" placeholder="Job Request Id" @keyup="search()" />
            </fieldset>
            <fieldset class="col-lg-4">
              <input type="text" class="col-lg-12 form-control" v-model="params.club" placeholder="Requested by" @keyup="search()" />
            </fieldset>
            <fieldset class="col-lg-3">
              <vselect v-model="vselect_type" :options="options.type_request" :searchable="false" clearable="false" />
            </fieldset>
            <fieldset class="col-lg-12 calendar-filter">
              <ftdatepicker class="col col-lg-5 form-control" :value="params.deadline_from" :clearable="false" placeholder="Deadline from"
                v-on:update:val="params.deadline_from = $event; search()" />
              <p class="col col-lg-1">-</p>
              <ftdatepicker class="col col-lg-5 form-control" :value="params.deadline_to" :clearable="false" placeholder="Deadline to" v-on:update:val="params.deadline_to = $event; search()"
              />
            </fieldset>

          </form>
        </div>
      </div>
      <b-modal id="metaModal" :size="bid? 'md' : 'lg'" ref="metaModal" :class="bid? 'successModal' : 'formModal' ">
        <div v-if="!bid">
          <playerrequestpopup v-if="selected && selected.type_request == 'player' " :request="selected" :closeAction="closeAction"
            :bid="wantbid" :newBid="newBid" />
          <teamrequestpopup v-if="selected && selected.type_request == 'team' " :request="selected" :closeAction="closeAction" :bid="wantbid"
            :newBid="newBid" />
          <positionrequestpopup v-if="selected && selected.type_request == 'position' " :request="selected" :closeAction="closeAction"
            :bid="wantbid" :newBid="newBid" />
        </div>
        <div v-if="bid && !bidPosition" class="divSuccess">
          <h5 class="success">Bid has been Submitted</h5>
          <button class="btn btn-dark" @click="closeAction()">✓ Close</button>
        </div>
        <div v-if="bid && bidPosition" class="divSuccess">
          <h5 class="success">Added to job !</h5>
          <button class="btn btn-dark" @click="closeAction()">✓ Close</button>
        </div>
      </b-modal>
      <b-modal id="metaModal" size="md" ref="bidModal" :class="bid? 'successModal' : 'formModal' ">
        <bidpopup v-if="selected" :request="selected" :newBid="newBid" :close="closeBid" />
      </b-modal>
      <request v-for="request in listRequest" :key="request.id" :request="request" :viewSummary="viewSummary" :addBid="addBid"
        :viewReport="viewReport" :createReport="createReport" />
    </timeline-item>
  </div>
</template>


<style lang="scss">
  @import '~stylesheets/variables';
  @import '~stylesheets/modal';
  @import '~stylesheets/search';
  .ft-form {
    padding: 0 !important;
  }

  .widget-request {
    .input-date{
      padding: 20px;
    }
    .datepicker {
      padding: 0;
      input.input-date {
        cursor: pointer;
        min-height: 2em;
        border: 0px;
      }
    }
    .dropdown-toggle {
      max-height: 35px;
      border: 0px;
    }
  }
</style>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .widget-request {
    color: $main-text-color;
    .form-control {
      padding: 0;
    }
    .list-title {
      color: $main-text-color;
      font-size: 0.95em;
      text-transform: uppercase;
    }
    .list-count {
      color: $main-header-color;
      font-size: 4em;
      text-align: center;
    }
    fieldset {
      input {
        height: 100%;
        padding: 10px !important;
      }
      .v-select{
        padding:0;
      }
    }
  }
</style>
<script>
  import Datepicker from 'vuejs-datepicker';
  import RequestItem from 'app/components/RequestItem';
  import TimelineItem from 'app/components/TimelineItem';
  import {
    ASYNC_SUCCESS
  } from 'app/constants/AsyncStatus';
  import vSelect from 'vue-select';
  import BidPopup from './BidPopup';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import PlayerRequestPopup from 'app/components/RequestPopup/PlayerRequestPopup';
  import PositionRequestPopup from 'app/components/RequestPopup/PositionRequestPopup';
  import TeamRequestPopup from 'app/components/RequestPopup//TeamRequestPopup';

  export default {
    name: 'JobRequestWidget',
    props: ['listRequest', 'getRequests', 'update', 'bid', 'createBid', 'updateBid', 'clearBid'],
    components: {
      datepicker: Datepicker,
      'timeline-item': TimelineItem,
      bidpopup: BidPopup,
      request: RequestItem,
      vselect: vSelect,
      ftdatepicker: FtDatepicker,
      teamrequestpopup: TeamRequestPopup,
      playerrequestpopup: PlayerRequestPopup,
      positionrequestpopup: PositionRequestPopup
    },
    data() {
      return {
        selected: null,
        bidPosition: false,
        wantbid: false,
        params: {
          id: '',
          created_date: '',
          order: '',
          status: '',
          type_request: '',
          deadline_from: '',
          deadline_to: ''
        },
        vselect_type: {
          label: 'Request Type',
          value: ''
        },
        vselect_sort: {
          label: 'Sort by',
          value: ''
        },
        options: {
          type_request: [{
              label: 'Request Type',
              value: ''
            },
            {
              label: 'Player',
              value: 'player'
            },
            {
              label: 'Position',
              value: 'position'
            },
            {
              label: 'Team',
              value: 'team'
            }
          ],
          order: [{
              label: 'Sort by',
              value: ''
            },
            {
              label: 'Updated date',
              value: 'updated_at'
            },
            {
              label: 'Type',
              value: 'type_request'
            },
            {
              label: 'Max Price',
              value: 'max_price'
            }
          ],
          status: [{
              label: 'Status',
              value: ''
            },
            {
              label: 'Draft',
              value: 'draft'
            },
            {
              label: 'Closed',
              value: 'close'
            },
            {
              label: 'Publish',
              value: 'publish'
            },
            {
              label: 'Private',
              value: 'private'
            }
          ]
        }
      };
    },
    mounted() {
      this.search();
    },
    computed: {
      url() {
        var params = this.params;
        params.deadline_from = this.$options.filters.railsdate(params.deadline_from)
        params.deadline_to = this.$options.filters.railsdate(params.deadline_to)
        return Object.keys(params)
          .map(function (k) {
            return encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);
          })
          .join('&');
      }
    },
    watch: {
      vselect_type: function () {
        this.params.type_request = this.vselect_type.value;
        this.search();
      },
      vselect_status: function () {
        this.params.status = this.vselect_status.value;
        this.search();
      },
      bid() {
        if (this.bid)
          this.$refs.metaModal.show();
      }
    },
    methods: {
      search() {
        this.getRequests(this.url);
      },
      newBid(request, price) {
        if (request.bid_status) {
          this.updateBid({
            requestId: request.id,
            id: request.request_bids.id,
            price
          });
        } else {
          this.createBid({
            id: request.id,
            price
          });
        }
      },
      closeAction(request) {
        this.$refs.metaModal.hide();
        this.wantbid = false;
        this.selected = null;
        this.bidPosition = false;
        this.clearBid();
        this.search();
      },
      closeBid(){
        this.$refs.bidModal.hide();
      },
      viewSummary(request) {
        this.wantbid = false;
        this.selected = request;
        this.$refs.metaModal.show();
      },
      viewReport(id) {
        this.$router.push({
          name: 'scoutReportView',
          params: {
            id
          }
        });
      },
      createReport(request) {
        this.$router.push({
          name: 'scoutReportCreate',
          params: {
            request: request
          }
        });
      },
      addBid(request) {
        if (request.type_request == 'position') {
          this.createBid({
            id: request.id,
            price: 0
          });
          this.bidPosition = true;
        } else {
          this.wantbid = true;
          this.selected = request;
          this.$refs.bidModal.show();
        }
      }
    }
  };
</script>
