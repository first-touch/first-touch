<template>
  <div class="container ft-page">
    <h4 class="spaced-title upper-cased main-color page-title mb-5">My network</h4>
    <timeline-item>
      <div class="row network-filters justify-content-center mb-4">
        <div class="col-xl-6 ml-auto mr-auto">
          <select class="form-control network-widget-sort" v-model="role">
            <option value="">All Roles</option>
            <option value="agent">Agent</option>
            <option value="director">Director</option>
            <option value="player">Player</option>
            <option value="scout">Scout</option>
          </select>
        </div>
        <div class="col-xl-6 ml-auto mr-auto">
          <input type="text" class="form-control network-widget-search" placeholder="Type a name" v-model="searchTerm" @keyup.prevent="filterNetwork()" />
        </div>
      </div>
      <div class="row network-container justify-content-center">
        <div class="col-xl-12" v-if="loading">
          <h4 class="text-center">Loading...</h4>
        </div>
        <div class="col-xl-12">
          <network-item v-for="item in items"
              :info="item"
              :key="item.id" />
        </div>
      </div>
    </timeline-item>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_LOADING, ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import TimelineItem from 'app/components/TimelineItem';
import NetworkItem from './components/NetworkItem';

export default {
  name: 'Network',
  components: {
    TimelineItem,
    NetworkItem
  },
  data() {
    return {
      role: '',
      searchTerm: ''
    };
  },
  computed: {
    ...mapGetters(['network']),
    loading() {
      return this.network.status === ASYNC_LOADING;
    },
    items() {
      return this.network.value || [];
    },
  },
  methods: {
    ...mapActions(['getNetwork', 'unfollow']),
    filterNetwork() {
      this.getNetwork({
        name: this.searchTerm,
        role: this.role
      })
    }
  },
  mounted() {
    this.filterNetwork();
  },
  watch: {
    role: function() {
      this.filterNetwork();
    }
  }
};
</script>
