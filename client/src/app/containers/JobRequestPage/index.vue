<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <div v-if="page == 'index'">
          <div class="header col col-md-12">
            <h5 class="col col-md-3">My Purchased Reports</h5>
            <div class="new-request col col-md-9">
              <button class="btn-info" @click="page = 'player'">CREATE PLAYER JOB REQUESTS</button>
              <button class="btn-info" @click="page = 'team'">CREATE TEAM JOB REQUESTS</button>
              <button class="btn-info" @click="page = 'position'">CREATE JOB REQUEST ON A POSITION</button>
            </div>
          </div>
          <jobrequestwidget :listRequest="listRequest" :getRequests="search" :update="customUpdateRequest" />
        </div>
        <div v-if="page != 'index'" class="request-inner">
          <h5>CREATE {{ page }} JOB REQUEST</h5>

          <playerjobrequest v-if="page == 'player'" :submit="customCreateRequest" :errors="errors" :cancelAction="cancel" />
          <positionjobrequest v-if="page == 'position'" :submit="customCreateRequest" :errors="errors" :cancelAction="cancel" />
          <teamjobrequest v-if="page == 'team'" :submit="customCreateRequest" :errors="errors" :cancelAction="cancel" />
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.request-inner {
  h5 {
    text-transform: uppercase;
  }
}

.header {
  display: block;
  overflow: hidden;
  h5 {
    float: left;
    padding: 10px 0;
    margin: 0;
    text-transform: uppercase;
  }
  .new-request {
    float: right;
    text-align: right;
    button {
      padding: 10px 5px;
      border-radius: 10px;
      cursor: pointer;
      font-size: 0.8em;
    }
  }
}

.widget {
  color: $secondary-text-color;
  background: $div-filter-background;
  padding-left: 10px;
  .widget-content {
    padding: 0 30px 20px 30px;
    form {
      background: white;
      overflow: hidden;
      border: 1px solid black;
      label {
        padding: 0;
        color: black;
      }
    }
    table {
      background: white;
      color: black;
      text-align: center;
      th,
      td {
        border: 1px solid black;
      }
      .actions {
        max-width: 100px;
        text-align: left;
        .action {
          display: block;
          float: left;
          padding: 0;
        }
      }
    }
    .filter {
      float: left;
      label {
        float: left;
      }
      input,
      select {
        float: left;
        height: 2em;
        box-shadow: 1px 0px #000000;
      }
      .datepicker {
        float: left;
      }
      .separator {
        float: left;
        margin: 0 5px;
        font-size: 19px;
        font-weight: 800;
      }
    }
  }
}
</style>
<script>
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS, ASYNC_FAIL, ASYNC_LOADING } from 'app/constants/AsyncStatus';
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
    teamjobrequest: TeamJobRequest
  },
  data () {
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
    searchRequest () {
      if (this.searchRequest.status === ASYNC_SUCCESS) {
        this.listRequest = this.searchRequest.value.request;
      }
    },
    request () {
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
    customCreateRequest (request) {
      this.createRequest(request);
    },
    search (params) {
      this.params = params;
      this.getRequests(this.params);
    },
    customUpdateRequest (id, request) {
      this.updateRequest({
        id: id,
        request
      });
    },
    cancel () {
      this.page = 'index';
    }
  }
};
</script>
