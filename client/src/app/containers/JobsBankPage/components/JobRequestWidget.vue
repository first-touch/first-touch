<template>
  <timeline-item>
    <div class="widget-reports ft-search-widget col col-lg-12">
      <div class="row">
        <div class="col-lg-2">
          <div class="row">
            <h6 class="list-title col-lg-12">Assignment Count</h6>
            <h1 class="list-count col-lg-12">{{listRequest.length}}</h1>
            <fieldset class="col-lg-12 col-md-12 buttons-inner" v-if="nbFilters">
              <button class="ft-button" @click="clearsFilter">Clear {{nbFilters}} Filters</button>
            </fieldset>
          </div>
        </div>
        <form @submit.prevent="search" class="col-lg-10">
          <div class="form-row">
            <div class="form-group col-md-4">
              <label for="filter-by-requestor">Requestor</label>
              <input id="filter-by-requestor" class="form-control" v-model="params.club" type="text" placeholder="Requested by" @keyup="search()" />
            </div>
            <div class="form-group col-md-4">
              <label for="filter-by-type">Filter by Type</label>
              <v-select v-model="requestType" :options="options.type_request" :searchable="false" :clearable="false" />
            </div>
            <div class="form-group col-md-4">
              <label for="filter-by-date">Filter by Date</label>
              <ft-datepicker id="filter-by-date" class="form-control" ref="deadlineTo" :value="params.deadline_to" :clearable="false" placeholder="Deadline to" v-on:update:val="params.deadline_to = $event; search()" />
            </div>
          </div>
        </form>
      </div>
    </div>
    <table class="table table-striped table-responsive-lg">
      <thead>
        <tr>
          <th scope="col" class="sortable" @click="setOrder('requested_by')">
            Requested By
            <span v-if="params.order == 'requested_by'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="sortable" @click="setOrder('request_type')">
            Job Type
            <span v-if="params.order == 'request_type'">
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
          <th scope="col" class="sortable" @click="setOrder('country')">
            League
            <span v-if="params.order == 'country'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="sortable" @click="setOrder('maxBid')">
            Bid Max Value
            <span v-if="params.order == 'maxBid'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col">Actions</th>
        </tr>
      </thead>
      <tbody>
        <request-row v-for="request in listRequest"
                     :key="request.id"
                     :request="request"
                     v-on:make-bid="makeBid"
        />
      </tbody>
    </table>

    <ft-dialog :visible.sync="isBidding" v-on:closed="unsetBidingOn">
      <div slot="title">
        <span v-if="requestBid != null">Edit bid</span>
        <span v-else>Make your bid</span>
      </div>
      <bid-popup :request="bidingOn"
                 :currentBid="requestBid"
                 v-on:submit-bid="submitBid"
      />
    </ft-dialog>
  </timeline-item>
</template>

<script>
  import TimelineItem from 'app/components/TimelineItem';
  import {
    ASYNC_SUCCESS,
    ASYNC_LOADING
  } from 'app/constants/AsyncStatus';
  import VSelect from 'vue-select';
  import BidPopup from './BidPopup';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import RequestRow from './RequestRow';

  export default {
    name: 'JobRequestWidget',
    props: ['listRequest', 'getRequests', 'createBid'],
    components: {
      TimelineItem,
      VSelect,
      FtDatepicker,
      RequestRow,
      BidPopup
    },
    data() {
      return {
        bidingOn: null,
        requestBid: null,
        isBidding: false,
        params: {
          id: '',
          created_date: '',
          order: '',
          club: '',
          status: '',
          type_request: '',
          deadline_to: ''
        },
        requestType: {
          label: 'Type',
          value: ''
        },
        options: {
          type_request: [{
              label: 'Type',
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
      }
    },
    watch: {
      requestType: function () {
        this.params.type_request = this.requestType.value;
        this.search();
      }
    },
    methods: {
      search() {
        const params = _.pickBy(self.params, (value) => { return value != ''; })
        this.getRequests(params);
      },
      clearsFilter() {
        this.params = {
          id: '',
          created_date: '',
          order: '',
          status: '',
          type_request: '',
          deadline_to: '',
          club: ''
        }
        this.$refs.deadlineFrom.model = null;
        this.$refs.deadlineTo.model = null;
        this.requestType = {
          label: 'Request Type',
          value: ''
        };
      },
      submitBid(price) {
        let submitRequest;
        if (this.requestBid) {
          submitRequest = this.updateBid({
            id: this.requestBid.id,
            price
          });
        } else {
          submitRequest = this.createBid({
            request_id: this.bidingOn.id,
            price
          });
        }
        submitRequest.then(res => {
          const msg = "Bid placed successfully."
          this.flash(msg, "success", { timeout: 3000, important: true });
          this.unsetBidingOn()
        })
      },
      makeBid({request, bid}) {
        this.bidingOn = request;
        this.requestBid = bid;
        this.isBidding = true;
      },
      unsetBidingOn() {
        this.bidingOn = null;
        this.isBidding = false;
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
