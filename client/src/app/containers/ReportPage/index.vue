<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h4 class="header">Report</h4>
        <div v-if="report != null" class="report-container">
          <div data-v-5d9799ca="" class="arrow"></div>
          <div class="content">
            <ul v-if="owner" class="menu">
              <li>
                <router-link :to="`/report/view/${report.id}`" class="active">View</router-link>
              </li>
              <li>
                <router-link :to="`/report/edit/${report.id}`">Edit</router-link>
              </li>
            </ul>
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

.report-container {
  display: flex;
  border-left: 7px solid #a8cb5c;
  margin-top: 20px;
}

.arrow {
  width: 0;
  height: 0;
  margin-right: 20px;
  border-top: 7px solid transparent;
  border-bottom: 7px solid transparent;
  border-left: 7px solid;
  margin-top: 18px;
  border-left-color: #a8cb5c;
}

.content {
  background-color: $form-background;
  border-radius: 5px;
  width: 100%;
}

.report-container {
  color: black;
  .report {
    padding: 50px;
  }
  .menu {
    li {
      display: inline-block;
      a {
        display: block;
        padding: 10px 20px;
        border-radius: 10px;
        &.active,
        &:hover {
          background: #a8cb5c;
          cursor: pointer;
          color: white;
        }
        color: black;
      }
    }
  }
}
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import PlayerReport from './components/PlayerReport';
import ClubReport from './components/ClubReport';

export default {
  name: 'ReportPage',
  props: ['type'],
  components: {
    sidebar: NotificationSidebar,
    playerreport: PlayerReport,
    clubreport: ClubReport
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
