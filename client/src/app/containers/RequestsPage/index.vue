<template>
  <div class="ft-page container">
    <h4 class="spaced-title upper-cased main-color page-title mb-5">Report Requests</h4>
    <actions @select="handleActionSelection" />
    <requests-list ref="requestList"/>

    <ft-dialog :visible.sync="requestDialogVisible" class="request-dlg">
      <div slot="title">
        <span>Request <span class="capitalize">{{ reportType }}</span> Report</span>
      </div>

      <div v-if="reportType != ''">
        <component
          :is="reportTypeComponent"
          @submit="handleFormSubmit"
          @cancel="handleFormCancel"
        ></component>
      </div>
    </ft-dialog>
  </div>
</template>

<script>
import {
    mapGetters,
    mapActions
} from 'vuex';

import Actions from "./components/RequestActions.vue"
import RequestsList from "./components/RequestsList.vue"

import PlayerRequestForm from 'app/components/ReportRequests/PlayerRequestForm.vue';
import PositionRequestForm from 'app/components/ReportRequests/PositionRequestForm.vue';
import TeamRequestForm from 'app/components/ReportRequests/TeamRequestForm.vue';

export default {
  name: 'reports-page',
  components: {
    RequestsList,
    Actions,
    PlayerRequestForm,
    PositionRequestForm,
    TeamRequestForm
  },
  data() {
    return {
      requestDialogVisible: false,
      reportType: "",
      requestModel: null
    }
  },
  computed:{
    reportTypeComponent() {
      return this.reportType + "-request-form";
    },
  },
  methods:{
    ...mapActions(['getRequest','getRequests', 'createRequest', 'updateRequest']),

    handleActionSelection(action_name){
      this.reportType = action_name;
      this.requestDialogVisible = true;
    },

    async handleFormSubmit(request){
      console.log(request);
      const result = await this.createRequest(request);

      if (result != null){
        this.requestDialogVisible = false;

        this.$refs.requestList.search();
      }
    },
    handleFormCancel(){
      this.requestDialogVisible = false;
    },
    async loadRequest(request_id){
      if (!request_id) return;

      this.requestModel = await this.getRequest(request_id);
      console.log(this.requestModel);
      debugger;
    }
  },
  watch: {
    $route: {
        immediate: true,
        handler: function(to, from){
          console.log(to);
          if (to.name == "editRequest"){
            this.loadRequest(to.params.id);
          }
        }
      }
  }
}
</script>


<style lang="scss">
@import "~bootstrap/scss/functions";
@import "~bootstrap/scss/variables";
@import '~stylesheets/variables';
@import "~bootstrap/scss/mixins/_breakpoints";

@include media-breakpoint-up(md) {
  .request-dlg .ft-dialog {
    width: 80vw !important;
  }
}
</style>
