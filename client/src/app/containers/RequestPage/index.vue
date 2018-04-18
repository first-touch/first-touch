<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <div v-if="value != null" class="report-div">
          <playerjobrequest v-if="show == 'player'" :submit="customUpdateRequest" :errors="errors" :edit="value" :cancelAction="cancel"/>
          <positionjobrequest v-if="show == 'position'" :submit="customUpdateRequest" :errors="errors" :edit="value" :cancelAction="cancel"/>
          <teamjobrequest v-if="show == 'team'" :submit="customUpdateRequest" :errors="errors" :edit="value" :cancelAction="cancel"/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import PlayerJobRequest from 'app/components/EditRequest/PlayerJobRequest.vue';
import PositionJobRequest from 'app/components/EditRequest/PositionJobRequest.vue';
import TeamJobRequest from 'app/components/EditRequest/TeamJobRequest.vue';

export default {
  name: 'ReportPage',
  components: {
    sidebar: NotificationSidebar,
    playerjobrequest: PlayerJobRequest,
    positionjobrequest: PositionJobRequest,
    teamjobrequest: TeamJobRequest
  },
  data () {
    return {
      errors: '',
      value: {},
      show: '',
      update: false
    };
  },
  computed: {
    ...mapGetters(['request'])
  },
  watch: {
    request () {
      if (this.request.status === ASYNC_SUCCESS) {
        this.show = this.show === '' ? this.request.value.type_request : this.show;
        this.value = this.request.value;
        if (this.update) {
          this.$router.push({ name: 'clubRequestList'}); // -> /user/123router.push({
        }
      }
    }
  },
  mounted () {
    this.getRequest(this.$route.params.id);
  },
  methods: {
    ...mapActions(['getRequest', 'updateRequest']),
    customUpdateRequest (request) {
      this.update = true;
      this.updateRequest({
        id: this.$route.params.id,
        request
      });
    },
    cancel () {
      this.$router.push({ name: 'clubRequestList' }); // -> /user/123router.push({
    }
  }
};
</script>
