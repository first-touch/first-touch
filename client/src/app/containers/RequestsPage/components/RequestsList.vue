<template>
  <timeline-item>
    <div class="widget-content col col-lg-12">
      <div class="row align-items-start">
        <div class="col-lg-2 row">
          <h6 class="list-title col-lg-12 ">Request Count</h6>
          <h1 class="list-count col-lg-12 ">{{requestList.length}}</h1>
          <fieldset class="col-lg-12 col-md-2 buttons-inner" v-if="nbFilters">
            <button class="ft-button" @click="clearsFilter">Clear {{nbFilters}} Filters</button>
          </fieldset>
        </div>
        <form @submit.prevent="search" class="col-lg-10 row">
          <fieldset class="col-lg-3">
            <input type="number" min="0" class="col-lg-12  form-control" v-model="params.id" placeholder="Job Request Id" @keyup="search()" />
          </fieldset>
          <fieldset class="col-lg-3">
            <v-select v-model="requestType" :options="options.type_request" :searchable="false" :clearable="false" />
          </fieldset>
          <fieldset class="col-lg-3">
            <v-select v-model="requestStatus" :options="options.status" :searchable="false" :clearable="false" />
          </fieldset>
          <fieldset class="col-lg-3">
            <ft-datepicker class="col-lg-12 form-control" ref="createdDate" :value="params.created_date" :clearable="false" placeholder="Created date"
              v-on:update:val="params.created_date = $event; search()" />
          </fieldset>
          <div class="form-row">
            <div class="form-group col-md-12">
              <label for="filter-by-daterange">Filter by Bid Range</label>
              <div id="filter-by-daterange" class="input-group">
                <input type="number" min="0" class="col-lg-12 form-control" v-model="params.min_bids" placeholder="Minimum bids" @keyup="search" />
                <input type="number" min="0" class="col-lg-12 form-control" v-model="params.max_bids" placeholder="Maximum bids" @keyup="search" />
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    <table class="table table-search table-responsive-lg">
      <thead>
        <tr>
          <th scope="col" class="shortable" @click="setOrder('status')">
            <p>Status</p>
            <span v-if="params.order == 'status'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="shortable" @click="setOrder('type_request')">
            <p>Job Type </p>
            <span v-if="params.order == 'type_request'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="shortable" @click="setOrder('created_at')">
            <p>Created On</p>
            <span v-if="params.order == 'created_at'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col" class="shortable" @click="setOrder('bids')">
            <p>No of bids</p>
            <span v-if="params.order == 'bids'">
              <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
              <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
            </span>
          </th>
          <th scope="col">Actions</th>
        </tr>
      </thead>
      <tbody>
        <request-item-row
            v-for="request in requestList"
            :key="request.id"
            :request="request"
            @update-status="updateStatus"
            :own="true"
            mode="table"
            :widgets="['status','type','created_at','bids','action']" />
      </tbody>
    </table>
  </timeline-item>
</template>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';

  import RequestItemRow from 'app/components/RequestItem/RequestItemRow.vue';
  import TimelineItem from 'app/components/TimelineItem';
  import 'vue-awesome/icons/trash';
  import 'vue-awesome/icons/calendar-alt';
  import 'vue-awesome/icons/calendar-check';
  import 'vue-awesome/icons/times';
  import 'vue-awesome/icons/arrow-alt-circle-up';
  import 'vue-awesome/icons/arrow-alt-circle-down';
  import VIcon from 'vue-awesome/components/Icon';
  import VSelect from 'vue-select';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  export default {
    name: 'reports-request-list',
    props: [ ],
    components: {
      TimelineItem,
      RequestItemRow,
      VIcon,
      VSelect,
      FtDatepicker
    },
    data() {
      return {
        requestList: [],
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
          },
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
        let request = {
          status
        }
        this.updateRequest({ id, request }).then((result)=>{
          if (!result) return;

          let request = this.requestList.find((r)=>{ return r.id == id});
          if (request){
            request.status = status;
          }
        })
      }
    }
  };
</script>
