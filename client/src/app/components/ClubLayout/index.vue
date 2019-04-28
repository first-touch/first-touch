<template>
  <div>
    <navbar :page="page" class="club-sidebar"/>
    <div class="content">
      <search-bar :search="getSearchResults" :results="searchResult.value" :placeholder="placeholder" :action="action"/>
      <router-view></router-view>
    </div>
  </div>
</template>
<style lang="scss">
@import '~stylesheets/variables';
@import '~stylesheets/common_style';

.club-sidebar + .content {
  padding-left: calc(#{$navbar-width} + 10px);
}
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
  data() {
    return {
      placeholder: 'Search for players, clubs, events'
    };
  },
  computed: {
    ...mapGetters(['searchResult']),
    page() {
      return this.$route.path.replace(/\/club\/\d\/?/, '');
    },
  },
  methods: {
    ...mapActions(['getSearchResults']),
    action(info){
    }
  },
};
</script>
