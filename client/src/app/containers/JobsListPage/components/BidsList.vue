<template>
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
        <form @submit.prevent="search" class="col-lg-10">
          <div class="form-row">
            <div class="form-group col-md-4">
              <label for="filter-by-requestor"> Requestor </label>
              <input id="filter-by-requestor" type="text" class="form-control" v-model="params.club" placeholder="Requested by" @keyup="search()" />
            </div>
            <div class="form-group col-md-4">
              <label for="filter-by-requestor">Type</label>
              <v-select v-model="requestType" :options="options.type_request" :searchable="false" :clearable="false" />
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-md-8">
              <label for="filter-by-daterange">Filter by Date</label>
              <div id="filter-by-daterange" class="input-group">
                <ft-datepicker class="form-control" ref="deadlineFrom" :model="params.deadline_from" :value="params.deadline_from" :clearable="false" placeholder="Deadline from" v-on:update:val="params.deadline_from = $event; search()" />
                <ft-datepicker class="form-control" ref="deadlineTo" :model="params.deadline_to" :clearable="false" placeholder="Deadline to" v-on:update:val="params.deadline_to = $event; search()" />
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    <table class="table table-striped table-responsive-lg">
      <thead>
        <tr>
          <th scope="col" class="sortable" @click="setOrder('club')">
            Requested by
            <span v-if="params.order == 'club'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="sortable" @click="setOrder('type_request')">
            Job Request Type
            <span v-if="params.order == 'type_request'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="sortable" @click="setOrder('deadline')">
            Submission Deadline
            <span v-if="params.order == 'deadline'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col">Actions</th>
        </tr>
      </thead>
      <tbody>
        <bid-row v-for="request in listRequest" :key="request.id" :request="request">
          <slot></slot>
        </bid-row>
      </tbody>
    </table>
  </timeline-item>
</template>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS
  } from 'app/constants/AsyncStatus';
  import TimelineItem from 'app/components/TimelineItem';
  import BidRow from './BidRow';
  import VSelect from 'vue-select';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import 'vue-awesome/icons/arrow-alt-circle-up';
  import 'vue-awesome/icons/arrow-alt-circle-down';
  import VIcon from 'vue-awesome/components/Icon';

  export default {
    name: 'BidsList',
    components: {
      TimelineItem,
      VSelect,
      VIcon,
      FtDatepicker,
      BidRow
    },
    props: ['bid_status'],
    data() {
      return {
        selected: null,
        cancel: false,
        wantbid: false,
        timer: null,
        params: {
          club: '',
          order: '',
          deadline_from: '',
          deadline_to: '',
          order_asc: true,
          type_request: '',
        },
        requestType: {
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
      ...mapGetters(['searchRequestBids']),
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
        if (this.searchRequestBids.status === ASYNC_SUCCESS) {
          let requestBids = this.searchRequestBids.value;
          return _.map(requestBids, "request");
        }
        return [];
      },
    },
    watch: {
      requestType: function () {
        this.params.type_request = this.requestType.value;
        this.search();
      },
      bid() {
        if (this.bid.status == ASYNC_SUCCESS) this.search();
      }
    },
    methods: {
      ...mapActions(['getRequestBids']),
      clearsFilter() {
        this.params = {
          id: '',
          club: '',
          order: '',
          deadline_from: '',
          deadline_to: '',
          order_asc: true,
          type_request: ''
        };
        this.$refs.deadlineFrom.model = null;
        this.$refs.deadlineTo.model = null;
        this.requestType = {
          label: 'Request Type',
          value: ''
        };
      },
      search() {
        // TODO: Support other filters
        this.getRequestBids({ status: this.bid_status });
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
