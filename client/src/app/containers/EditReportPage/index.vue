<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page ">
        <div v-if="playerInfo || clubInfo || search">
          <h4 class="header" v-if="player">Player</h4>
          <h4 class="header" v-if="team">Team</h4>
          <playerresume v-if="player" :player="playerInfo" :clubInfo="clubInfo" :search="search"></playerresume>
          <clubresume v-if="team" :clubInfo="clubInfo" :search="search"></clubresume>
        </div>
        <h4 class="header">Edit Report</h4>
        <action-item v-if="reportValue">
          <button class="timeline-widget-button">
            <span>
              <icon name='eye' scale="1.5"></icon>
            </span>
            <router-link :to="{ name: 'scoutReportView', params: { id: reportValue.id }}">View</router-link>
          </button>
          <button class="timeline-widget-button">
            <span>
              <icon name='edit' scale="1.5"></icon>
            </span>
            <router-link :to="{ name: 'scoutReportEdit', params: { id: reportValue.id }}" class="active">Edit</router-link>
          </button>
          <button class="timeline-widget-button button-right" v-if="reportValue.status == 'publish'" @click="updateStatus('private')">
            <span class="unpublish">
              <icon name="eye-slash" scale="1.5"></icon>
            </span>
            <a>Unpublish Report</a>
          </button>
          <button class="timeline-widget-button button-right" v-if="reportValue.status == 'private'" @click="updateStatus('publish')">
            <span class="publish">
              <icon name="eye" scale="1.5"></icon>
            </span>
            <a>Publish Report</a>
          </button>
        </action-item>
        <timeline-item class="report-container" v-if="reportValue">
          <div class="row created_at" v-if="reportValue">
            <label class="col-lg-2">Created On</label>
            <p class="col-lg-10">{{reportValue.created_at | moment}}</p>
          </div>
          <div class="form-container">
            <ul class="error" v-if="report.errors">
              <li v-for="(error) in report.errors.error" v-bind:key="error.id">
                {{ error }}
              </li>
            </ul>
            <playerreportform v-if="player" :submitReport="customUpdateReport" class="report" :report="reportValue" :cancelAction="cancel"
            />
            <teamreportform v-if="team" :submitReport="customUpdateReport" class="report" :report="reportValue" :cancelAction="cancel"
            />
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
</style>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .Loading {
    color: black;
    text-align: center;
    font-size: 20px;
  }

  .error {
    color: red;
  }

  .search-player {
    &:focus~.search-results {
      position: absolute;
      background: white;
      width: 220px;
      z-index: 10;
      display: block;
      overflow: hidden;
      overflow-y: scroll;
      p {
        margin: 0;
        padding: 0;
        cursor: pointer;
        &:hover {
          background: #e6e1e1;
        }
      }
    }
  }

  .search-results {
    display: none;
  }

  .report-container {
    display: flex;
    border-left: 7px solid $main-header-color;
    margin-top: 20px;
  }

  .arrow {
    width: 0;
    height: 0;
    margin-right: 20px;
    border-top: 7px solid transparent;
    border-bottom: 7px solid transparent;
    border-left: 7px solid;
    margin-top: 18px;
    border-left-color: $main-header-color;
  }

  .form-container {
    background-color: $form-background;
    border-radius: 5px;
    width: 100%;
  }

  .report {
    padding: 50px;
  }

  .report-container {
    .created_at {
      color: $main-text-color;
    }
    .menu {
      li {
        display: inline-block;
        &.updateStatus {
          float: right;
          a:hover {
            background: $secondary-header-color;
          }
        }
        a {
          display: block;
          padding: 10px 20px;
          border-radius: 10px;
          &.active,
          &:hover {
            background: $main-header-color;
            cursor: pointer;
            color: white;
          }
          color: black;
        }
      }
    }
  }

  .report-type-form {
    background: white;
    color: $main-text-color;
    padding: 20px;
    label {
      padding-top: 0;
    }
    .formbutton {
      float: right;
      text-align: right;
      margin: 10% 0 0 0;
      button {
        min-height: 60px;
        float: left;
        background: #4bba63;
        border: 2px solid white;
        color: white;
        border-radius: 12px;
        max-width: 30%;
        min-width: 25%;
        cursor: pointer;
        &:disabled {
          cursor: not-allowed;
        }
        &:hover:not([disabled]) {
          background: #556959;
        }
      }
    }
    .searchbar-top.search-bar-report {
      display: inline-block;
      border: 1px;
      border-style: inset;
    }
    overflow: hidden;
  }
