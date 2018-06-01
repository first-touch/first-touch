<template>
  <div>
    <h4 class="header">My independent reports</h4>
    <timeline-item>
      <div class="widget-reports ft-search-widget col col-lg-12">
        <div class="row">
          <div class="col-lg-2 row">
            <h6 class="list-title col-lg-12 ">Reports Count</h6>
            <h1 class="list-count col-lg-12 ">{{listReport.length}}</h1>
            <fieldset class="col-lg-12 col-md-2 buttons-inner" v-if="nbFilters">
              <button class="ft-button" @click="clearsFilter">Clear {{nbFilters}} Filters</button>
            </fieldset>
          </div>
          <form @submit.prevent="search" class="col-lg-10">
            <div class="row">
              <fieldset class="col-lg-3">
                <input class="col-lg-12 form-control" v-model="params.id" type="number" min="0" placeholder="Report id" @keyup="search()"
                />
              </fieldset>
              <fieldset class="col-lg-3">
                <input class="col-lg-12 form-control" v-model="params.headline" type="text" placeholder="Headline" @keyup="search()" />
              </fieldset>
              <fieldset class="col-lg-12 calendar-filter">
                <ftdatepicker class="col-lg-5 col form-control" ref="createdFrom" :model="params.created_date_from" :clearable="false" placeholder="Created from"
                  v-on:update:val="params.created_date_from = $event; search()" />
                <p class="col-lg-1 col">-</p>
                <ftdatepicker class="col-lg-5 col form-control" ref="createdTo" :model="params.created_date_to" :clearable="false" placeholder="Created to"
                  v-on:update:val="params.created_date_to = $event; search()" />
              </fieldset>
            </div>
          </form>
        </div>
        <table class="table table-search table-responsive-lg">
          <thead>
            <tr>
              <th scope="col" class="shortable" @click="setOrder('id')">
                <p>Report ID</p>
                <span v-if="params.order == 'id'">
                  <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                  <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                </span>
              </th>
              <th scope="col" class="shortable" @click="setOrder('headline')">
                <p>Report name</p>
                <span v-if="params.order == 'headline'">
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
              <th scope="col" class="shortable">Actions</th>
            </tr>
          </thead>
          <tbody>
            <report v-for="report in listReport" :report="report" :key="report.id" :UpdateReport="customUpdateReport" :own="true" :viewAction="viewAction"
              mode="table" :fields="['id','headline','submitted','action']" />
          </tbody>
        </table>
      </div>
    </timeline-item>
  </div>
</template>
<style lang="scss">
  @import '~stylesheets/variables';
  @import '~stylesheets/form';
  @import '~stylesheets/search';

  .widget-reports {
    .datepicker {
      padding: 0;
      input.input-date {
        cursor: pointer;
        min-height: 2em;
        border: 0px;
      }
    }
    .dropdown-toggle {
      max-height: 35px;
      border: 0px;
    }
  }
</style>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
</style>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS
  } from 'app/constants/AsyncStatus';
  import TimelineItem from 'app/components/TimelineItem';
  import ReportItem from 'app/components/ReportItem';
  import vSelect from 'vue-select';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import 'vue-awesome/icons/arrow-alt-circle-up';
  import 'vue-awesome/icons/arrow-alt-circle-down';
  import Icon from 'vue-awesome/components/Icon';

  export default {
    name: 'ReportsList',
    components: {
      ftdatepicker: FtDatepicker,
      'timeline-item': TimelineItem,
      report: ReportItem,
      vselect: vSelect,
      icon: Icon
    },
    data() {
      return {
        vselect_type: {
          label: 'Report Type',
          value: ''
        },
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
        params.report_type = this.vselect_type.value;
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
