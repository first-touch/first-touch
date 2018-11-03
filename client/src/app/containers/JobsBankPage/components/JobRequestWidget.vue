<template>
  <div class="widget-request ft-search-widget">
<<<<<<< HEAD
    <h4 class="header">Jobs Bank</h4>
=======
    <h4 class="spaced-title upper-cased main-color">Jobs Bank</h4>
>>>>>>> [Chore] cleaning up some more styling
    <timeline-item>
      <div class="widget-content col col-lg-12">
        <div class="row align-items-start">
          <div class="col-lg-2 row">
            <h6 class="list-title col-lg-12">Request Count</h6>
            <h1 class="list-count col-lg-12">{{listRequest.length}}</h1>
            <fieldset class="col-lg-12 col-md-12 buttons-inner" v-if="nbFilters">
              <button class="ft-button" @click="clearsFilter">Clear {{nbFilters}} Filters</button>
            </fieldset>
          </div>
          <form @submit.prevent="search" class="col-lg-10 row">
            <fieldset class="col-lg-4">
              <input type="number" min="0" class="col-lg-12 form-control" v-model="params.id" placeholder="Job Request Id" @keyup="search()"
              />
            </fieldset>
            <fieldset class="col-lg-4">
              <input type="text" class="col-lg-12 form-control" v-model="params.club" placeholder="Requested by" @keyup="search()" />
            </fieldset>
            <fieldset class="col-lg-3">
              <vselect v-model="vselect_type" class="form-control" :options="options.type_request" :class="params.type_request == '' ? 'empty' : '' "
                :searchable="false" clearable="false" />
            </fieldset>
            <fieldset class="col-lg-12 calendar-filter">
              <ftdatepicker class="col col-lg-5 form-control" ref="deadlineFrom" :value="params.deadline_from" :clearable="false" placeholder="Deadline from"
                v-on:update:val="params.deadline_from = $event; search()" />
              <p class="col col-lg-1">-</p>
              <ftdatepicker class="col col-lg-5 form-control" ref="deadlineTo" :value="params.deadline_to" :clearable="false" placeholder="Deadline to"
                v-on:update:val="params.deadline_to = $event; search()" />
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
        <div v-if="bid" class="divSuccess row">
          <div class="col-lg-12">
            <h3 class="success" v-if="bidPosition">Added to job !</h3>
            <h3 class="success" v-if="!bidPosition">Bid submitted !</h3>
          </div>
          <div class="col-lg-12 buttons-inner">
            <button class="ft-button-right ft-button-success" @click="closeAction()">✓ Close</button>
          </div>
        </div>
      </b-modal>
      <b-modal id="metaModal" size="md" ref="bidModal" :class="bid? 'successModal' : 'formModal' ">
        <bidpopup v-if="selected" :request="selected" :newBid="newBid" :close="closeBid" />
      </b-modal>
      <div v-if="!hasBankAccount" @click="toPaymentPage">
        <p class="error">Click here to add a bank account and start to browse job request</p>
      </div>
      <request v-for="request in listRequest" :key="request.id" :request="request" :viewSummary="viewSummary" :addBid="addBid"
        :viewReport="viewReport" :createReport="createReport" />
    </timeline-item>
  </div>
</template>


<style lang="scss">
  @import '~stylesheets/variables';
  @import '~stylesheets/modal';
  @import '~stylesheets/search';
  @import '~stylesheets/form';
</style>
<style lang="scss" scoped>
  .error {
    cursor: pointer;
    &:hover {
      text-decoration: underline;
    }
  }
</style>
<script>
  import Datepicker from 'vuejs-datepicker';
  import RequestItem from 'app/components/RequestItem';
  import TimelineItem from 'app/components/TimelineItem';
  import {
    ASYNC_SUCCESS,
    ASYNC_LOADING
  } from 'app/constants/AsyncStatus';
  import vSelect from 'vue-select';
  import BidPopup from './BidPopup';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import PlayerRequestPopup from 'app/components/RequestPopup/PlayerRequestPopup';
  import PositionRequestPopup from 'app/components/RequestPopup/PositionRequestPopup';
  import TeamRequestPopup from 'app/components/RequestPopup//TeamRequestPopup';

  export default {
    name: 'JobRequestWidget',
    props: ['listRequest', 'getRequests', 'update', 'bid', 'createBid', 'updateBid', 'clearBid', 'user'],
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
          club: '',
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
      nbFilters() {
        var i = 0;
        var params = this.params;
        for (var key in params) {
          if (['bids_status', 'order_asc', 'order'].indexOf(key) < 0)
            i = params[key] != '' ? i + 1 : i;
        }
        return i;
      },
      hasBankAccount() {
        if (this.user.status === ASYNC_SUCCESS) {
          return (this.user.value.has_bank_account)
        }
        if (this.user.status === ASYNC_LOADING) {
          return true;
        }
        return false;
      },
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
      toPaymentPage() {
        this.$router.push({
          name: 'scoutPaymentDetailPage',
        });
      },
      clearsFilter() {
        this.params = {
          id: '',
          created_date: '',
          order: '',
          status: '',
          type_request: '',
          deadline_from: '',
          deadline_to: '',
          club: ''
        }
        this.$refs.deadlineFrom.model = null;
        this.$refs.deadlineTo.model = null;
        this.vselect_type = {
          label: 'Request Type',
          value: ''
        };
        this.vselect_sort = {
          label: 'Sort by',
          value: ''
        };
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
      closeBid() {
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
