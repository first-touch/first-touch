<template>
  <div>
    <h4 class="header">My independent reports</h4>
    <timeline-item>
      <div class="widget-reports col col-md-12">
        <div class="row">
          <div class="col-md-2">
            <h6 class="list-title">Reports Count</h6>
            <h1 class="list-count">{{listReport.length}}</h1>
          </div>
          <form @submit.prevent="search" class="col-md-10">
            <div class="row">
              <fieldset class="col-md-3 filter form-control">
                <vselect v-model="vselect_type" @input="search" :options="options.report_type" :searchable="false" />
              </fieldset>
              <ftdatepicker class="col-md-3 filter form-control" :value="params.created_date" v-on:update:val="params.created_date = $event; search()"
              />
              <fieldset class="col-md-3 filter form-control">
                <input class="col-sm-12 form-control" placeholder="Search tags" type="text" v-model="params.headline" />
              </fieldset>
              <fieldset class="col-md-3 filter form-control">
                <vselect v-model="vselect_sort" @input="search" :options="options.order" :searchable="false" />
              </fieldset>
            </div>
          </form>
        </div>
        <report v-for="report in listReport" :report="report" :key="report.id" :UpdateReport="customUpdateReport" />
      </div>
    </timeline-item>
  </div>
</template>
<style lang="scss">
  @import '~stylesheets/variables';
  @import '~stylesheets/form';

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

  .widget-reports {
    color: $main-text-color;
    .form-control {
      padding: 0;
    }
    .list-title {
      color: $main-text-color;
      font-size: 0.95em;
      text-transform: uppercase;
    }
    .list-count {
      color: $main-header-color;
      font-size: 4em;
      text-align: center;
    }
    .filter {
      margin: 5px;
      max-width: 23%;
      input,
      select {
        height: 100%;
        padding: 10px;
      }
      .icon-inner {
        margin-top: 5px;
        display: inline-block;
        cursor: pointer;
        &:hover {
          color: $secondary-header-color;
        }
      }
      .datepicker {
        float: left;
      }
    }
  }
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
  import ReportItem from './ReportItem';
  import vSelect from 'vue-select';
  import FtDatepicker from 'app/components/Input/FtDatepicker';

  export default {
    name: 'ReportsList',
    components: {
      ftdatepicker: FtDatepicker,
      'timeline-item': TimelineItem,
      report: ReportItem,
      vselect: vSelect
    },
    data() {
      return {
        vselect_sort: {
          label: 'Sort by',
          value: ''
        },
        vselect_type: {
          label: 'Report Type',
          value: ''
        },
        params: {
          id: '',
          headline: '',
          report_type: '',
          created_date_from: '',
          created_date_to: '',
          created_date: '',
          sort: ''
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
              value: 'Type'
            },
            {
              label: 'Price',
              value: 'price'
            }
          ]
        }
      };
    },
    computed: {
      ...mapGetters(['searchReport', 'report']),
      listReport() {
        if (this.searchReport.status === ASYNC_SUCCESS) {
          return this.searchReport.value.report;
        }
        return [];
      },
      url() {
        var params = this.params;
        if (params.created_date_from) {
          params.created_date_from = this.$options.filters.railsdate(params.created_date_from);
        }
        if (params.created_date_to) {
          params.created_date_to = this.$options.filters.railsdate(params.created_date_to);
        }
        params.sort = this.vselect_sort.value;
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
      showCalendar: function (index) {
        this.$refs.datepicker.showCalendar();
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
        this.getReports(this.url);
      }
    }
  };
</script>
