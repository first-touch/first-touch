<template>
  <div>
    <navbar :page="page" />
    <search-bar :search="getSearchResults" :results="searchResult.value" />
    <router-view></router-view>
  </div>
</template>
<style lang="scss">
@import '~stylesheets/variables';
@import '~stylesheets/common_style';
</style>
<script>
import { mapGetters, mapActions } from 'vuex';
import Navbar from './components/ClubNavbar';
import SearchBar from '../SearchBar';

export default {
  name: 'ClubLayout',
  components: {
    navbar: Navbar,
    'search-bar': SearchBar,
  },
  computed: {
    ...mapGetters(['searchResult']),
    page() {
      return this.$route.path.replace(/\/club\/?/, '');
    },
  },
  methods: {
    ...mapActions(['getSearchResults']),
  },
};
</script>