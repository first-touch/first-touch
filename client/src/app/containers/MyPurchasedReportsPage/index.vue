<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h4 class="header">My independent reports</h4>
        <timeline-item>
          <div class="widget-reports ft-search-widget col col-md-12">
            <div class="row">
              <div class="col-md-2">
                <h6 class="list-title">Reports Count</h6>
                <h1 class="list-count">{{listReport.length}}</h1>
              </div>
              <filters ref="filter" v-on:update:search="search();"></filters>
            </div>
            <table class="table table-search">
              <thead>
                <tr>
                  <th scope="col" class="shortable" @click="setOrder('id')">
                    <p>Report ID</p>
                    <span v-if="params.order == 'id'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('scout_name')">
                    <p>SCOUT'S Name</p>
                    <span v-if="params.order == 'scout_name'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('price')">
                    <p>Report price</p>
                    <span v-if="params.order == 'price'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('status')">
                    <p>Status</p>
                    <span v-if="params.order == 'status'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable">Actions</th>
                </tr>
              </thead>
              <tbody>
                <report v-for="report in listReport" :report="report" :key="report.id" mode="table" :viewAction="viewAction" :fields="['id','scout','priceCurrency','status','action']"
                />
              </tbody>
            </table>
          </div>
        </timeline-item>
      </div>
    </div>
  </div>
</template>
<style lang="scss">
  @import '~stylesheets/variables';
  @import '~stylesheets/form';
  @import '~stylesheets/search';
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
  import ReportItem from 'app/components/ReportItem';
  import vSelect from 'vue-select';
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import Filters from './components/Filters';
  import 'vue-awesome/icons/arrow-alt-circle-up';
  import 'vue-awesome/icons/arrow-alt-circle-down';
  import Icon from 'vue-awesome/components/Icon';
  export default {
    name: 'ReportsList',
    components: {
      sidebar: NotificationSidebar,
      'timeline-item': TimelineItem,
      report: ReportItem,
      vselect: vSelect,
      ftdatepicker: FtDatepicker,
      filters: Filters,
      icon: Icon,
    },
    data() {
      return {
        payment: false,
        reportSelected: null,
        params: {
          order: '',
          order_asc: true,
        },
      };
    },
    computed: {
      ...mapGetters(['searchReport', 'order']),
      listReport() {
        if (this.searchReport.status === ASYNC_SUCCESS) {
          return this.searchReport.value.report;
        }
        return [];
      },
      url() {
        var params = this.params;
        var url = Object.keys(params)
          .map(function (k) {
            return encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);
          })
          .join('&');
        return url + '&' + this.$refs.filter.url;
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
      ...mapActions(['getReports', 'newOrder']),
      viewAction(report) {
        this.$router.push({
          name: 'clubReport',
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
      refundAction(report) {
        console.log('Soon #Refund');
      },
      hideModal() {
        this.$refs.metaModal.hide();
      },
      search() {
        this.getReports(this.url);
      }
    }
  };
</script>
