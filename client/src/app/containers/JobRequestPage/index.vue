<template>
<div class="ft-page">
  <div class="container">
    <h3 class="spaced-title upper-cased main-color page-title mb-5">
      <span>Reports</span>
    </h3>


    <actions v-if="page == 'index'" class="widget" v-on:update:val="page = $event" />
    <jobrequestwidget v-if="page == 'index'" :listRequest="listRequest" :getRequests="search" :update="customUpdateRequest" />
    <playerjobrequest v-if="page == 'player'" :submit="customCreateRequest" :serverErrors="serverErrors" :cancelAction="cancel" />
    <positionjobrequest v-if="page == 'position'" :submit="customCreateRequest" :serverErrors="serverErrors" :cancelAction="cancel" />
    <teamjobrequest v-if="page == 'team'" :submit="customCreateRequest" :serverErrors="serverErrors" :cancelAction="cancel" />
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
  import NotificationSidebar from 'app/components/NotificationSidebar';
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
  import PlayerJobRequest from 'app/components/EditRequest/PlayerJobRequest';
  import PositionJobRequest from 'app/components/EditRequest/PositionJobRequest';
  import TeamJobRequest from 'app/components/EditRequest/TeamJobRequest';

  export default {
    name: 'JobRequestPage',
    props: ['type'],
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
        page: this.type ? this.type : 'index',
        loading: false,
        serverErrors: null,
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
          this.serverErrors = this.request.errors;
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
          id,
          request
        });
      },
      cancel() {
        this.page = 'index';
      }
    }
  };
</script>