</style>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS,
    ASYNC_LOADING
  } from 'app/constants/AsyncStatus';
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';
  import PlayerReportForm from 'app/components/EditReport/PlayerReportForm.vue';
  import TeamReportForm from 'app/components/EditReport/TeamReportForm.vue';
  import 'vue-awesome/icons/edit';
  import 'vue-awesome/icons/eye';
  import 'vue-awesome/icons/eye-slash';
  import TimelineItem from 'app/components/TimelineItem';

  import Icon from 'vue-awesome/components/Icon';
  import ActionsItem from 'app/components/ActionsItem';
  import PlayerResume from 'app/components/ProfileResume/PlayerResume';
  import ClubResume from 'app/components/ProfileResume/ClubResume';
  export default {
    name: 'EditReportPage',
    components: {
      sidebar: NotificationSidebar,
      playerreportform: PlayerReportForm,
      teamreportform: TeamReportForm,
      icon: Icon,
      'action-item': ActionsItem,
      'timeline-item': TimelineItem,
      clubresume: ClubResume,
      playerresume: PlayerResume
    },
    computed: {
      ...mapGetters(['report', 'searchReport']),
      playerInfo() {
        if (this.searchReport.status == ASYNC_SUCCESS)
          return this.reportValue.player;
        return null;
      },
      clubInfo() {
        if (!this.playerInfo && this.searchReport.status == ASYNC_SUCCESS)
          return this.reportValue.team;
        return null;
      },
      reportValue() {
        if (this.searchReport.status === ASYNC_SUCCESS) {
          return this.searchReport.value.report;
        }
        return null
      },
      player() {
        if (this.reportValue && this.reportValue.type_report == 'player') {
          return true;
        }
        return false
      },
      team() {
        if (this.reportValue && this.reportValue.type_report == 'team') {
          return true;
        }
        return false
      },
      search() {
        if (this.reportValue) {
          return this.reportValue.meta_data.search;
        }
        return null;
      },
    },
    watch: {
      report() {
        this.status = '';
        if (this.report.status === ASYNC_SUCCESS) {
          this.searchReport.value.report = this.report.value;
          this.$router.push({
            name: 'scoutReportView',
            params: {
              id: this.report.value.id
            }
          });
        } else if (this.report.status === ASYNC_LOADING) {
          this.status = 'reportUploading';
        }
      }
    },
    mounted() {
      this.getReport(this.$route.params.id);
    },
    methods: {
      ...mapActions(['updateReport', 'getReport', 'uploadFiles']),
      cancel() {
        this.$router.push({
          name: 'scoutReportView',
          params: {
            id: this.$route.params.id
          }
        });
      },
      updateStatus(status) {
        var report = {
          status: status
        };
        this.updateReport({
          report,
          id: this.reportValue.id
        });
      },
      customUpdateReport(report, filelist) {
        for (var f in report.remove_attachment) {
          if (report.remove_attachment[f] === false) {
            delete report.remove_attachment[f];
          }
        }
        this.report.errors = null;
        this.report.files = filelist;
        var id = this.$route.params.id;
        this.updateReport({
          report: report,
          id
        });
      }
    },
    data() {
      return {
        status: ''
      };
    }
  };
</script>
