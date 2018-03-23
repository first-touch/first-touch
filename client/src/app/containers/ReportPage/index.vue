<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page edit-profile">
        <h4 class="header">Report</h4>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .profile-item {
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
    mapActions
  } from 'vuex';
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';

  export default {
    name: 'ReportPage',
    props: [
      'type',
    ],
    components: {
      sidebar: NotificationSidebar,
    },
    data() {
      return {};
    },
    methods: {}
  };
</script>