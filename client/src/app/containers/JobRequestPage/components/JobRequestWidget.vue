<template>
  <div class="widget-request ft-search-widget">
    <h4 class="header">My Jobs Request</h4>
    <timeline-item>
      <div class="widget-content col col-lg-12">
        <div class="row align-items-start">
          <div class="col-lg-2">
            <h6 class="list-title">Request Count</h6>
            <h1 class="list-count">{{listRequest.length}}</h1>
          </div>
          <form @submit.prevent="search" class="col-lg-10 row">
            <fieldset class="col-lg-4 filter">
              <input type="number" class="col-lg-12  form-control" v-model="params.id" placeholder="Job Request Id" @keyup="search()" />
            </fieldset>
            <fieldset class="col-lg-55 filter">
              <vselect v-model="vselect_type" :options="options.type_request" :searchable="false" clearable="false" />
            </fieldset>
            <fieldset class="col-lg-5 filter">
              <vselect v-model="vselect_status" :options="options.status" :searchable="false" />
            </fieldset>
            <ftdatepicker class="col-lg-5 filter form-control" :value="params.created_date" :clearable="false" placeholder="Created date"
              v-on:update:val="params.created_date = $event; search()" />
            <fieldset class="col-lg-4 filter">
              <input type="number" class="col-lg-12 form-control" v-model="params.min_bids" placeholder="Minimum bids" @keyup="search"
              />
            </fieldset>
            <fieldset class="col-lg-4 filter">
              <input type="number" class="col-lg-12 form-control" v-model="params.max_bids" placeholder="Maximum bids" @keyup="search"
              />
            </fieldset>
          </form>
        </div>
      </div>
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
            <th scope="col" class="shortable" @click="setOrder('type_request')">
              <p>Job Type </p>
              <span v-if="params.order == 'type_request'">
                <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
              </span>
            </th>
            <th scope="col" class="shortable" @click="setOrder('created_at')">
              <p>Created On</p>
              <span v-if="params.order == 'created_at'">
                <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
              </span>
            </th>
            <th scope="col" class="shortable" @click="setOrder('bids')">
              <p>No of bids</p>
              <span v-if="params.order == 'bids'">
                <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
              </span>
            </th>
            <th scope="col">Actions</th>
          </tr>
        </thead>
        <tbody>
          <request v-for="request in listRequest" :key="request.id" :request="request" :update="updateStatus" own="true" mode="table"
            :fields="['id','type','created_at','bids','action']"></request>
        </tbody>
      </table>
    </timeline-item>
  </div>
</template>


<style lang="scss">
  @import '~stylesheets/variables';
  @import '~stylesheets/search';
  form {
    .filter {
      .form-control {
        border-radius: 10px;
        color: $secondary-text-color;
      }
    }
  }
</style>

<style lang="scss" scoped>
  @import '~stylesheets/variables';


  .table-search {
    th {
      text-transform: uppercase;
      font-weight: normal;
      font-size: 1rem;
      border: none;
      text-align: center;
    }
    .shortable {
      width: 20%;
      cursor: pointer;
      span {
        float: right;
      }
      &:hover {
        color: $main-header-color;
      }
      p {
        display: inline;
      }
    }
  }
</style>
<script>
  import Datepicker from 'vuejs-datepicker';
  import RequestItem from 'app/components/RequestItem';
  import TimelineItem from 'app/components/TimelineItem';
  import 'vue-awesome/icons/trash';
  import 'vue-awesome/icons/calendar-alt';
  import 'vue-awesome/icons/calendar-check';
  import 'vue-awesome/icons/times';
  import 'vue-awesome/icons/arrow-alt-circle-up';
  import 'vue-awesome/icons/arrow-alt-circle-down';
  import Icon from 'vue-awesome/components/Icon';
  import vSelect from 'vue-select';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  export default {
    name: 'JobRequestWidget',
    props: ['listRequest', 'getRequests', 'update'],
    components: {
      datepicker: Datepicker,
      'timeline-item': TimelineItem,
      request: RequestItem,
      icon: Icon,
      vselect: vSelect,
      ftdatepicker: FtDatepicker
    },
    data() {
      return {
        params: {
          id: '',
          created_date: '',
          order: '',
          order_asc: true,
          status: '',
          type_request: ''
        },
        vselect_type: {
          label: 'Request Type',
          value: ''
        },
        vselect_status: {
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
      vselect_status: function () {
        this.params.status = this.vselect_status.value;
        this.search();
      }
    },
    methods: {
      search() {
        var self = this
        clearTimeout(this.timer);
        this.timer = setTimeout(function () {
          self.getRequests(self.url);
        }, 500);
      },
      setOrder(order) {
        if (this.params.order == order)
          this.params.order_asc = !this.params.order_asc;
        else
          this.params.order_asc = true;
        this.params.order = order;
        this.search();
      },
      updateStatus(id, status) {
        this.update(id, {
          status
        });
      }
    }
  };
</script>
