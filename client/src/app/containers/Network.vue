<template>
  <div>
    <navbar page="network" />
    <div class="container-fluid">
      <div class="network">
        <h4 class="network-header">MY NETWORK</h4>
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

  .container-fluid {
    margin: 0 20vw 0 18vw;
    background-color: $navbar-background-color;
    min-height: calc(100vh - 119px);
    padding: 20px;
  }

  .network {
    &:before {
      content: "";
      position: absolute;
      left: 20px;
      margin-top: -15px;
      width: 10%;
      border-top: 5px solid $secondary-header-color;
    }
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
  import NetworkItem from '../components/NetworkItem.vue';

  export default {
    name: 'Network',
    components: {
      'navbar': AppNavbar,
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