<template>
  <div class="wrapper">
    <mobile-navbar></mobile-navbar>
    <!--  <search-bar :search="getSearchResults" :results="searchResult.value" :placeholder="placeholder" :action="action" /> -->
    <router-view></router-view>
  </div>
</template>

<style lang="scss" scoped>
  .wrapper {
    display: flex;
    width: 100%;
    align-items: stretch;
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
