<template>
  <div>
    <navbar :page="page" />
    <search-bar :search="getSearchResults" :results="searchResult.value"/>
    <router-view></router-view>
  </div>
</template>

<style lang="scss">
@import '~stylesheets/variables';
@import '~stylesheets/common_style';
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import Navbar from './components/UserNavbar';
import SearchBar from '../SearchBar';

export default {
  name: 'UserLayout',
  components: {
    navbar: Navbar,
    'search-bar': SearchBar,
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
      } else if (path === '/notes') {
        return 'notes';
      }

      return 'home';
    },
  },
  methods: {
    ...mapActions(['getSearchResults']),
  },
};
</script>