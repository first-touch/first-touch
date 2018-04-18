<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h4 class="header">Create Report</h4>
        <div class="form-container">
          <status :status="status" />
          <ul class="error" v-if="report.errors">
            <li v-for="(error) in report.errors.error" v-bind:key="error.id">
              {{ error }}
            </li>
          </ul>
          <basicform class="report-type-form" v-if="!showForm" :prepateReport="prepateReport" />
          <div v-if="showForm">
            <keep-alive>
              <playerreportform v-if="report_type == 'player' && status == '' " :player_info="player_info" :submitReport="customCreateReport" :cancelAction="cancel"
              />
              <clubreportform v-if="report_type == 'team' && status == '' " :submitReport="customCreateReport" :cancelAction="cancel"/>
            </keep-alive>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
/* global styles */

.report-type-form {
  .searchbar-top.search-bar-report {
    input {
      all: unset;
    }
    all: unset;
    .input-group-btn {
      display: none;
    }
  }
}
</style>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.error {
  li {
    color: red;
    display: list-item;
    list-style: disc;
    &:first-letter {
      text-transform: capitalize;
    }
  }
}
.form-container {
  background-color: $form-background;
  border-radius: 5px;
  padding: 20px;
  width: 100%;
}
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS, ASYNC_LOADING } from 'app/constants/AsyncStatus';
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import PlayerReportForm from 'app/components/EditReport/PlayerReportForm.vue';
import ClubReportForm from 'app/components/EditReport/ClubReportForm.vue';
import Status from './components/Status';
import BasicForm from './components/BasicForm';

export default {
  name: 'CreateReportPage',
  components: {
    sidebar: NotificationSidebar,
    playerreportform: PlayerReportForm,
    clubreportform: ClubReportForm,
    status: Status,
    basicform: BasicForm
  },
  computed: {
    ...mapGetters(['report', 'searchResult', 'profile', 'filesUpload']),
    player_info() {
      return this.profile.status === ASYNC_SUCCESS ? this.profile.value.personal_profile : {};
    }
  },
  watch: {
    report() {
      this.status = '';
      if (this.report.status === ASYNC_SUCCESS) {
        if (this.files.length > 0) {
          this.startUpload();
        } else {
          this.$router.push({ name: 'scoutReportView', params: { id: this.report.value.id } }); // -> /user/123router.push({
        }
      } else if (this.report.status === ASYNC_LOADING) {
        this.status = 'reportUploading';
      } else if (this.report.status === ASYNC_LOADING) {
        this.status = 'reportUploadingFailure';
      }
    },
    filesUpload() {
      if (this.filesUpload.status === ASYNC_SUCCESS) {
        this.$router.push({ name: 'scoutReportView', params: { id: this.report.value.id } }); // -> /user/123router.push({
      } else if (this.filesUpload.status === ASYNC_LOADING) {
        this.status = 'filesUploading';
      } else if (this.filesUpload.status === ASYNC_LOADING) {
        this.status = 'filesUploadingFailure';
        setTimeout(() => {
          this.$router.push({ name: 'scoutReportEdit', params: { id: this.report.value.id } }); // -> /user/123router.push({
        }, 3000);
      }
    }
  },
  methods: {
    ...mapActions(['createReport', 'fetchUserInfo', 'uploadFiles', 'getSearchResults']),
    cancel() {},
    startUpload() {
      var formData = new FormData();
      var fileList = this.files;
      var i = 0;
      $.each(fileList, function(index, value) {
        formData.append('files[' + i + ']', value);
        i++;
      });
      formData.append('report_id', this.report.value.id);
      this.uploadFiles(formData);
    },
    prepateReport(type, player_id, team_id, job_id) {
      this.report_type = type;
      this.player_id = player_id;
      this.team_id = team_id;
      this.job_id = job_id;
      this.showForm = true;
      if (type == 'player') {
        this.fetchUserInfo({
          id: this.player_id
        });
      }
    },
    customCreateReport(reportdata, filelist) {
      this.report.errors = null;
      this.files = filelist;
      reportdata.type_report = this.report_type;
      reportdata.status = 'publish';
      reportdata.player_id = this.player_id;
      reportdata.team_id = this.team_id;
      this.createReport(reportdata);
    }
  },
  data() {
    return {
      status: '',
      report_type: '',
      job_id: '',
      team_id: '',
      player_id: '',
      showForm: false
    };
  }
};
</script>
