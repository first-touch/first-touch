<template>
  <div class="ft-page container">
    <h4 class="spaced-title upper-cased main-color page-title mb-5">Assignments</h4>
    <actions @select="handleActionSelection" />
    <requests-list ref="requestList"/>

    <ft-dialog :visible.sync="dialogVisible" class="request-dlg">
      <div slot="title">
        <span>Request <span class="capitalize">{{ reportType }}</span> Report</span>
      </div>

      <ft-loading size="small" v-if="loadingRequest" class="mx-auto" />

      <div v-if="reportType != ''">

        <component
          :is="reportTypeComponent"
          :edit="requestModel"
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

import FtLoading from 'app/components/Loading';
import { ASYNC_LOADING } from '../../constants/AsyncStatus';

export default {
  name: 'reports-page',
  components: {
    RequestsList,
    Actions,
    PlayerRequestForm,
    PositionRequestForm,
    TeamRequestForm,
    FtLoading
  },
  data() {
    return {
      dialogVisible: false,
      requestModel: null
    }
  },
  computed:{
    ...mapGetters(['request']),

    loadingRequest() {
      return this.request.status == ASYNC_LOADING
    },
    reportType() {
      if (this.requestModel && this.requestModel.type_request){
        return this.requestModel.type_request;
      }
      return "";
    },
    reportTypeComponent() {
      return this.reportType + "-request-form";
    },
  },
  watch: {
    $route: {
        immediate: true,
        handler: function(to, from){
          if (to.name == "editRequest"){
            this.loadRequest(to.params.id);
          }
        }
      },
    dialogVisible: function(to, from){
      if (!to && to != from){
        this.gotoRequestList();
      }
    }
  },
  methods:{
    ...mapActions(['getRequest','getRequests', 'createRequest', 'updateRequest']),

    handleActionSelection(action_name){
      this.requestModel = null;

      this.$nextTick(() => {
        this.requestModel = { type_request: action_name }
        this.dialogVisible = true;
      })
    },
    async handleFormSubmit(request){
      console.log(request);
      var result;

      if (request.id != null){
        result = await this.updateRequest({ id: request.id, request });
      } else {
        result = await this.createRequest(request);
      }

      if (result != null){
        this.dialogVisible = false;
        this.$refs.requestList.search();
        this.gotoRequestList();
      }
    },
    handleFormCancel(){
      this.dialogVisible = false;
      this.gotoRequestList();
    },
    async loadRequest(request_id){
      if (!request_id) return;

      this.requestModel = null;
      this.$nextTick(() => {
        this.dialogVisible = true;
      })

      await this.getRequest(request_id);
      this.requestModel = this.request.value;
    },
    gotoRequestList(){
      this.$router.push({ name: "requestList" });

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
