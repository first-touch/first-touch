<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <div class="widget-request ft-search-widget">
          <h4 class="header">My Bids</h4>
          <timeline-item>
            <div class="widget-content col col-md-12">
              <div class="row align-items-start">
                <div class="col-md-2">
                  <h6 class="list-title">Request Count</h6>
                  <h1 class="list-count">{{listRequest.length}}</h1>
                </div>
                <form @submit.prevent="search" class="col-md-10 row">
                  <fieldset class="col-lg-4 filter">
                    <input type="number" class="col-lg-12 form-control" v-model="params.id" placeholder="Job Request Id" @keyup="search()" />
                  </fieldset>
                  <fieldset class="col-lg-4 filter">
                    <input type="text" class="col-lg-12 form-control" v-model="params.club" placeholder="Requested by" @keyup="search()" />
                  </fieldset>
                  <fieldset class="col-md-4 filter">
                    <vselect v-model="vselect_type" :options="options.type_request" :searchable="false" clearable="false" />
                  </fieldset>
                  <fieldset class="col-md-4 filter">
                    <vselect v-model="vselect_bid_status" :options="options.bid_status" :searchable="false" clearable="false" />
                  </fieldset>
                </form>
              </div>
            </div>
            <b-modal id="metaModal" size="lg" ref="metaModal">
              <div v-if="!cancel && selected">
                <playerrequestpopup v-if="selected.type_request == 'player' " :request="selected" :closeAction="closeAction" />
                <teamrequestpopup v-if="selected.type_request == 'team' " :request="selected" :closeAction="closeAction" />
                <positionrequestpopup v-if="selected.type_request == 'position' " :request="selected" :closeAction="closeAction" />
              </div>
              <div v-if="cancel && selected">
                <cancelrequestpopup :request="selected" :closeAction="closeAction" :cancelReport="cancelReport" :bid="bid" />
              </div>
            </b-modal>

            <b-modal id="metaModal" size="sm" ref="infoModal">
              <div>
                <h4>Bid has been Canceled</h4>
              </div>
            </b-modal>
            <table class="table table-search">
              <thead>
                <tr>
                  <th scope="col" class="shortable" @click="setOrder('id')">
                    <p>Job Request ID</p>
                    <span v-if="params.order == 'id'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('club')">
                    <p>Requested by </p>
                    <span v-if="params.order == 'club'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('type_request')">
                    <p>Job Request Type </p>
                    <span v-if="params.order == 'type_request'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('bid_price')">
                    <p>Bid price</p>
                    <span v-if="params.order == 'bid_price'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('bid_status')">
                    <p>Bid Status</p>
                    <span v-if="params.order == 'bid_status'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col">Actions</th>
                </tr>
              </thead>
              <tbody>
                <request v-for="request in listRequest" :key="request.id" :request="request" :viewSummary="viewSummary" :createReport="createReport"
                  mode="table" :cancelReport="cancelReportPopup" :fields="['id','club','type','bid_price','bid_status','action']"
                />
              </tbody>
            </table>
          </timeline-item>
        </div>
      </div>
    </div>
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
    .filter {
      margin: 5px;
      max-width: 23%;
      input,
      select {
        height: 100%;
        padding: 10px;
      }
      .icon-inner {
        margin-top: 5px;
        display: inline-block;
        cursor: pointer;
        &:hover {
          color: $secondary-header-color;
        }
      }
      .datepicker {
        float: left;
      }
    }
  }
</style>
<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS
  } from 'app/constants/AsyncStatus';
  import Datepicker from 'vuejs-datepicker';
  import RequestItem from 'app/components/RequestItem';
  import TimelineItem from 'app/components/TimelineItem';
  import vSelect from 'vue-select';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import PlayerRequestPopup from 'app/components/RequestPopup/PlayerRequestPopup';
  import PositionRequestPopup from 'app/components/RequestPopup/PositionRequestPopup';
  import TeamRequestPopup from 'app/components/RequestPopup/TeamRequestPopup';
  import CancelRequestPopup from 'app/components/RequestPopup/CancelRequestPopup';
  import 'vue-awesome/icons/arrow-alt-circle-up';
  import 'vue-awesome/icons/arrow-alt-circle-down';
  import Icon from 'vue-awesome/components/Icon';
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';

  export default {
    name: 'JobBidPage',
    components: {
      sidebar: NotificationSidebar,
      datepicker: Datepicker,
      'timeline-item': TimelineItem,
      request: RequestItem,
      vselect: vSelect,
      icon: Icon,
      ftdatepicker: FtDatepicker,
      teamrequestpopup: TeamRequestPopup,
      playerrequestpopup: PlayerRequestPopup,
      positionrequestpopup: PositionRequestPopup,
      cancelrequestpopup: CancelRequestPopup
    },
    data() {
      return {
        selected: null,
        cancel: false,
        wantbid: false,
        params: {
          id: '',
          created_date: '',
          club: '',
          order: '',
          order_asc: true,
          type_request: '',
          bids_status: 'accepted,joblist,pending'
        },
        vselect_type: {
          label: 'Request Type',
          value: ''
        },
        vselect_bid_status: {
          label: 'Bid Status',
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
          bid_status: [{
              label: 'Bid Status',
              value: ''
            },
            {
              label: 'Accepted',
              value: 'accepted'
            },
            {
              label: 'Pending',
              value: 'pending'
            },
            {
              label: 'Job List',
              value: 'joblist'
            }
          ]
        }
      };
    },
    mounted() {
      this.search();
    },
    computed: {
      ...mapGetters(['searchRequest', 'bid']),
      listRequest() {
        if (this.searchRequest.status === ASYNC_SUCCESS) {
          return this.searchRequest.value.request;
        }
        return [];
      },
      url() {
        var params = this.params;
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
      vselect_bid_status: function () {
        this.params.bids_status = this.vselect_bid_status.value;
        if (this.params.bids_status == '')
          this.params.bids_status = 'accepted,joblist,pending';
        this.search();
      },
      bid() {
        if (this.bid.status == ASYNC_SUCCESS) this.search();
      }
    },
    methods: {
      ...mapActions(['getRequests', 'createBid', 'clearBid', 'updateBid', 'cancelBid']),
      search() {
        this.getRequests(this.url);
      },
      cancelReportPopup(request) {
        this.wantbid = false;
        this.cancel = true;
        this.selected = request;
        this.$refs.metaModal.show();
      },
      cancelReport(data) {
        var obj = {
          id: this.selected.id,
          params: data
        };
        this.cancelBid(obj);
      },
      createReport(request) {
        this.$router.push({
          name: 'scoutReportCreate',
          params: {
            request: request
          }
        });
      },
      closeAction(request) {
        this.$refs.metaModal.hide();
        this.cancel = false;
      },
      viewSummary(request) {
        this.wantbid = false;
        this.selected = request;
        this.$refs.metaModal.show();
      },
      setOrder(order) {
        if (this.params.order == order)
          this.params.order_asc = !this.params.order_asc;
        else
          this.params.order_asc = true;
        this.params.order = order;
        this.search();
      },
    }
  };
</script>
