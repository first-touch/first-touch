<template>
  <timeline-item>
    <div class="widget-reports ft-search-widget col col-lg-12">
      <div class="row">
        <div class="col-lg-2">
          <div class="row">
            <h6 class="list-title col-lg-12 ">Count</h6>
            <h1 class="list-count col-lg-12 ">{{requestList.length}}</h1>
            <fieldset class="col-lg-12 col-md-2 buttons-inner" v-if="nbFilters">
              <button class="ft-button" @click="clearsFilter">Clear {{nbFilters}} Filters</button>
            </fieldset>
          </div>
        </div>
        <form @submit.prevent="search" class="col-lg-10">
          <div class="form-row">
            <div class="form-group col-md-4">
              <label for="filter-by-type">Type</label>
              <v-select v-model="requestType" :options="options.type_request" :searchable="false" :clearable="false" />
            </div>
            <div class="form-group col-md-4">
              <label for="filter-by-type">Status</label>
              <v-select v-model="requestStatus" :options="options.status" :searchable="false" :clearable="false" />
            </div>
            <div class="form-group col-md-4">
              <label for="filter-by-date">Filter by Date</label>
              <ft-datepicker class="col-lg-12 form-control" ref="createdDate" :value="params.created_date" :clearable="false" placeholder="Created date" v-on:update:val="params.created_date = $event; search()" />
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-md-12">
              <label for="filter-by-bidrange">Filter by Bid Range</label>
              <div id="filter-by-bidrange" class="input-group">
                <input type="number" min="0" class="col-lg-12 form-control" v-model="params.min_bids" placeholder="Minimum bids" @keyup="search" />
                <input type="number" min="0" class="col-lg-12 form-control" v-model="params.max_bids" placeholder="Maximum bids" @keyup="search" />
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    <table class="table table-striped table-responsive-lg">
      <thead>
        <tr>
          <th scope="col" class="sortable" @click="setOrder('status')">
            Status
            <span v-if="params.order == 'status'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="sortable" @click="setOrder('type_request')">
            Job Type
            <span v-if="params.order == 'type_request'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="sortable" @click="setOrder('created_at')">
            Created On
            <span v-if="params.order == 'created_at'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="sortable" @click="setOrder('bids')">
            No of bids
            <span v-if="params.order == 'bids'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col">Actions</th>
        </tr>
      </thead>
      <tbody>
        <request-row v-for="request in requestList"
                     :key="request.id"
                     :request="request"
                     v-on:update-status="updateStatus"
                     v-on:view-bids="viewBids"
                     @edit-request="editRequest"
        />

        <!-- <request-item-row
            v-for="request in requestList"
            :key="request.id"
            :request="request"
            @update-status="updateStatus"
            :own="true"
            mode="table"
            :widgets="['status','type','created_at','bids','action']" /> -->
      </tbody>
    </table>

    <ft-dialog>
      <div slot="title">
        <span> Request Bids </span>
      </div>
      <div>
        <h1> Hello </h1>
      </div>
    </ft-dialog>
  </timeline-item>
</template>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';

  import RequestItemRow from 'app/components/RequestItem/RequestItemRow.vue';
  import TimelineItem from 'app/components/TimelineItem';
  import VIcon from 'vue-awesome/components/Icon';
  import VSelect from 'vue-select';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import RequestRow from './RequestRow';
  import FtDialog from "app/components/FtDialog";

  export default {
    name: 'reports-request-list',
    props: [ ],
    components: {
      TimelineItem,
      RequestItemRow,
      RequestRow,
      VIcon,
      VSelect,
      FtDatepicker,
      FtDialog
    },
    data() {
      return {
        requestList: [],
        showBidsList: false,
        params: {
          id: '',
          created_date: '',
          order: '',
          order_asc: true,
          status: '',
          type_request: ''
        },
        requestType: {
          label: 'Request Type',
          value: ''
        },
        requestStatus: {
          label: 'Status',
          value: ''
        },
        timer: null,
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
          status: [{
              label: 'Status',
              value: ''
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
      },
      requestStatus: function () {
        this.params.status = this.requestStatus.value;
        this.search();
      }
    },
    methods: {
      ...mapActions(['getRequests', 'updateRequest']),

      clearsFilter() {
        this.params = {
          id: '',
          created_date: '',
          order: '',
          order_asc: true,
          status: '',
          type_request: ''
        };
        this.$refs.createdDate.model = null;
        this.requestType = {
          label: 'Request Type',
          value: ''
        };
        this.vselect_status = {
          label: 'Status',
          value: ''
        };
      },
      search() {
        clearTimeout(this.timer);
        this.timer = setTimeout(this.fetchRequests, 500);
      },
      async fetchRequests() {
        const requests = await this.getRequests(this.params);
        this.requestList = requests;
      },
      setOrder(order) {
        if (this.params.order == order){
          this.params.order_asc = !this.params.order_asc;
        } else {
          this.params.order_asc = true;
        }
        this.params.order = order;
        this.search();
      },
      updateStatus(id, status) {
        let requestParams = { status }
        this.updateRequest({ id, requestParams }).then((result)=>{
          if (!result) return;

          let requestIdx = this.requestList.findIndex((r)=>{ return r.id == id});
          if (requestIdx != -1){
            let request = this.requestList[requestIdx];
            request.status = status;

            if (request.status == "deleted"){
              this.requestList.splice(requestIdx, 1);
            }
          }

        })
      },
      editRequest({ request }){
        this.$router.push({ name: 'editRequest', params: { id: request.id } })
      },
      viewBids({request}) {

      }
    }
  };
</script>
