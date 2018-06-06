<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <action-item v-if="!owner && searchReport.value.report">
          <button class="timeline-widget-button">
            <span>
              <icon name='eye' scale="1.5"></icon>
            </span>
            <router-link :to="{ name: 'clubReportList'}">Back to my report</router-link>
          </button>
        </action-item>
        <div v-if="request">
          <h4 class="header">Request</h4>
          <timeline-item>
            <request :key="request.id" :request="request" :viewSummary="viewSummary" class="onlyone"></request>
            <b-modal id="metaModal" class="ft-modal" size="lg" ref="metaModal">
              <div>
                <playerrequestpopup v-if="request.type_request == 'player' " :request="request" :closeAction="closeAction" />
                <teamrequestpopup v-if="request.type_request == 'team' " :request="request" :closeAction="closeAction" />
                <positionrequestpopup v-if="request.type_request == 'position' " :request="request" :closeAction="closeAction" />
              </div>
            </b-modal>
          </timeline-item>
        </div>
        <h4 class="header">Report</h4>
        <action-item v-if="owner && searchReport.value.report">
          <button class="timeline-widget-button">
            <span>
              <icon name='eye' scale="1.5"></icon>
            </span>
            <router-link :to="{ name: 'scoutReportView', params: { id: report.id }}" class="active">View</router-link>
          </button>
          <button class="timeline-widget-button">
            <span>
              <icon name='edit' scale="1.5"></icon>
            </span>
            <router-link :to="{ name: 'scoutReportEdit', params: { id: report.id }}">Edit</router-link>
          </button>
        </action-item>
        <div v-if="report != null" class="report-container">
          <div class="content">
            <playerreport v-if="report.type_report == 'player'" :report="report" :request="request" :downloadFile="downloadFile" class="report"
            />
            <teamreport v-if="report.type_report == 'team'" :report="report" :request="request" :downloadFile="downloadFile" class="report"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
  @import '~stylesheets/modal';
</style>
<style lang="scss" scoped>
  @import '~stylesheets/modal';
</style>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS
  } from 'app/constants/AsyncStatus';
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';
  import PlayerReport from './components/PlayerReport';
  import TeamReport from './components/TeamReport';
  import 'vue-awesome/icons/edit';
  import 'vue-awesome/icons/eye';
  import Icon from 'vue-awesome/components/Icon';
  import ActionsItem from 'app/components/ActionsItem';
  import TimelineItem from 'app/components/TimelineItem';
  import RequestItem from 'app/components/RequestItem';
  import PlayerRequestPopup from 'app/components/RequestPopup/PlayerRequestPopup';
  import PositionRequestPopup from 'app/components/RequestPopup/PositionRequestPopup';
  import TeamRequestPopup from 'app/components/RequestPopup/TeamRequestPopup';

  export default {
    name: 'ReportPage',
    props: ['type'],
    components: {
      sidebar: NotificationSidebar,
      playerreport: PlayerReport,
      teamreport: TeamReport,
      icon: Icon,
      'action-item': ActionsItem,
      'timeline-item': TimelineItem,
      request: RequestItem,
      teamrequestpopup: TeamRequestPopup,
      playerrequestpopup: PlayerRequestPopup,
      positionrequestpopup: PositionRequestPopup
    },
    data() {
      return {};
    },
    computed: {
      ...mapGetters(['searchReport']),
      request() {
        if (this.report)
          return this.report.request
        return null;
      },
      report() {
        if (this.searchReport.status === ASYNC_SUCCESS) {
          return this.searchReport.value.report;
        }
        return null;
      },
      owner() {
        if (this.searchReport.status === ASYNC_SUCCESS) {
          return this.searchReport.value.owner;
        }
        return false;
      }
    },
    mounted() {
      this.getReport(this.$route.params.id);
    },
    methods: {
      ...mapActions(['getReport', 'getAttachment']),
      downloadFile(url, filename) {
        this.getAttachment({
          url,
          filename
        });
      },
      closeAction(request) {
        this.$refs.metaModal.hide();
      },
      viewSummary(request) {
        this.$refs.metaModal.show();
      }
    }
  };
</script>
