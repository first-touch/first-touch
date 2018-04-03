<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h3>My Purchased Reports</h3>
        <div class="widget col col-md-12">
          <div class="widget-header">
            <p> No of Completed Report
              <span v-once> {{listReport.length}}</span>
            </p>
          </div>
          <div class="widget-content">
            <h5>Filter</h5>
            <form @submit.prevent="search">
              <fieldset class="form-group col-md-2 filter">
                <label class="col-sm-12">Report ID</label>
                <input class="col-md-12" type="text" v-model="params.id" />
              </fieldset>
              <fieldset class="form-group col-md-2 filter">
                <label class="col-sm-12">Scout Name</label>
                <input class="col-sm-12" type="text" v-model="params.user_name" />
              </fieldset>
              <fieldset class="form-group col-md-2 filter">
                <label class="col-sm-12">Report Status</label>
                <select name="status" class="col-sm-12" id="report-status"></select>
              </fieldset>
              <fieldset class="form-group col-md-4 filter">
                <label class="col-sm-12">Price Range (Min - Max)</label>
                <input type="number" class="col-sm-5" v-model="params.price_min" />
                <span class="separator">—</span>
                <input type="number" class="col-sm-5" v-model="params.price_max" />
              </fieldset>
              <fieldset class="form-group col-md-2 filter">
                <label class="col-sm-12"> - </label>
                <button class="btn-info">Filter</button>
              </fieldset>
            </form>
            <table class="results col col-md-12">
              <thead>
                <tr>
                  <th>REPORT ID</th>
                  <th>SCOUTS'S NAME</th>
                  <th>REPORT PRICE (IN SGD)</th>
                  <th>STATUS</th>
                  <th>ACTION</th>
                </tr>
              </thead>
              <tr v-if="listReport.length > 0" v-for="report in listReport" :key="report.id">
                <td>{{report.id | reportId(report.type_report)}} </td>
                <td>{{report.user.first_name}} {{report.user.last_name}}</td>
                <td>{{report.orders_price}}</td>
                <td>{{report.status}}</td>
                <td class="actions">
                  <span class="action col-4 ">
                    <router-link :to="`/club/report/${report.id}`">View Report</router-link>
                  </span>
                  <span class="action col-4" >
                    <a  href="#">Request Refund</a>
                  </span>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.widget {
  color: $secondary-text-color;
  background: #2b2b2b;
  padding-left: 10px;
  .widget-content {
    padding: 0 30px 20px 30px;
    form{
      background: white;
      overflow: hidden;
          border: 1px solid black;
      label{
        padding: 0;
        color: black;
      }
    }
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
          display: block;
          float: left;
          padding: 0;
        }
      }
    }
    .filter {
      float: left;
      label {
        float: left;
      }
      input,select {
        float: left;
        height: 2em;
        box-shadow: 1px 0px #000000;
      }
      .datepicker {
        float: left;
      }
      .separator {
        float: left;
        margin: 0 5px;
        font-size: 19px;
        font-weight: 800;
      }
    }
  }
}
</style>
<script>
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';

export default {
  name: 'MyPurchasedReports',
  components: {
    sidebar: NotificationSidebar
  },
  data() {
    return {
      params: {
        id: '',
        headline: '',
        user_name: '',
        created_date_from: '',
        created_date_to: '',
        purchased: true
      }
    };
  },
  computed: {
    ...mapGetters(['searchReport']),
    listReport() {
      if (this.searchReport.status === ASYNC_SUCCESS) {
        return this.searchReport.value.report;
      }
      return [];
    },
    url() {
      var params = this.params;
      return Object.keys(params)
        .map(function(k) {
          return encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);
        })
        .join('&');
    }
  },
  mounted() {
    this.search();
  },
  methods: {
    ...mapActions(['getReports', 'updateReport']),
    search() {
      this.getReports(this.url);
    }
  }
};
</script>
