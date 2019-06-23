<template>
  <div class="ft-page container">
    <h4 class="spaced-title upper-cased main-color page-title mb-5">Create Report</h4>
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
            <playerreportform v-if="report_type == 'Player' && status == '' " :hasBankAccount="hasBankAccount" :submitReport="customCreateReport"
              :playerId="player_id" :request="request" :cancelAction="cancel" />
            <teamreportform v-if="report_type == 'Team' && status == '' " :category="category" :hasBankAccount="hasBankAccount" :submitReport="customCreateReport"
              :team_id="team_id" :cancelAction="cancel" :request="request" />
          </keep-alive>
        </div>
      </div>
    </timeline-item>
  </div>
</template>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS,
    ASYNC_LOADING
  } from 'app/constants/AsyncStatus';

  import PlayerReportForm from 'app/components/EditReport/PlayerReportForm';
  import TeamReportForm from 'app/components/EditReport/TeamReportForm';
  import Status from './components/Status';
  import ReportTypeForm from './components/ReportTypeForm';
  import TimelineItem from 'app/components/TimelineItem';
  import PlayerRequestPopup from 'app/components/RequestPopup/PlayerRequestPopup';
  import PositionRequestPopup from 'app/components/RequestPopup/PositionRequestPopup';
  import TeamRequestPopup from 'app/components/RequestPopup/TeamRequestPopup';
  import PlayerResume from 'app/components/ProfileResume/PlayerResume';
  import ClubResume from 'app/components/ProfileResume/ClubResume';

  export default {
    name: 'CreateReportPage',
    props: ['request'],
    components: {
      playerreportform: PlayerReportForm,
      teamreportform: TeamReportForm,
      status: Status,
      basicform: BasicForm,
      TimelineItem,
      teamrequestpopup: TeamRequestPopup,
      playerrequestpopup: PlayerRequestPopup,
      positionrequestpopup: PositionRequestPopup,
      clubresume: ClubResume,
      playerresume: PlayerResume
    },
    computed: {
      ...mapGetters(['report', 'searchResult', 'profile', 'teamProfile', 'user']),
      playerInfo() {
        if (this.request)
          return this.request.player;
        if (this.player_id > 0 && this.profile.status == ASYNC_SUCCESS)
          return this.profile.value.personal_profile;
        return null;
      },
      position() {
        if (this.request)
          return this.request.type_request == 'position';
        return false
      },
      clubInfo() {
        if (!this.playerInfo && this.team_id > 0 && this.teamProfile.status == ASYNC_SUCCESS)
          return this.teamProfile.value;
        return null;
      },
      hasBankAccount() {
        if (this.user.status === ASYNC_SUCCESS) {
          return (this.user.value.has_bank_account)
        }
        if (this.user.status === ASYNC_LOADING) {
          return true;
        }
        return false;
      }
    },
    watch: {
      report() {
        this.status = '';
        if (this.report.status === ASYNC_SUCCESS) {
          this.$router.push({
            name: 'scoutReportView',
            params: {
              id: this.report.value.id
            }
          });
        } else if (this.report.status === ASYNC_LOADING) {
          this.status = 'reportUploading';
        } else if (this.report.status === ASYNC_LOADING) {
          this.status = 'reportUploadingFailure';
        }
      }
    },
    mounted() {
      if (this.request) {
        var ids = {
          player: this.request.player_id,
          team: this.request.team_id,
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
      ...mapActions(['createReport', 'uploadFiles', 'getSearchResults', 'fetchUserInfo', 'fetchTeamInfo']),
      toPaymentPage() {
        this.$router.push({
          name: 'scoutPaymentDetailPage',
        });
      },
      cancel() {
        this.report_type = null;
        this.showForm = false;
      },
      prepareReport(type, ids, search) {
        this.report_type = type;
        this.job_id = ids.job;
        this.player_id = ids.player;
        this.team_id = ids.team;
        this.category = ids.category;
        this.search = search;
        this.showForm = true;
        if (this.player_id > 0)
          this.fetchUserInfo({
            id: this.player_id
          })
        if (this.team_id > 0)
          this.fetchTeamInfo({
            id: this.team_id
          })
      },
      customCreateReport(reportdata) {
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
        showForm: false,
        category: ''
      };
    }
  };
</script>
