<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h4 class="header">My reports</h4>
        <timeline-item>
          <div class="widget-reports ft-search-widget col col-lg-12">
            <div class="row">
              <div class="col-lg-2 count-div">
                <h6 class="list-title">Reports Count</h6>
                <h1 class="list-count">{{listReport.length}}</h1>
                <div class="row little-count">
                  <span class="col-lg-6">
                    <span class="col-lg-12">
                      Pending
                    </span>
                    <span class="col-lg-12 list-little-count">
                      {{pending}}
                    </span>
                  </span>
                  <span class="col-lg-6">
                    <span class="col-lg-12">
                      Completed
                    </span>
                    <span class="col-lg-12 list-little-count">
                      {{complete}}
                    </span>
                  </span>
                  <fieldset class="col-lg-12 col-md-2 buttons-inner" v-if="nbFilters">
                    <button class="ft-button" @click="clearsFilter">Clear {{nbFilters}} Filters</button>
                  </fieldset>
                </div>
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
                  <th scope="col" class="shortable" @click="setOrder('completion_status')">
                    <p>Status</p>
                    <span v-if="params.order == 'completion_status'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable">Actions</th>
                </tr>
              </thead>
              <tbody>
                <report v-for="report in listReport" :report="report" :key="report.id" mode="table" :viewAction="viewAction" :refundAction="refundAction"
                  :fields="['id','scout','priceCurrency','completion_status','action']" />
              </tbody>
            </table>
          </div>
          <b-modal class="ft-modal" size="md" ref="refundModal">
            <div class="content" v-if="refundSuccess">
              <h5>Refund requested !</h5>
              <div class="buttons-inner">
                <button class="ft-button" @click="hideModal">Close</button>
              </div>
            </div>
            <div class="content" v-if="refundErrors">
              <ul class="error">
                <li v-for="e in refundErrors" :key="e.id">{{e}}</li>
              </ul>
              <div class="buttons-inner">
                <button class="ft-button" @click="hideModal">Close</button>
              </div>
            </div>
            <div class="content" v-if="refundLoading">
              <h5>Refund requested In progress Please wait..</h5>
              <div class="buttons-inner">
                <button class="ft-button" @click="hideModal">Close</button>
              </div>
            </div>
          </b-modal>
        </timeline-item>
      </div>
    </div>
  </div>
</template>
<style lang="scss">
  @import '~stylesheets/form';
  @import '~stylesheets/search';
  @import '~stylesheets/modal';
</style>

<style lang="scss" scoped>

</style>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS,
    ASYNC_FAIL,
    ASYNC_LOADING
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
        nbFilters: 0
      };
    },
    computed: {
      ...mapGetters(['searchReport', 'order', 'refund']),
      listReport() {
        if (this.searchReport.status === ASYNC_SUCCESS) {
          return this.searchReport.value.report;
        }
        return [];
      },
      refundSuccess() {
        if (this.refund.status === ASYNC_SUCCESS) {
          return true;
        }
        return false;
      },
      refundErrors() {
        if (this.refund.status === ASYNC_FAIL) {
          return this.refund.errors;
        }
        return null;
      },
      refundLoading() {
        if (this.refund.status === ASYNC_LOADING) {
          return true;
        }
        return null;
      },
      pending() {
        if (this.searchReport.status === ASYNC_SUCCESS) {
          return this.searchReport.value.count.pending;
        }
      },
      complete() {
        if (this.searchReport.status === ASYNC_SUCCESS) {
          return this.searchReport.value.count.complete;
        }
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
      ...mapActions(['getReports', 'newOrder', 'refundOrder']),
      clearsFilter() {
        this.$refs.filter.clearsFilter();
      },
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
      refundAction(id) {
        this.refundOrder(id);
        this.$refs.refundModal.show();

      },
      hideModal() {
        this.$refs.refundModal.hide();
      },
      search() {
        this.nbFilters = this.$refs.filter.nbFilters
        this.getReports(this.url);
      }
    }
  };
</script>
