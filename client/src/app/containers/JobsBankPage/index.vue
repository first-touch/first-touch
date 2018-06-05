<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <jobrequestwidget v-if="page == 'index'" :user="user" :listRequest="listRequest" :getRequests="search" :createBid="createBid" :bid="bidSuccess" :clearBid="clearBid"
        :updateBid="updateBid"
        />
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
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS, ASYNC_FAIL, ASYNC_LOADING } from 'app/constants/AsyncStatus';
import JobRequestWidget from './components/JobRequestWidget';

export default {
  name: 'MyPurchasedReports',
  components: {
    sidebar: NotificationSidebar,
    jobrequestwidget: JobRequestWidget
  },
  data() {
    return {
      page: 'index',
      loading: false,
      serverErrors: null,
      listRequest: [],
      params: ''
    };
  },
  computed: {
    ...mapGetters(['searchRequest', 'request', 'bid','user']),
    bidSuccess() {
      if (this.bid.status == ASYNC_SUCCESS) {
        return true;
      }
      return false;
    }
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
    ...mapActions(['getRequests', 'createBid','clearBid','updateBid']),
    search(params) {
      this.params = params;
      this.getRequests(this.params);
    },
    cancel() {
      this.page = 'index';
    }
  }
};
</script>
