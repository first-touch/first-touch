<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h4 class="header">Report</h4>
        <div class="timeline-widget" v-if="owner">
          <div class="arrow"></div>
          <button class="timeline-widget-button">
            <span>
              <icon name='eye' scale="1.5"></icon>
            </span>
            <router-link :to="`/report/view/${report.id}`" class="active">View</router-link>
          </button>
          <button class="timeline-widget-button">
            <span>
              <icon name='edit' scale="1.5"></icon>
            </span>
            <router-link :to="`/report/edit/${report.id}`">Edit</router-link>
          </button>
        </div>
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
 .timeline-widget {
    display: flex;
    border-left: 7px solid $secondary-header-color;

    .timeline-widget-button {
      color: $secondary-text-color;
      text-transform: uppercase;
      background-color: $navbar-background-color;
      border: none;
      margin-right: 20px;
      a {
        padding-left: 20px;
        color: $main-text-color;
        &.active {
          color: $secondary-header-color;
        }
      }
      span {
        border-radius: 50%;
        color: #fff;
        text-align: center;
        background: $timeline-widget-button-background;
        display: inline-block;
        color: $timeline-widget-button-color;
        padding: 5px 8px;
      }
      &.button-right {
        cursor: pointer;
        float: right;
        margin-left: auto;
        span.publish {
          background: $secondary-header-color;
          color: white;
        }
      }
    }
    .arrow {
      margin-top: 18px;
      border-left-color: $secondary-header-color;
    }
  }

</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import PlayerReport from './components/PlayerReport';
import ClubReport from './components/ClubReport';
import 'vue-awesome/icons/edit';
import 'vue-awesome/icons/eye';
import Icon from 'vue-awesome/components/Icon';

export default {
  name: 'ReportPage',
  props: ['type'],
  components: {
    sidebar: NotificationSidebar,
    playerreport: PlayerReport,
    clubreport: ClubReport,
    icon: Icon
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
