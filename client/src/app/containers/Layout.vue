<template>
  <div>
    <navbar :page="page" />
    <search-bar :search="search" :results="results"/>
    <router-view></router-view>
  </div>
</template>

<style lang="sass">
  @import "~stylesheets/variables";
  @import "~stylesheets/common_style";
</style>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import AppNavbar from '../components/AppNavbar.vue';
  import SearchBar from '../components/SearchBar.vue';

  export default {
    name: 'Layout',
    components: {
      'navbar': AppNavbar,
      'search-bar': SearchBar
    },
    data() {
      return {
        results: []
      }
    },
    computed: {
      ...mapGetters(['token']),
      page() {
        const path = this.$route.path;
        if (path === '/home') {
          return 'home';
        } else if (/\/profile\/*/.test(path)) {
          return 'profile';
        } else if (path === '/calendar') {
          return 'calendar';
        } else if (path === '/messages') {
          return 'messages';
        } else if (path === '/network') {
          return 'network';
        } else if (/\/users\/\d+\/profile/.test(path)) {
          return 'profile';
        }

        return "home";
      }
    },
    methods: {
      search(searchTerm) {
        if (searchTerm === '') {
          return this.$set(this, "results", []);
        };
        fetch(`/api/v1/search?q=${searchTerm}`, {
          method: 'GET',
          headers: { 'Authorization': this.token.value }
        }).then((res) => {
          res.status === 200 && res.json().then(
            (r) => this.$set(this, "results", r.users)
          );
        });
      }
    }
  }
</script>