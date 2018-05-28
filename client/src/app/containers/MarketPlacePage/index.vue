<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h4 class="header">Report Marketplace</h4>
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
              <filters ref="filter" v-on:update:search="search();"></filters>
            </div>
            <b-modal id="metaModal" size="lg" ref="metaModal">
              <playerreportpopup v-if="reportSelected && reportSelected.type_report == 'player'" :report="reportSelected" :buyAction="BuyAction"
                :closeAction="hideModal" />
              <teamreportpopup v-if="reportSelected && reportSelected.type_report == 'team'" :report="reportSelected" :buyAction="BuyAction"
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
            <table class="table table-search">
              <thead>
                <tr>
                  <th scope="col" class="shortable" @click="setOrder('report_type')">
                    <p>Type</p>
                    <span v-if="params.order == 'report_type'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('player')">
                    <p>Player</p>
                    <span v-if="params.order == 'player'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('position')">
                    <p>Position</p>
                    <span v-if="params.order == 'player'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('P.Foot')">
                    <p>P. Foot</p>
                    <span v-if="params.order == 'player'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('height')">
                    <p>Height</p>
                    <span v-if="params.order == 'height'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('weight')">
                    <p>Weight</p>
                    <span v-if="params.order == 'weight'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('nationality')">
                    <p>Nationality</p>
                    <span v-if="params.order == 'nationality'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('scout_name')">
                    <p>SCOUT</p>
                    <span v-if="params.order == 'scout_name'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable" @click="setOrder('created_at')">
                    <p>Published</p>
                    <span v-if="params.order == 'created_at'">
                      <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                      <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
                    </span>
                  </th>
                  <th scope="col" class="shortable">Actions</th>
                </tr>
              </thead>
              <tbody>
                <report v-for="report in listReport" :report="report" :key="report.id" :viewAction="viewAction" :buyAction="BuyAction" :summaryAction="summaryAction"
                  mode="table" :fields="['type2c','player2c','position','foot','height','weight','nationality','scout','submitted','action']"
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
  @import '~stylesheets/form';
  @import '~stylesheets/modal';
  @import '~stylesheets/search';
</style>

<style lang="scss" scoped>
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
  import TeamReportPopup from './components/TeamReportPopup';
  import PaymentPopup from 'app/components/Stripe/PaymentPopup';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import Filters from './components/Filters';
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
    },
    data() {
      return {
        payment: false,
        params: {
          order: '',
          order_asc: true,
        },
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
      }
    }
  };
</script>
