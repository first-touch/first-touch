<template>
  <div class="ft-page container">
    <h4 class="spaced-title upper-cased main-color page-title mb-5">Report Requests</h4>
    <actions @select="handleActionSelection" />
    <requests-list />

    <ft-dialog :visible.sync="requestDialogVisible" width="80vw">
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
      reportType: ""
    }
  },
  computed:{
    reportTypeComponent() {
      return this.reportType + "-request-form";
    },
  },
  methods:{
    ...mapActions(['getRequests', 'createRequest', 'updateRequest']),

    handleActionSelection(action_name){
      this.reportType = action_name;
      this.requestDialogVisible = true;
    },

    async handleFormSubmit(request){
      console.log(request);
      const result = await this.createRequest(request);

      if (result != null){
        this.requestDialogVisible = false;
      }
    },
    handleFormCancel(){
      this.requestDialogVisible = false;
    }
  }
}
</script>
