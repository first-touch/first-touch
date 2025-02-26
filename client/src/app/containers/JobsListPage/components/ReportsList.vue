<template>
  <timeline-item>
    <div class="widget-reports ft-search-widget col col-lg-12">
      <div class="row">
        <div class="col-lg-2">
          <div class="row">
            <h6 class="list-title col-lg-12 ">Reports Count</h6>
            <h1 class="list-count col-lg-12 ">{{listReport.length}}</h1>
            <fieldset class="col-lg-12 col-md-2 buttons-inner" v-if="nbFilters">
              <button class="btn btn-outline-dark" @click="clearsFilter">Clear {{nbFilters}} Filters</button>
            </fieldset>
          </div>
        </div>
        <form @submit.prevent="search" class="col-lg-10">
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="filter-by-id">Filter by Report Id</label>
              <input id="filter-by-id" class="form-control" v-model="params.id" type="number" min="0" placeholder="Report id" @keyup="search()" />
            </div>
            <div class="form-group col-md-6">
              <label for="filter-by-title">Filter by Report Title</label>
              <input id="filter-by-title" class="form-control" v-model="params.headline" type="text" placeholder="Title" @keyup="search()" />
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-md-12">
              <label for="filter-by-daterange">Filter by Date</label>
              <div id="filter-by-daterange" class="input-group">
                <ft-datepicker class="form-control" ref="createdFrom" :model="params.created_date_from" :clearable="false" placeholder="Created from" v-on:update:val="params.created_date_from = $event; search()" />
                <ft-datepicker class="form-control" ref="createdTo" :model="params.created_date_to" :clearable="false" placeholder="Created to" v-on:update:val="params.created_date_to = $event; search()" />
              </div>
            </div>
          </div>
        </form>
      </div>
      <table class="table table-striped table-responsive-lg">
        <thead>
          <tr>
            <th scope="col" class="sortable" @click="setOrder('id')">
              Report ID
              <span v-if="params.order == 'id'">
                <v-icon name='arrow-alt-circle-up' v-if="!params.order_asc"></v-icon>
                <v-icon name='arrow-alt-circle-down' v-if="params.order_asc"></v-icon>
              </span>
            </th>
            <th scope="col" class="sortable" @click="setOrder('headline')">
              Report name
              <span v-if="params.order == 'headline'">
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
            <th scope="col">Actions</th>
          </tr>
        </thead>
        <tbody>
          <report-row v-for="report in listReport" :report="report" :key="report.id" :updateReport="customUpdateReport" :viewAction="viewAction" />
        </tbody>
      </table>
    </div>
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
  import ReportRow from './ReportRow';
  import VSelect from 'vue-select';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import 'vue-awesome/icons/arrow-alt-circle-up';
  import 'vue-awesome/icons/arrow-alt-circle-down';
  import VIcon from 'vue-awesome/components/Icon';

  export default {
    name: 'ReportsList',
    components: {
      FtDatepicker,
      TimelineItem,
      ReportRow,
      VSelect,
      VIcon
    },
    data() {
      return {
        timer: null,
        params: {
          id: '',
          headline: '',
          report_type: '',
          created_date_from: '',
          created_date_to: '',
          order: '',
          order_asc: true,
        },
        options: {
          report_type: [{
              label: 'Report Type',
              value: ''
            },
            {
              label: 'Player',
              value: 'player'
            },
            {
              label: 'Team',
              value: 'team'
            }
          ],
        }
      };
    },
    computed: {
      ...mapGetters(['searchReport', 'report']),
      nbFilters() {
        var i = 0;
        var params = this.params;
        for (var key in params) {
          if (['order_asc', 'order'].indexOf(key) < 0)
            i = params[key] != '' ? i + 1 : i;
        }
        return i;
      },
      listReport() {
        if (this.searchReport.status === ASYNC_SUCCESS) {
          return this.searchReport.value.report;
        }
        return [];
      },
      url() {
        var params = this.params;
        params.created_date_from = this.$options.filters.railsdate(params.created_date_from)
        params.created_date_to = this.$options.filters.railsdate(params.created_date_to)
        var url = Object.keys(params)
          .map(function (k) {
            return encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);
          })
          .join('&');
        return url;
      }
    },
    mounted() {
      this.search();
    },
    watch: {
      report() {
        if (this.report.status === ASYNC_SUCCESS) {
          var index = this.listReport.findIndex(x => x.id === this.report.value.id);
          this.listReport[index] = this.report.value;
          this.$forceUpdate();
        }
      }
    },
    methods: {
      ...mapActions(['getReports', 'updateReport']),
      clearsFilter() {
        this.params = {
          id: '',
          headline: '',
          report_type: '',
          created_date_from: '',
          created_date_to: '',
          order: '',
          order_asc: true,
        },
        this.$refs.createdFrom.model = null;
        this.$refs.createdTo.model = null;
      },
      showCalendar: function (index) {
        this.$refs.datepicker.showCalendar();
      },
      viewAction(report) {
        this.$router.push({
          name: 'scoutReportView',
          params: {
            id: report.id
          }
        });
      },
      setOrder(order) {
        if (this.params.order == order)
          this.params.order_asc = !this.params.order_asc;
        else
          this.params.order_asc = true;
        this.params.order = order;
        this.search();
      },
      customUpdateReport(status, id) {
        var report = {
          status: status
        };
        this.updateReport({
          report,
          id
        });
      },
      search() {
        var self = this
        clearTimeout(this.timer);
        this.timer = setTimeout(function () {
          self.getReports(self.url);
        }, 500);
      }
    }
  };
</script>
