<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <div v-if="request">
          <h4 class="header">Request</h4>
          <timeline-item>
            <request :key="request.id" :request="request" :viewSummary="viewSummary" class="onlyone"></request>
            <b-modal id="metaModal" size="lg" ref="metaModal">
              <div>
                <playerrequestpopup v-if="request.type_request == 'player' " :request="request" :closeAction="closeAction" />
                <teamrequestpopup v-if="request.type_request == 'team' " :request="request" :closeAction="closeAction" />
                <positionrequestpopup v-if="request.type_request == 'position' " :request="request" :closeAction="closeAction" />
              </div>
            </b-modal>
          </timeline-item>
        </div>
        <h4 class="header">Create Report</h4>
        <timeline-item>
          <div class="form-container">
            <status :status="status" />
            <ul class="error" v-if="report.errors">
              <li v-for="(error, key) in report.errors.errors" v-bind:key="error.id">
                {{ key }}:
                <span class="error-field" v-for="reason in error" :key="reason.id">{{ reason }}</span>
              </li>
            </ul>
            <basicform class="report-type-form" v-if="!showForm" :prepareReport="prepareReport" />
            <div v-if="showForm">
              <keep-alive>
                <playerreportform v-if="report_type == 'player' && status == '' " :submitReport="customCreateReport" :playerEditable="player_id == ''"
                   :request="request" :cancelAction="cancel" />
                <clubreportform v-if="report_type == 'team' && status == '' " :submitReport="customCreateReport" :team_id="team_id" :cancelAction="cancel"
                  :request="request" />
              </keep-alive>
            </div>
          </div>
        </timeline-item>
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

.onlyone {
  border-top: 0 !important;
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
import TimelineItem from 'app/components/TimelineItem';
import RequestItem from 'app/components/RequestItem';
import PlayerRequestPopup from 'app/components/RequestPopup/PlayerRequestPopup';
import PositionRequestPopup from 'app/components/RequestPopup/PositionRequestPopup';
import TeamRequestPopup from 'app/components/RequestPopup/TeamRequestPopup';

export default {
  name: 'CreateReportPage',
  props: ['request'],
  components: {
    sidebar: NotificationSidebar,
    playerreportform: PlayerReportForm,
    clubreportform: ClubReportForm,
    status: Status,
    basicform: BasicForm,
    'timeline-item': TimelineItem,
    request: RequestItem,
    teamrequestpopup: TeamRequestPopup,
    playerrequestpopup: PlayerRequestPopup,
    positionrequestpopup: PositionRequestPopup
  },
  computed: {
    ...mapGetters(['report', 'searchResult', 'filesUpload']),
  },
  watch: {
    report() {
      this.status = '';
      if (this.report.status === ASYNC_SUCCESS) {
        if (this.files.length > 0) {
          this.startUpload();
        } else {
          this.$router.push({
            name: 'scoutReportView',
            params: {
              id: this.report.value.id
            }
          });
        }
      } else if (this.report.status === ASYNC_LOADING) {
        this.status = 'reportUploading';
      } else if (this.report.status === ASYNC_LOADING) {
        this.status = 'reportUploadingFailure';
      }
    },
    filesUpload() {
      if (this.filesUpload.status === ASYNC_SUCCESS) {
        this.$router.push({
          name: 'scoutReportView',
          params: {
            id: this.report.value.id
          }
        });
      } else if (this.filesUpload.status === ASYNC_LOADING) {
        this.status = 'filesUploading';
      } else if (this.filesUpload.status === ASYNC_LOADING) {
        this.status = 'filesUploadingFailure';
        setTimeout(() => {
          this.$router.push({
            name: 'scoutReportEdit',
            params: {
              id: this.report.value.id
            }
          });
        }, 3000);
      }
    }
  },
  mounted() {
    if (this.request) {
    var ids = {
        player: this.request.player_id,
        team:  this.request.team_id,
        job: this.request.id,
        league: this.request.league_id
      }
      if (this.request.type_request == 'team')
        this.prepareReport('team', ids);
      else if (this.request.type_request == 'player')
        this.prepareReport('player', ids);
      else if (this.request.type_request == 'position')
        this.prepareReport('player', ids);
    }
  },
  methods: {
    ...mapActions(['createReport', 'uploadFiles', 'getSearchResults']),
    cancel() {
      this.showForm = false;
    },
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
    prepareReport(type, ids, search) {
      this.report_type = type;
      this.job_id = ids.job;
      this.player_id = ids.player;
      this.team_id = ids.team;
      this.search = search;
      this.showForm = true;
    },
    customCreateReport(reportdata, filelist) {
      this.files = filelist;
      reportdata.type_report = this.report_type;
      reportdata.player_id = this.player_id;
      reportdata.team_id = this.team_id;
      reportdata.job_id = this.job_id;
      reportdata.meta_data.search = this.search;
      this.createReport(reportdata);
    },
    closeAction(request) {
      this.$refs.metaModal.hide();
    },
    viewSummary(request) {
      this.$refs.metaModal.show();
    }
  },
  data() {
    return {
      status: '',
      report_type: '',
      job_id: '',
      team_id: '',
      league_id: '',
      player_id: '',
      search: {},
      showForm: false
    };
  }
};
</script>
