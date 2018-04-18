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

            <div class="header col col-md-12">
              <p :class="[params.order == 'id'? 'active':'','order','col col-md-3']" @click="params.order = 'id'; search()">REPORT ID</p>
              <p :class="[params.order == 'username'? 'active':'','order','col col-md-3']" @click="params.order = 'username'; search()">SCOUT'S NAME</p>
              <p :class="[params.order == 'price'? 'active':'','order','col col-md-3']" @click="params.order = 'created_on'; search()">REPORT PRICE</p>
              <p :class="[params.order == 'status'? 'active':'','order','col col-md-3']" @click="params.order = 'status'; search()">STATUS</p>
              <p class="col col-md-3">ACTION</p>
            </div>

            <div class="newResult col col-md-12" v-if="listReport.length > 0" v-for="report in listReport" :key="report.id">
              <p class="col col-md-3">{{report.id | reportId(report.type_report)}}</p>
              <p class="col col-md-3" :title="report.headline">
                {{report.user.first_name}} {{report.user.last_name}}
              </p>
              <p class="col col-md-3">{{report.orders_price}}</p>
              <p class="col col-md-3">
                {{report.status}}
              </p>
              <p class="col col-md-3">
                <span class="action col-4 ">
                  <router-link :to="{ name: 'clubReport', params: { id: report.id }}">View Report</router-link>
                </span>
                <span class="action col-4">
                  <a href="#">Request Refund</a>
                </span>
              </p>
            </div>
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
    background: $div-filter-background;
    padding-left: 10px;
    .widget-content {
      padding: 0 30px 20px 30px;
      form {
        background: white;
        overflow: hidden;
        border: 1px solid black;
        label {
          padding: 0;
          color: black;
        }
      }

      .header {
        font-size: 13px;
        padding: 0;
        background: white;
        color: black;
        text-align: left;
        margin: 0;
        overflow: hidden;
        margin: 30px 0;
        max-height: 50px;

        p {
          border: 1px solid black;
          padding: 20px 0 20px 0px;
          font-weight: bold;
          float: left;
          text-align: center;
          width: 20%;
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
          width: 20%;
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
      .filter {
        float: left;
        label {
          float: left;
        }
        input,
        select {
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
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS
  } from 'app/constants/AsyncStatus';

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
          .map(function (k) {
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
