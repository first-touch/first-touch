<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h4 class="header">Report</h4>
        <playerreport v-if="report != null" :report="report"/>

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
    ASYNC_SUCCESS,
    ASYNC_FAIL
  } from 'app/constants/AsyncStatus';
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';
  import playerReport from './components/PlayerReport';

  export default {
    name: 'ReportPage',
    props: [
      'type',
    ],
    components: {
      sidebar: NotificationSidebar,
      playerreport: playerReport
    },
    data() {
      return {};
    },
    computed: {
      ...mapGetters(['searchReport']),
      report() {
        if (this.searchReport.status === ASYNC_SUCCESS) {
          return this.searchReport.value
        }
        return null;
      }
    },
    mounted() {
      this.getReport(this.$route.params.id);
    },
    methods: {
      ...mapActions(['getReport']),
    }
  };
</script>