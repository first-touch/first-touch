<template>
  <div class="widget-request ft-search-widget">
    <h4 class="spaced-title upper-cased main-color">My ASSIGNMENTS</h4>
    <timeline-item>
      <div class="widget-content col col-lg-12">
        <div class="row align-items-start">
          <div class="col-lg-2 row">
            <h6 class="list-title col-lg-12 ">ASSIGNMENT COUNT</h6>
            <h1 class="list-count col-lg-12 ">{{listRequest.length}}</h1>
            <fieldset class="col-lg-12 col-md-2 buttons-inner" v-if="nbFilters">
              <button class="ft-button" @click="clearsFilter">Clear {{nbFilters}} Filters</button>
            </fieldset>
          </div>
          <form @submit.prevent="search" class="col-lg-10 row">
            <fieldset class="col-lg-3">
              <input type="number" min="0" class="col-lg-12  form-control" v-model="params.id" placeholder="Job Request Id" @keyup="search()"
              />
            </fieldset>
            <fieldset class="col-lg-3">
              <vselect v-model="vselect_type"  class="form-control m-field-input" :class="params.type_request == '' ? 'empty' : '' " :options="options.type_request" :searchable="false" :clearable="false" />
            </fieldset>
            <fieldset class="col-lg-2">
              <vselect v-model="vselect_status"  class="form-control m-field-input"  :class="params.status == '' ? 'empty' : '' " :options="options.status" :searchable="false" />
            </fieldset>
            <fieldset class="col-lg-3 calendar-filter">
              <ftdatepicker class="col-lg-12 form-control" ref="createdDate" :value="params.created_date" :clearable="false" placeholder="Created date"
                v-on:update:val="params.created_date = $event; search()" />
            </fieldset>

            <fieldset class="col-lg-3">
              <input type="number" min="0" class="col-lg-12 form-control" v-model="params.min_bids" placeholder="Minimum bids" @keyup="search"
              />
            </fieldset>
            <fieldset class="col-lg-3">
              <input type="number" min="0" class="col-lg-12 form-control" v-model="params.max_bids" placeholder="Maximum bids" @keyup="search"
              />
            </fieldset>
          </form>
        </div>
      </div>
      <table class="table table-search table-responsive-lg">
        <thead>
          <tr>
            <th scope="col" class="sortable" @click="setOrder('type_request')">
              <p>Job Type </p>
              <span v-if="params.order == 'type_request'">
                <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
              </span>
            </th>
            <th scope="col" class="sortable" @click="setOrder('created_at')">
              <p>Created On</p>
              <span v-if="params.order == 'created_at'">
                <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
              </span>
            </th>
            <th scope="col" class="sortable" @click="setOrder('bids')">
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
            :widgets="['type','created_at','bids','action']"></request>
        </tbody>
      </table>
    </timeline-item>
  </div>
</template>


<style lang="scss">
  @import '~stylesheets/variables';

  @import '~stylesheets/form';

</style>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

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
      nbFilters() {
        var i = 0;
        var params = this.params;
        for (var key in params) {
          if (['bids_status', 'order_asc', 'order'].indexOf(key) < 0)
            i = params[key] != '' ? i + 1 : i;
        }
        return i;
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
      vselect_status: function () {
        this.params.status = this.vselect_status.value;
        this.search();
      }
    },
    methods: {
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
        this.vselect_type = {
          label: 'Request Type',
          value: ''
        };
        this.vselect_status = {
          label: 'Status',
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
