<template>
  <timeline-item>
    <div class="widget-reports ft-search-widget col col-lg-12">
      <div class="row">
        <div class="col-lg-2">
          <div class="row">
            <h6 class="list-title col-lg-12">Request Count</h6>
            <h1 class="list-count col-lg-12">{{listRequest.length}}</h1>
            <fieldset class="col-lg-12 col-md-12 buttons-inner" v-if="nbFilters">
              <button class="ft-button" @click="clearsFilter">Clear {{nbFilters}} Filters</button>
            </fieldset>
          </div>
        </div>
        <form @submit.prevent="search" class="col-lg-10">
          <div class="form-row">
            <div class="form-group col-md-4">
              <label for="filter-by-id">Filter by Report Id</label>
              <input id="filter-by-id" class="form-control" v-model="params.id" type="number" min="0" placeholder="Report id" @keyup="search()" />
            </div>
            <div class="form-group col-md-4">
              <label for="filter-by-requestor">Requested By</label>
              <input id="filter-by-requestor" class="form-control" v-model="params.club" type="text" placeholder="Requested by" @keyup="search()" />
            </div>
            <div class="form-group col-md-4">
              <label for="filter-by-requestor">Request Type</label>
              <v-select v-model="requestType" :options="options.type_request" :searchable="false" :clearable="false" />
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-md-12">
              <label for="filter-by-daterange">Filter by Date</label>
              <div id="filter-by-daterange" class="input-group">
                <ft-datepicker class="form-control" ref="deadlineFrom" :value="params.deadline_from" :clearable="false" placeholder="Deadline from" v-on:update:val="params.deadline_from = $event; search()" />
                <ft-datepicker class="form-control" ref="deadlineTo" :value="params.deadline_to" :clearable="false" placeholder="Deadline to" v-on:update:val="params.deadline_to = $event; search()" />
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    <table class="table table-striped table-responsive-lg">
      <thead>
        <tr>
          <th scope="col" class="sortable" @click="setOrder('id')">
            Request ID
            <span v-if="params.order == 'id'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="sortable" @click="setOrder('requested_by')">
            Requested By
            <span v-if="params.order == 'requested_by'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="sortable" @click="setOrder('request_type')">
            Job Request Type
            <span v-if="params.order == 'request_type'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="sortable" @click="setOrder('price_range')">
            Price Range
            <span v-if="params.order == 'price_range'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="sortable" @click="setOrder('deadline')">
            Deadline
            <span v-if="params.order == 'deadline'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="sortable" @click="setOrder('country')">
            Country
            <span v-if="params.order == 'country'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col">Actions</th>
        </tr>
      </thead>
      <tbody>
        <!-- <request-item v-for="request in listRequest" :key="request.id" :request="request" :viewSummary="viewSummary" :addBid="addBid" :viewReport="viewReport" :createReport="createReport" /> -->
        <request-row v-for="request in listRequest" :key="request.id" :request="request" />
      </tbody>
    </table>
  </timeline-item>
</template>

<script>
  import RequestItem from 'app/components/RequestItem';
  import TimelineItem from 'app/components/TimelineItem';
  import {
    ASYNC_SUCCESS,
    ASYNC_LOADING
  } from 'app/constants/AsyncStatus';
  import VSelect from 'vue-select';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import RequestRow from './RequestRow';

  export default {
    name: 'JobRequestWidget',
    props: ['listRequest', 'getRequests', 'update', 'bid', 'createBid', 'updateBid', 'clearBid', 'user'],
    components: {
      TimelineItem,
      VSelect,
      FtDatepicker,
      RequestRow,
      RequestItem
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
        requestType: {
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
      }
    },
    watch: {
      requestType: function () {
        this.params.type_request = this.requestType.value;
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
        const params = _.pickBy(self.params, (value) => { return value != ''; })
        this.getRequests(params);
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
        this.requestType = {
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
