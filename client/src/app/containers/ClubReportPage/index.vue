<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page edit-profile">
        <h4 class="header">Create Club Report</h4>
        <div class="report-form">
          <div class="arrow"></div>
          <div class="form-container">
            <clubreportform :clubId="this.$route.params.id" :createReport="createReport" :reportStatus="reportStatus" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .report-form {
    display: flex;
    border-left: 7px solid $main-header-color;
    margin-top: 20px;
    .arrow {
      margin-top: 18px;
      border-left-color: $main-header-color;
    }
    .form-container {
      background-color: #fff;
      border-radius: 5px;
      padding: 20px;
      width: 100%;
    }
  }
</style>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';
  import ClubReportForm from './components/ClubReportForm.vue';
  import {
    ASYNC_FAIL
  } from 'app/constants/AsyncStatus';

  export default {
    name: 'ClubReportPage',
    props: ['type'],
    components: {
      sidebar: NotificationSidebar,
      clubreportform: ClubReportForm
    },
    computed: {
      ...mapGetters(['report']),
      reportStatus() {
        return this.report.status === ASYNC_FAIL ? this.report : null;
      }
    },
    methods: {
      ...mapActions(['createReport'])
    }
  };
</script>
