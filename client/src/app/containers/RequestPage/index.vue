<template>
  <div>
    <!-- <sidebar /> -->
    <div class="container-fluid">
      <div class="ft-page">
        <div v-if="value != null" class="report-div">
          <playerjobrequest v-if="show == 'player'" :submit="customUpdateRequest" :serverErrors="serverErrors" :edit="value" :cancelAction="cancel"
          />
          <positionjobrequest v-if="show == 'position'" :submit="customUpdateRequest" :serverErrors="serverErrors" :edit="value" :cancelAction="cancel"
          />
          <teamjobrequest v-if="show == 'team'" :submit="customUpdateRequest" :serverErrors="serverErrors" :edit="value" :cancelAction="cancel"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS
  } from 'app/constants/AsyncStatus';
  import NotificationSidebar from 'app/components/NotificationSidebar';
  import PlayerJobRequest from 'app/components/EditRequest/PlayerJobRequest';
  import PositionJobRequest from 'app/components/EditRequest/PositionJobRequest';
  import TeamJobRequest from 'app/components/EditRequest/TeamJobRequest';

  export default {
    name: 'ReportPage',
    components: {
      sidebar: NotificationSidebar,
      playerjobrequest: PlayerJobRequest,
      positionjobrequest: PositionJobRequest,
      teamjobrequest: TeamJobRequest
    },
    data() {
      return {
        serverErrors: '',
        value: {},
        show: '',
        update: false
      };
    },
    computed: {
      ...mapGetters(['request'])
    },
    watch: {
      request() {
        if (this.request.status === ASYNC_SUCCESS) {
          this.show = this.show === '' ? this.request.value.type_request : this.show;
          this.value = this.request.value;
          if (this.update) {
            if (document.referrer)
              this.$router.go(-1);
            else
              this.$router.push({
                name: 'clubRequestList'
              });
          }
        }
      }
    },
    mounted() {
      this.getRequest(this.$route.params.id);
    },
    methods: {
      ...mapActions(['getRequest', 'updateRequest']),
      customUpdateRequest(request) {
        this.update = true;
        this.updateRequest({
          id: this.$route.params.id,
          request
        });
      },
      cancel() {
        if (document.referrer)
          this.$router.go(-1);
        else {
          this.$router.push({
            name: 'clubRequestList'
          });
        }
      }
    }
  };
</script>
