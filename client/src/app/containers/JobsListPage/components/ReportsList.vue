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
          <label class="col-sm-12">Create Date Range
            <span class="clear-date" v-if="params.created_date_from != '' || params.created_date_to != '' " @click="params.created_date_from = ''; params.created_date_to = '' ">X</span>
          </label>
          <datepicker :input-class="[params.created_date_from != '' ? 'selected': '', 'input-date','col-sm-12'].join(' ')" v-model="params.created_date_from"
            class="datepicker col-sm-5" format="MM/dd/yyyy"></datepicker>
          <span class="separator">—</span>
          <datepicker :input-class="[params.created_date_to != '' ? 'selected': '', 'input-date','col-sm-12'].join(' ')" v-model="params.created_date_to"
            class="datepicker col-sm-5" format="MM/dd/yyyy"></datepicker>
        </fieldset>
        <fieldset class="form-group col-md-4 filter">
          <label class="col-sm-12"> - </label>
          <button class="btn-info">Filter</button>
        </fieldset>
      </form>


      <div class="header col col-md-12">
        <p :class="[params.order == 'id'? 'active':'','order','col col-md-3']" @click="params.order = 'id'; search()">REPORT ID</p>
        <p :class="[params.order == 'headline'? 'active':'','order','col col-md-3']" @click="params.order = 'headline'; search()">REPORT NAME</p>
        <p :class="[params.order == 'created_on'? 'active':'','order','col col-md-3']" @click="params.order = 'created_on'; search()">CREATED ON</p>
        <p class="col col-md-3">ACTION</p>
      </div>

      <div class="newResult col col-md-12" v-if="listReport.length > 0" v-for="report in listReport" :key="report.id">
        <p class="col col-md-3">{{report.id | reportId(report.type_report)}}</p>
        <p class="col col-md-3" :title="report.headline">
          {{report.headline}}
        </p>
        <p class="col col-md-3">{{report.created_at | moment}}</p>
        <p class="col col-md-3">
          <span class="action col col-sm-2">
            <router-link :to="{ name: 'scoutReportView', params: { id: report.id }}"
            >View Report</router-link>
          </span>
          <span class="action col col-sm-2" v-if="report.status == 'publish'">
            <a @click="customUpdateReport('private',report.id)" href="#" class="col-sm-2">Unpublish</a>
          </span>
          <span class="action col col-sm-2" v-if="report.status != 'publish'">
            <a @click="customUpdateReport('publish',report.id)" href="#" class="col-sm-2">Publish</a>
          </span>
        </p>
      </div>
    </div>
  </div>
</template>
<style lang="scss">
@import '~stylesheets/variables';
.widget-reports {
  .datepicker {
    padding: 0;
    color: black;
    margin-right: 5px;
    background: white;
    input.input-date {
      padding: 0;
      border: 1px solid $secondary-text-color !important;
      cursor: pointer;
      width: 100%;
      height: 2em;
      border: 0px;
      background: white;
      background: url('/images/calendar.png') no-repeat;
      background-size: 2em 1.7em;
      background-position: right;
      &.selected {
        background: url('/images/calendar-fill.png') no-repeat;
        background-size: 2em 1.7em;
        background-position: right;
      }
    }
  }
}
</style>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.widget-reports {
  color: $secondary-text-color;
  background: $div-filter-background;
  padding-left: 10px;

  .header {
    font-size: 13px;
    padding: 0;
    background: white;
    color: black;
    text-align: left;
    margin: 0;
    overflow: hidden;
    margin-bottom: 30px;
    max-height: 50px;

    p {
      border: 1px solid black;
      padding: 20px 0 20px 0px;
      font-weight: bold;
      float: left;
      text-align: center;
      &.order {
        cursor: pointer;
        &.active {
          text-decoration: underline;
        }
      }
    }
  }
  .newResult {
    font-size: 12px;
    padding: 0;
    overflow: hidden;
    background: white;
    color: black;
    border: 1px solid black;
    height: 40px;
    p {
      height: 40px;
      border-right: 1px solid black;
      float: left;
      text-align: center;

      span {
        padding: 0;
        float: left;
      }
      &:first-letter {
        text-transform: capitalize;
      }
    }
    &::last-child {
      padding: 0;
      p {
        padding: 0;
      }
    }
  }
  .clear-date {
    cursor: pointer;
    color: red;
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
  data () {
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
    listReport () {
      if (this.searchReport.status === ASYNC_SUCCESS) {
        return this.searchReport.value.report;
      }
      return [];
    }
  },
  mounted () {
    this.getReports({});
  },
  watch: {
    report () {
      if (this.report.status === ASYNC_SUCCESS) {
        var index = this.listReport.findIndex(x => x.id === this.report.value.id);
        this.listReport[index] = this.report.value;
        this.$forceUpdate();
      }
    }
  },
  methods: {
    ...mapActions(['getReports', 'updateReport']),
    customUpdateReport (status, id) {
      var report = {
        status: status
      };
      this.updateReport({
        report,
        id
      });
    },
    search () {
      var params = this.params;
      if (params.created_date_from) {
        params.created_date_from = this.$options.filters.railsdate(params.created_date_from);
      }
      if (params.created_date_to) {
        params.created_date_to = this.$options.filters.railsdate(params.created_date_to);
      }
      var url = Object.keys(params)
        .map(function (k) {
          return encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);
        })
        .join('&');
      this.getReports(url);
    }
  }
};
</script>
