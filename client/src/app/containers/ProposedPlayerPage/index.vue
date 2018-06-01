<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <request :request="request" :updateStatus="updateStatus"></request>
        <h4 class="header" v-if="request">Proposed report</h4>
        <timeline-item>
          <div class="ft-search-widget widget-reports col col-lg-12">
            <div class="row">
              <div class="col-lg-2 row">
                <h6 class="list-title col-lg-12">Reports Count</h6>
                <h1 class="list-count col-lg-12">{{listReport.length}}</h1>
                <fieldset class="col-lg-12 col-md-2 buttons-inner" v-if="nbFilters">
                  <button class="ft-button" @click="clearsFilter">Clear {{nbFilters}} Filters</button>
                </fieldset>
              </div>
              <filters ref="filter" v-on:update:search="search();" :request="requestValue"></filters>
            </div>
            <b-modal id="metaModal" size="lg" ref="metaModal">
              <playerreportpopup v-if="reportSelected && reportSelected.type_report == 'player'" :report="reportSelected" :buyAction="BuyAction"
                :closeAction="hideModal" />
            </b-modal>
            <b-modal class="ft-modal" size="lg" ref="paymentModal">
              <paymentpopup v-if="payment" :paymentAction="paymentAction" :closeAction="hideModal" :result="order" :StripeCardToken="StripeCardToken"
                :stripeClubCards="stripeClubCards" :stripePayment="stripePayment" :stripeJs="stripeJs">
                <div class="row" slot="header">
                  <label class="col-lg-3">Price:</label>
                  <p class="col-lg-8">{{reportSelected.price.value}} {{requestValue.price.currency}}</p>
                </div>
              </paymentpopup>
            </b-modal>
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
                  <th scope="col" class="shortable" @click="setOrder('scout_name')">
                    <p>SCOUT'S Name</p>
                    <span v-if="params.order == 'scout_name'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('created_at')">
                    <p>Submitted On</p>
                    <span v-if="params.order == 'created_at'">
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
                  <th scope="col" class="shortable" @click="setOrder('price')">
                    <p>Report price (in {{currency}})</p>
                    <span v-if="params.order == 'price'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable">Actions</th>
                </tr>
              </thead>
              <tbody>
                <report v-for="report in listReport" :report="report" :key="report.id" mode="table" :viewAction="viewAction" :buyAction="BuyAction"
                  :fields="['id','scout','submitted','headline','price','action']" :summaryAction="summaryAction" />
              </tbody>
            </table>
          </div>
        </timeline-item>
      </div>
    </div>
  </div>
</template>
<style lang="scss">
  @import '~stylesheets/form';
  @import '~stylesheets/modal';
  @import '~stylesheets/search';
</style>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  th.shortable {
    font-size: 13px;
    padding: 0;
    width: 16.6%;
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
  import PlayerReportPopup from './components/PlayerReportPopup';
  import PaymentPopup from 'app/components/Stripe/PaymentPopup';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import Filters from './components/Filters';
  import RequestItem from './components/RequestItem'
  import 'vue-awesome/icons/arrow-alt-circle-up';
  import 'vue-awesome/icons/arrow-alt-circle-down';
  import Icon from 'vue-awesome/components/Icon';
  import {
    ASYNC_NONE
  } from 'app/constants/AsyncStatus';
  export default {
    name: 'ProposedPlayer',
    components: {
      sidebar: NotificationSidebar,
      'timeline-item': TimelineItem,
      report: ReportItem,
      vselect: vSelect,
      icon: Icon,
      playerreportpopup: PlayerReportPopup,
      paymentpopup: PaymentPopup,
      ftdatepicker: FtDatepicker,
      filters: Filters,
      request: RequestItem
    },
    props: ['requestId'],
    data() {
      return {
        nbFilters: 0,
        payment: false,
        reportSelected: null,
        params: {
          order: '',
          order_asc: true,
        },
      };
    },
    computed: {
      ...mapGetters(['searchReport', 'order', 'stripePayment', 'stripeJs', 'stripeClubCards', 'request']),
      currency() {
        if (this.requestValue) {
          return this.requestValue.price.currency;
        }
        return null;
      },
      listReport() {
        if (this.searchReport.status === ASYNC_SUCCESS) {
          return this.searchReport.value.report;
        }
        return [];
      },
      requestValue() {
        if (this.request.value) {
          return this.request.value;
        }
        return null;
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
      if (!this.requestId && this.$route.name == 'clubReportProposed') {
        this.$router.push({
          name: 'clubReportMarketplace',
        });
      } else if (this.requestId) {
        this.getRequest(this.requestId);
      }
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
      ...mapActions(['getReports', 'newOrder', 'StripeCardToken', 'getClubsCards', 'updateRequest', 'getRequest']),
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
      BuyAction(report) {
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
      },
      setOrder(order) {
        if (this.params.order == order)
          this.params.order_asc = !this.params.order_asc;
        else
          this.params.order_asc = true;
        this.params.order = order;
        this.search();
      },
      updateStatus(status) {
        this.updateRequest({
          id: this.requestValue.id,
          request: {
            status
          }
        });
      }
    }
  };
</script>
