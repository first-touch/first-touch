<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h4 class="header">My independent reports</h4>
        <timeline-item>
          <div class="ft-search-widget widget-reports col col-md-12">
            <div class="row">
              <div class="col-md-2">
                <h6 class="list-title">Reports Count</h6>
                <h1 class="list-count">{{listReport.length}}</h1>
              </div>
              <form @submit.prevent="search" class="col-md-10">
                <div class="row">
                  <fieldset class="col-md-3 filter">
                    <vselect v-model="type_select" @input="search" :options="options.report_type" :searchable="false" />
                  </fieldset>
                  <ftdatepicker class="col-md-3 filter form-control" :value="params.created_date" v-on:update:val="params.created_date = $event; search()"
                  />
                  <fieldset class="col-md-3 filter form-control">
                    <input class="col-sm-12 form-control" placeholder="Search tags" type="text" v-model="params.headline" />
                  </fieldset>
                  <fieldset class="col-md-3 filter">
                    <vselect v-model="sort_select" @input="search" :options="options.order" :searchable="false" />
                  </fieldset>
                </div>
              </form>
            </div>
            <b-modal id="metaModal" size="lg" ref="metaModal">
              <playerreportpopup v-if="reportSelected && reportSelected.type_report == 'player'" :report="reportSelected" :buyAction="BuyAction"
                :closeAction="hideModal" />
              <clubreportpopup v-if="reportSelected && reportSelected.type_report == 'team'" :report="reportSelected" :buyAction="BuyAction"
                :closeAction="hideModal" />
              <paymentpopup v-if="payment" :report="reportSelected" :closeAction="hideModal" :paymentAction="PaymentAction" :order="order"
              />
            </b-modal>
            <report v-for="report in listReport" :report="report" :key="report.id" :viewAction="viewAction" :buyAction="BuyAction" :summaryAction="summaryAction"
            />
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
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import TimelineItem from 'app/components/TimelineItem';
import ReportItem from 'app/components/ReportItem';
import vSelect from 'vue-select';
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import PlayerReportPopup from './components/PlayerReportPopup';
import ClubReportPopup from './components/ClubReportPopup';
import PaymentPopup from './components/PaymentPopup';
import FtDatepicker from 'app/components/Input/FtDatepicker';

export default {
  name: 'ReportsList',
  components: {
    sidebar: NotificationSidebar,
    'timeline-item': TimelineItem,
    report: ReportItem,
    vselect: vSelect,
    playerreportpopup: PlayerReportPopup,
    clubreportpopup: ClubReportPopup,
    paymentpopup: PaymentPopup,
    ftdatepicker: FtDatepicker
  },
  data() {
    return {
      payment: false,
      reportSelected: null,
      sort_select: {
        label: 'Sort by',
        value: ''
      },
      type_select: {
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
        report_type: [
          {
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
        order: [
          {
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
    ...mapGetters(['searchReport', 'order']),
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
      params.sort = this.sort_select.value;
      params.report_type = this.type_select.value;

      var url = Object.keys(params)
        .map(function(k) {
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
    ...mapActions(['getReports', 'newOrder']),
    viewAction(report) {
      this.$router.push({ name: 'clubReport', params: { id: report.id } });
    },
    BuyAction(report) {
      this.payment = true;
      this.reportSelected = report;
      this.$refs.metaModal.show();
    },
    hideModal() {
      this.$refs.metaModal.hide();
    },
    PaymentAction(payment) {
      this.newOrder({
        order: payment
      });
    },
    summaryAction(report) {
      this.payment = false;
      this.reportSelected = report;
      this.$refs.metaModal.show();
    },
    search() {
      this.getReports(this.url);
    }
  }
};
</script>
