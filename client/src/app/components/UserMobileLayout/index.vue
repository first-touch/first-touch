<template>
  <div class="wrapper">
    <mobile-navbar></mobile-navbar>
    <flash-message outerClass="col-lg-4 m-feedback"></flash-message>
    <router-view class="main-content-wrapper"></router-view>
  </div>
</template>

<style lang="scss" scoped>
  .wrapper {
    display: flex;
    width: 100%;
    align-items: stretch;
  }
  .main-content-wrapper {
    flex-grow: 1;
    overflow: hidden;
  }
</style>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import MobileNavbar from 'app/components/UserLayout/components/MobileNavbar';
  import SearchBar from '../SearchBar';

  export default {
    name: 'UserMobileLayout',
    components: {
      'mobile-navbar': MobileNavbar,
      'search-bar': SearchBar
    },
    data() {
      return {
        placeholder: 'Search for players, clubs, events'
      }
    },
    computed: {
      ...mapGetters(['searchResult']),
    }
  };
</script>
