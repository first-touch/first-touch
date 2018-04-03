<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
          <reportlist />
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
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
  import ReportList from './components/ReportsList';

  export default {
    name: 'JobList',
    components: {
      sidebar: NotificationSidebar,
      reportlist: ReportList
    },
    data() {
      return {
        reportSelected: null,
      };
    },
    methods: {}
  };
</script>
