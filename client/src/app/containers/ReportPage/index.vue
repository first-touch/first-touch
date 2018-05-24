<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
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
            <playerreport v-if="report.type_report == 'player'" :report="report" :downloadFile="downloadFile" class="report" />
            <clubreport v-if="report.type_report == 'team'" :report="report" :downloadFile="downloadFile" class="report" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
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
  import ClubReport from './components/ClubReport';
  import 'vue-awesome/icons/edit';
  import 'vue-awesome/icons/eye';
  import Icon from 'vue-awesome/components/Icon';
  import ActionsItem from 'app/components/ActionsItem';

  export default {
    name: 'ReportPage',
    props: ['type'],
    components: {
      sidebar: NotificationSidebar,
      playerreport: PlayerReport,
      clubreport: ClubReport,
      icon: Icon,
      'action-item': ActionsItem
    },
    data() {
      return {};
    },
    computed: {
      ...mapGetters(['searchReport']),
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
      downloadFile(id, filename) {
        this.getAttachment({
          id,
          filename
        });
      }
    }
  };
</script>
