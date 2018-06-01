<template>
  <div class="widget-request ft-search-widget">
    <h4 class="header">My Jobs List</h4>
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
            <fieldset class="col-lg-3">
              <input type="number" min="0" class="col-lg-12 form-control" v-model="params.id" placeholder="Job Request Id" @keyup="search()"
              />
            </fieldset>
            <fieldset class="col-lg-3">
              <input type="text" class="col-lg-12 form-control" v-model="params.club" placeholder="Requested by" @keyup="search()" />
            </fieldset>
            <fieldset class="col-lg-4">
              <vselect v-model="vselect_type" class="form-control" :options="options.type_request" :class="params.type_request == '' ? 'empty' : '' " :searchable="false" clearable="false" />
            </fieldset>
            <fieldset class="col-lg-12 calendar-filter">
              <ftdatepicker class="col-lg-5 col form-control" :model="params.deadline_from" ref="deadlineFrom" :value="params.deadline_from"
                :clearable="false" placeholder="Deadline from" v-on:update:val="params.deadline_from = $event; search()" />
              <p class="col-lg-1 col">-</p>
              <ftdatepicker class="col-lg-5 col form-control" :model="params.deadline_to" ref="deadlineTo" :clearable="false" placeholder="Deadline to"
                v-on:update:val="params.deadline_to = $event; search()" />
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
          <cancelrequestpopup :request="selected" :closeAction="closeAction" :cancelReport="cancelReport" :filesUpload="filesUpload"
            :uploadFiles="uploadFiles" :bid="bid" />
        </div>
      </b-modal>

      <b-modal id="metaModal" size="sm" ref="infoModal">
        <div>
          <h4>Bid has been Canceled</h4>
        </div>
      </b-modal>
      <table class="table table-search table-responsive-lg">
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
            <th scope="col" class="shortable" @click="setOrder('deadline')">
              <p>Submission Deadline</p>
              <span v-if="params.order == 'deadline'">
                <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
              </span>
            </th>
            <th scope="col">Actions</th>
          </tr>
        </thead>
        <tbody>
          <request v-for="request in listRequest" :key="request.id" :request="request" :viewSummary="viewSummary" :createReport="createReport"
            mode="table" :cancelReport="cancelReportPopup" :fields="['id','club','type','deadline','action']" />
        </tbody>
      </table>
    </timeline-item>
  </div>
</template>


<style lang="scss">
  @import '~stylesheets/variables';
  @import '~stylesheets/modal';
  @import '~stylesheets/search';
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

  export default {
    name: 'JobRequestWidget',
    components: {
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
        timer: null,
        params: {
          id: '',
          club: '',
          order: '',
          deadline_from: '',
          deadline_to: '',
          order_asc: true,
          type_request: '',
          bids_status: 'accepted,joblist'
        },
        vselect_type: {
          label: 'Request Type',
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

        }
      };
    },
    mounted() {
      this.search();
    },
    computed: {
      ...mapGetters(['searchRequest', 'bid', 'filesUpload']),
      nbFilters() {
        var i = 0;
        var params = this.params;
        for (var key in params) {
          if (['bids_status', 'order_asc', 'order'].indexOf(key) < 0)
            i = params[key] != '' ? i + 1 : i;
        }
        return i;
      },
      listRequest() {
        if (this.searchRequest.status === ASYNC_SUCCESS) {
          return this.searchRequest.value.request;
        }
        return [];
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
        if (this.bid.status == ASYNC_SUCCESS) this.search();
      }
    },
    methods: {
      ...mapActions(['getRequests', 'createBid', 'clearBid', 'updateBid', 'cancelBid', 'uploadFiles']),
      clearsFilter() {
        this.params = {
          id: '',
          club: '',
          order: '',
          deadline_from: '',
          deadline_to: '',
          order_asc: true,
          type_request: '',
          bids_status: 'accepted,joblist'
        };
        this.$refs.deadlineFrom.model = null;
        this.$refs.deadlineTo.model = null;
        this.vselect_type = {
          label: 'Request Type',
          value: ''
        };
      },
      search() {
        var self = this
        clearTimeout(this.timer);
        this.timer = setTimeout(function () {
          self.getRequests(self.url);
        }, 500);
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
