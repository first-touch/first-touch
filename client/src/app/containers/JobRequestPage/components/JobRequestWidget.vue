<template>
  <div class="widget-request ft-search-widget">
    <h4 class="header">My Jobs Request</h4>
    <timeline-item>
      <div class="widget-content col col-md-12">
        <div class="row align-items-start">
          <div class="col-md-2">
            <h6 class="list-title">Request Count</h6>
            <h1 class="list-count">{{listRequest.length}}</h1>
          </div>
          <form @submit.prevent="search" class="col-md-10 row">
            <fieldset class="col-md-4 filter">
              <vselect v-model="vselect_type" :options="options.type_request" :searchable="false" clearable="false" />
            </fieldset>
            <fieldset class="col-md-4 filter">
              <vselect v-model="vselect_status" :options="options.status" :searchable="false" />
            </fieldset>
            <ftdatepicker class="col-md-5 filter form-control" :value="params.created_date" :clearable="false" v-on:update:val="params.created_date = $event; search()"
            />
            <fieldset class="col-md-4 filter form-control">
              <input type="number form-control" class="col-sm-12" v-model="params.min_bids" placeholder="Minimum bids" @keyup="bidkey"
              />
            </fieldset>
          </form>
        </div>
      </div>
      <request v-for="request in listRequest" :key="request.id" :request="request" :update="updateStatus" own="true"></request>
    </timeline-item>
  </div>
</template>


<style lang="scss">
  @import '~stylesheets/variables';
  @import '~stylesheets/search';
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
        this.getRequests(this.url);
      },
      bidkey() {
        var search = this.search
        clearTimeout(this.timer);
        this.timer = setTimeout(function () {
          search();
        }, 500);
      },
      updateStatus(id, status) {
        this.update(id, {
          status
        });
      }
    }
  };
</script>
