<template>
  <div>
    <!-- <sidebar /> -->
    <div class="container-fluid">
      <div class="ft-page">
        <h4 class="spaced-title upper-cased main-color">Marketplace {{type}}</h4>
        <actions class="widget" :toAssignement="toAssignement" />
        <timeline-item>
          <div class="ft-search-widget widget-reports col col-lg-12">
            <h3>Available Reports</h3>
            <div class="row">
              <filters ref="filter" v-on:update:search="search();" v-on:update:type="type = $event"></filters>
            </div>
            <b-modal id="metaModal" size="lg" ref="metaModal">
              <playerreportpopup v-if="reportSelected && reportSelected.type_report == 'player'" :report="reportSelected" :buyAction="buyAction"
                :closeAction="hideModal" />
              <teamreportpopup v-if="reportSelected && reportSelected.type_report == 'team'" :report="reportSelected" :buyAction="buyAction"
                :closeAction="hideModal" />
            </b-modal>
            <b-modal class="ft-modal" size="lg" ref="paymentModal">
              <paymentpopup v-if="payment" :paymentAction="paymentAction" :closeAction="hideModal" :result="order" :StripeCardToken="StripeCardToken"
                :stripeClubCards="stripeClubCards" :stripePayment="stripePayment" :stripeJs="stripeJs">
                <div class="row" slot="header">
                  <label class="col-lg-3">Price:</label>
                  <p class="col-lg-8">{{reportSelected.price.value}} {{reportSelected.price.currency}}</p>
                </div>
              </paymentpopup>
            </b-modal>
            <div class="table-responsive-lg">
            <tables-custom :params="params" :setOrder="setOrder" :buyAction="buyAction" :viewAction="viewAction" :type="type" :listReport="listReport"></tables-custom>
            </div>
          </div>
        </timeline-item>
      </div>
    </div>
  </div>
</template>
<style lang="scss">
  @import '~stylesheets/form';
  @import '~stylesheets/modal';

</style>

<style lang="scss" scoped>
  h3 {
    text-transform: uppercase;
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
  import NotificationSidebar from 'app/components/NotificationSidebar';
  import PlayerReportPopup from './components/PlayerReportPopup';
  import TeamReportPopup from './components/TeamReportPopup';
  import PaymentPopup from 'app/components/Stripe/PaymentPopup';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import Filters from './components/Filters';
  import Actions from './components/Actions';
  import Tables from './components/Tables';

  import 'vue-awesome/icons/edit';
  import 'vue-awesome/icons/eye';
  import 'vue-awesome/icons/eye-slash';
  import Icon from 'vue-awesome/components/Icon';
  import {
    ASYNC_NONE
  } from 'app/constants/AsyncStatus';
  export default {
    name: 'ReportsList',
    components: {
      sidebar: NotificationSidebar,
      'timeline-item': TimelineItem,
      report: ReportItem,
      vselect: vSelect,
      playerreportpopup: PlayerReportPopup,
      teamreportpopup: TeamReportPopup,
      paymentpopup: PaymentPopup,
      ftdatepicker: FtDatepicker,
      filters: Filters,
      icon: Icon,
      actions: Actions,
      'tables-custom': Tables

    },
    data() {
      return {
        payment: false,
        params: {
          order: '',
          order_asc: true,
        },
        type: 'player',
        reportSelected: null,
        nbFilters: 0
      };
    },
    computed: {
      ...mapGetters(['searchReport', 'order', 'stripePayment', 'stripeJs', 'stripeClubCards']),
      proposed() {
        return this.$route.name == 'clubReportProposed'
      },
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
      },
      proposed() {
        this.search();
      },
      order() {
        if (this.order.status === ASYNC_SUCCESS) {
          this.$router.push({
            name: 'clubReport',
            params: {
              id: this.reportSelected.id
            }
          });
        }
      },
    },
    methods: {
      ...mapActions(['getReports', 'newOrder', 'StripeCardToken', 'getClubsCards']),
      clearsFilter() {
        this.$refs.filter.clearsFilter();
      },
      toAssignement(){
        this.$router.push({name: 'clubRequestList'})
      },
      setOrder(order) {
        if (this.params.order == order)
          this.params.order_asc = !this.params.order_asc;
        else
          this.params.order_asc = true;
        this.params.order = order;
        this.search();
      },
      viewAction(report) {
        this.$router.push({
          name: 'clubReport',
          params: {
            id: report.id
          }
        });
      },
      buyAction(report) {
        if (this.stripeClubCards.status == ASYNC_NONE)
          this.getClubsCards();
        this.payment = true;
        this.reportSelected = report;
        this.$refs.metaModal.hide();
        this.$refs.paymentModal.show();
      },
      hideModal() {
        this.$refs.metaModal.hide();
      },
      summaryAction(report) {
        this.payment = false;
        this.reportSelected = report;
        this.$refs.metaModal.show();
      },
      search() {
        this.nbFilters = this.$refs.filter.nbFilters
        this.getReports(this.url);
      },
      paymentAction(token, save, usesaved) {
        this.newOrder({
          token: token,
          report_id: this.reportSelected.id,
          save: save,
          usesaved
        });
      }
    }
  };
</script>
