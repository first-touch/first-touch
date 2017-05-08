<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page network">
        <h4 class="header">My network</h4>
        <div class="network-widget">
          <select class="network-widget-sort">
            <option disabled selected value>Sort by</option>
            <option value="name">Name</option>
            <option value="club">Club</option>
          </select>
          <input type="text" class="network-widget-search" placeholder="Type a name" />
        </div>
        <div class="network-container">
          <div v-if="loading">
            <h4 class="text-center">Loading...</h4>
          </div>
          <network-item v-for="item in items"
            :info="item"
            :unfollow="unfollow.bind(this, { token: token.value, id: item.id })"/>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
 @import "~stylesheets/variables";
 @import "~stylesheets/common_style";

 .network {
     .network-widget {
         display: flex;
         flex-wrap: wrap;
         justify-content: space-between;
         .network-widget-sort, .network-widget-search {
             flex: 0 0 48%;
             border: 1px solid #fff;
             background-color: $navbar-background-color;
             color: #fff;
             padding: 2px 7px;

         }
         .network-widget-search {
             border-radius: 4px;
         }
     }
     .network-container {
         display: flex;
         flex-wrap: wrap;
         justify-content: space-between;
     }
 }
</style>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import store from '../store';
  import { ASYNC_LOADING, ASYNC_SUCCESS } from '../constants/AsyncStatus';

  import AppNavbar from '../components/AppNavbar.vue';
  import NotificationSidebar from '../components/NotificationSidebar.vue';
  import NetworkItem from '../components/NetworkItem.vue';

  export default {
    name: 'Network',
    components: {
      'navbar': AppNavbar,
      'sidebar': NotificationSidebar,
      'network-item': NetworkItem
    },
    computed: {
      ...mapGetters(['token', 'network']),
      loading() { return this.network.status === ASYNC_LOADING; },
      items() { return this.network.value || []; }
    },
    methods: {
      ...mapActions(['getNetwork', 'unfollow'])
    },
    mounted() {
      this.getNetwork({ token: this.token.value });
    }
  }
</script>
