<template>
  <div class="col col-md-12">
    <h5>My independent reports</h5>
    <div class="widget-reports col col-md-12">
      <h5>Filter</h5>
      <form @submit.prevent="search">
        <fieldset class="form-group col-md-2 filter">
          <label class="col-sm-12">Report ID</label>
          <input class="col-md-12" type="text" v-model="params.id" />
        </fieldset>
        <fieldset class="form-group col-md-2 filter">
          <label class="col-sm-12">Report Name</label>
          <input class="col-sm-12" type="text" v-model="params.headline" />
        </fieldset>
        <fieldset class="form-group col-md-4 filter">
          <label class="col-sm-12">Create Date Range</label>
          <datepicker :input-class="[params.created_date_from != '' ? 'selected': '', 'input-date','col-sm-12'].join(' ')" v-model="params.created_date_from"
            class="datepicker col-sm-5"></datepicker>
          <span class="separator">—</span>
          <datepicker :input-class="[params.created_date_to != '' ? 'selected': '', 'input-date','col-sm-12'].join(' ')" v-model="params.created_date_to"
            class="datepicker col-sm-5"></datepicker>
        </fieldset>
        <fieldset class="form-group col-md-4 filter">
          <label class="col-sm-12"> - </label>
          <button class="btn-info" >Filter</button>
        </fieldset>
      </form>
      <table class="results col col-md-12">
        <thead>
          <tr>
            <th>REPORT ID</th>
            <th>REPORT NAME</th>
            <th>CREATED ON</th>
            <th>ACTION</th>
          </tr>
        </thead>
        <tr v-if="listReport.length > 0" v-for="report in listReport" :key="report.id">
          <td>{{report.id | reportId(report.type_report)}} </td>
          <td>{{report.headline}}</td>
          <td>{{report.updated_at | moment}}</td>
          <td class="actions">
            <span class="action col col-sm-2">
              <router-link :to="`/report/view/${report.id}`">View Report</router-link>
            </span>
            <span class="action col col-sm-2" v-if="report.status == 'publish'">
              <a @click="customUpdateReport('private',report.id)" href="#" class="col-sm-2">Unpublish</a>
            </span>
            <span class="action col col-sm-2" v-if="report.status != 'publish'">
              <a @click="customUpdateReport('publish',report.id)" href="#" class="col-sm-2">Publish</a>
            </span>
          </td>
        </tr>
      </table>
    </div>
  </div>
</template>
<style lang="scss">
.widget-reports {
  .datepicker {
    color:black;
    margin-right: 5px;
    background: white;
    input.input-date {
      cursor: pointer;
      width: 100%;
      height: 2em;
      border: 0px;
      background: white;
      background: url('/images/calendar.png') no-repeat;
      background-size: 2em 1.7em;
      background-position: center;
      text-indent: 100%;
      white-space: nowrap;
      overflow: hidden;
      &.selected {
        background: url('/images/calendar-fill.png') no-repeat;
        background-size: 2em 1.7em;
        background-position: center;
      }
    }
  }
}
</style>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.widget-reports {
  color: $secondary-text-color;
  background: #2b2b2b;
  padding-left: 10px;
  table {
    background: white;
    color: black;
    text-align: center;
    th,
    td {
      border: 1px solid black;
    }
    .actions {
      max-width: 100px;
      text-align: left;
      .action {
        padding:0;
      }
    }
  }
  .filter {
    float: left;
    label {
      float: left;
    }
    input {
      float: left;
      height: 2em;
    }
    .datepicker {
      float: left;
    }
    .separator {
      float: left;
      margin-right: 5px;
      font-size: 19px;
      font-weight: 800;
    }
  }
}
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import Datepicker from 'vuejs-datepicker';

export default {
  name: 'ReportsList',
  components: {
    datepicker: Datepicker
  },
  data() {
    return {
      params: {
        id: '',
        headline: '',
        created_date_from: '',
        created_date_to: ''
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
    }
  },
  mounted() {
    this.getReports({});
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
      var params = this.params;
      if (params.created_date_from) {
        params.created_date_from = this.$options.filters.railsdate(params.created_date_from);
      }
      if (params.created_date_to) {
        params.created_date_to = this.$options.filters.railsdate(params.created_date_to);
      }
      var url = Object.keys(params)
        .map(function(k) {
          return encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);
        })
        .join('&');
      this.getReports(url);
    }
  }
};
</script>
