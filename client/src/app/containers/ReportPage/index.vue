<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <action-item v-if="!owner && reportValue">
          <button class="timeline-widget-button">
            <span>
              <icon name='eye' scale="1.5"></icon>
            </span>
            <router-link :to="{ name: 'clubReportList'}">Back to my report</router-link>
          </button>
        </action-item>
        <div v-if="request">
          <h4 class="spaced-title">Request</h4>
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
        <h4 class="spaced-title">Report</h4>
        <action-item v-if="owner && reportValue">
          <button class="timeline-widget-button">
            <span>
              <icon name='eye' scale="1.5"></icon>
            </span>
            <router-link :to="{ name: 'scoutReportView', params: { id: reportValue.id }}" class="active">View</router-link>
          </button>
          <button class="timeline-widget-button">
            <span>
              <icon name='edit' scale="1.5"></icon>
            </span>
            <router-link :to="{ name: 'scoutReportEdit', params: { id: reportValue.id }}">Edit</router-link>
          </button>
        </action-item>
        <div v-if="reportValue" class="report-container">
          <div class="content">
            <playerreport v-if="reportValue.type_report == 'player'" :report="reportValue" :request="request" :downloadFile="downloadFile" class="report"
            />
            <teamreport v-if="reportValue.type_report == 'team'" :report="reportValue" :request="request" :downloadFile="downloadFile" class="report"
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
      ...mapGetters(['report']),
      request() {
        if (this.reportValue)
          return this.reportValue.request
        return null;
      },
      reportValue() {
        if (this.report.status === ASYNC_SUCCESS) {
          return this.report.value.report;
        }
        return null;
      },
      owner() {
        if (this.report.status === ASYNC_SUCCESS) {
          return this.report.value.owner;
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
