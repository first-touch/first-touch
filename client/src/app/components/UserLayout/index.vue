<template>
  <div>
    <navbar :page="page" />
    <search-bar :search="getSearchResults" :results="searchResult.value" :placeholder="placeholder" :action="action" />
    <router-view></router-view>
  </div>
</template>

<style lang="scss">
  @import '~stylesheets/variables';
  @import '~stylesheets/common_style';
</style>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import Navbar from './components/UserNavbar';
  import SearchBar from '../SearchBar';

  export default {
    name: 'UserLayout',
    components: {
      navbar: Navbar,
      'search-bar': SearchBar,
    },
    data() {
      return {
        placeholder: 'Search for players, clubs, events',
        target: '/users/${info.id}/profile'
      };
    },
    computed: {
      ...mapGetters(['searchResult']),
      page() {
        const path = this.$route.path;
        if (path === '/home') {
          return 'home';
        } else if (/\/profile\/*/.test(path)) {
          return 'profile';
        } else if (path === '/calendar') {
          return 'calendar';
        } else if (/\/messages/.test(path)) {
          return 'messages';
        } else if (path === '/network') {
          return 'network';
        } else if (/\/users\/\d+\/profile/.test(path)) {
          return 'profile';
        } else if (path === '/scouting/report/create') {
          return 'scouting/report/create';
        } else if (path === '/scouting/report/marketplace') {
          return 'scouting/scouting/report/marketplace';
        } else if (path === '/scouting/jobs/list') {
          return 'scouting/jobs/list';
        } else if (/\/scouting/.test(path)) {
          return 'scouting/report/';
        }
        return 'home';
      },
    },
    methods: {
      ...mapActions(['getSearchResults']),
      action(info) {}
    },
  };
</script>
