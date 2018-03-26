<template>
  <div>
    <sidebar />
    <!-- Modal Component -->
    <b-modal id="metaModal" size="lg" ref="metaModal">
      <playerreportpopup v-if="reportSelected" :report="reportSelected" />
    </b-modal>
    <div class="container-fluid">
      <div class="ft-page">
        <div class="container">
          <reportitem v-for="report in searchReport.value.report" :key="report.id" class="row report" :report="report" :viewAction="viewAction" :summaryAction="playerAction" />
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
  #metaModal {
    color: black;
    header{
      display: none;
    }
    h5{
      margin-bottom:35px;
    }
    .modal-content {
      padding: 50px 80px;
    }
    .reportHeadline {
      margin-bottom: 40px;
      p.col {
        margin: 0;
      }
    }
    .infos .row {
      .col {
        margin: 0;
        .list {
          text-transform: capitalize;
        }
      }
    }
  }
</style>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .report {
    background: white;
    color: black;
    padding: 30px 50px;
    margin-top: 20px;
    .buttons {
      display: flex;
      button {
        align-self: flex-end;
      }
    }
    .user {
      .name {
        text-align: center;
        text-transform: capitalize;
        background: #e8e8e8;
        margin-top: 15px;
        padding: 10px;
      }
    }
    .report-info {
      margin-left: 30px;
      margin-top: 20px;
      p::first-letter {
        text-transform: capitalize;
      }
    }
  }
</style>

<script>
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS
  } from 'app/constants/AsyncStatus';
  import ReportItem from 'app/components/ReportItem';
  import PlayerReportPopup from './components/PlayerReportPopup';

  export default {
    name: 'MarketPlacePage',
    components: {
      sidebar: NotificationSidebar,
      reportitem: ReportItem,
      playerreportpopup:PlayerReportPopup
    },
    data() {
      return {
        reportSelected: null,
      };
    },
    mounted() {
      this.getReports({
        't': 't'
      });
    },
    computed: {
      ...mapGetters(['searchReport']),
    },
    methods: {
      ...mapActions(['getReports']),
      viewAction(report) {
        this.$router.push({
            path: '/report/view/' + report.id
          })
      },
      playerAction(report) {
        this.reportSelected = report;
        this.$refs.metaModal.show()
      }
    },
  };
</script>