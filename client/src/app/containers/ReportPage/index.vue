<template>
  <div class="ft-page container">
    <h4 class="spaced-title upper-cased main-color page-title mb-5">Report</h4>
    <div v-if="owner" class="a-side-indicator primary">
      <div class="arrow"></div>
      <ft-button :linkTo="{ name: 'scoutReports' }" icon="arrow-left">Back to my reports</ft-button>
      <ft-button :linkTo="{ name: 'scoutReportEdit', params: { id: reportValue.id }}" icon="edit">Edit</ft-button>
    </div>
    <div v-if="reportValue" class="report-container">
      <div class="content">
        <player-report
          v-if="reportValue.type_report == 'Player'"
          :report="reportValue"
          :request="request"
          :downloadFile="downloadFile"
          class="report"
        />
        <team-report
          v-if="reportValue.type_report == 'Team'"
          :report="reportValue"
          :request="request"
          :downloadFile="downloadFile"
          class="report"
        />
      </div>
    </div>
  </div>
</template>

<script>
import {
  mapGetters,
  mapActions
} from 'vuex';
import {
  ASYNC_SUCCESS
} from 'app/constants/AsyncStatus';
import PlayerReport from './components/PlayerReport';
import TeamReport from './components/TeamReport';
import FtButton from 'app/components/Button/Button';
import TimelineItem from 'app/components/TimelineItem';

export default {
  name: 'ReportPage',
  props: ['type'],
  components: {
    PlayerReport,
    TeamReport,
    TimelineItem,
    FtButton
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
