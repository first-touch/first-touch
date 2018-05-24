<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <actions v-if="page == 'index'" class="widget" v-on:update:val="page = $event" />
        <jobrequestwidget v-if="page == 'index'" :listRequest="listRequest" :getRequests="search" :update="customUpdateRequest" />
        <playerjobrequest v-if="page == 'player'" :submit="customCreateRequest" :errors="errors" :cancelAction="cancel" />
        <positionjobrequest v-if="page == 'position'" :submit="customCreateRequest" :errors="errors" :cancelAction="cancel" />
        <teamjobrequest v-if="page == 'team'" :submit="customCreateRequest" :errors="errors" :cancelAction="cancel" />
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .widget {
    margin-bottom: 20px;
  }
</style>
<script>
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS,
    ASYNC_FAIL,
    ASYNC_LOADING
  } from 'app/constants/AsyncStatus';
  import Actions from './components/Actions';
  import JobRequestWidget from './components/JobRequestWidget';
  import PlayerJobRequest from 'app/components/EditRequest/PlayerJobRequest.vue';
  import PositionJobRequest from 'app/components/EditRequest/PositionJobRequest.vue';
  import TeamJobRequest from 'app/components/EditRequest/TeamJobRequest.vue';

  export default {
    name: 'MyPurchasedReports',
    components: {
      sidebar: NotificationSidebar,
      jobrequestwidget: JobRequestWidget,
      playerjobrequest: PlayerJobRequest,
      positionjobrequest: PositionJobRequest,
      teamjobrequest: TeamJobRequest,
      actions: Actions
    },
    data() {
      return {
        page: 'index',
        loading: false,
        errors: null,
        listRequest: [],
        params: ''
      };
    },
    computed: {
      ...mapGetters(['searchRequest', 'request'])
    },
    watch: {
      searchRequest() {
        if (this.searchRequest.status === ASYNC_SUCCESS) {
          this.listRequest = this.searchRequest.value.request;
        }
      },
      request() {
        if (this.request.status === ASYNC_SUCCESS) {
          this.page = 'index';
          this.search(this.params);
        } else if (this.request.status === ASYNC_FAIL) {
          this.errors = this.request.errors;
        } else if (this.request.status === ASYNC_LOADING) {
          this.loading = true;
        }
      }
    },
    methods: {
      ...mapActions(['getRequests', 'createRequest', 'updateRequest']),
      customCreateRequest(request) {
        this.createRequest(request);
      },
      search(params) {
        this.params = params;
        this.getRequests(this.params);
      },
      customUpdateRequest(id, request) {
        this.updateRequest({
          id: id,
          request
        });
      },
      cancel() {
        this.page = 'index';
      }
    }
  };
</script>
