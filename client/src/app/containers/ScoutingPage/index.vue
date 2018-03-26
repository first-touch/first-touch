<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page edit-profile">
        <h4 class="header">Create Report</h4>
        <div class="form-container">
          <div class="Loading" v-if="status != '' ">
            <p v-if="status == 'reportUploading' ">
              Creating Report
            </p>
            <p v-if="status == 'filesUploading' ">
              Uploading Files
            </p>
          </div>
          <form class="report-type-form" v-if="!team_report && !player_report" @submit.prevent>
            <div class="form-group row">
              <label class="col-sm-3 col-form-label">Select report type</label>
              <div class="col-sm-6">
                <select v-model="type">
                      <option disabled value="" selected >Report type</option>
                      <option value="player">Player</option>
                      <option value="team">Team</option>
                    </select>
              </div>
            </div>
            <div class="form-group row">
              <label class="col-sm-3 col-form-label">Job request type</label>
              <div class="col-sm-6">
                <select v-model="job_type">
                      <option value="independent" selected>Independent</option>
                      <option value="position">Job Request on a Position</option>
                      <option value="player">Player Job Request</option>
                      <option value="team">Team Job Request</option>
                    </select>
              </div>
            </div>
            <div class="form-group row">
              <label class="col-sm-3 col-form-label">Select Job Request Id</label>
              <div class="col-sm-6">
                <input type="text" v-model="job_id" :disabled="job_type == 'independent'" />
              </div>
            </div>
            <div class="form-group row">
              <label class="col-sm-3 col-form-label">Select Team</label>
              <div class="col-sm-8">
                <input list="clubs" name="player" v-model="team_id" type="text" v-on:keyup="getSearchResultsRole('club')">
                <datalist id="clubs">
                    <option value=""></option>
                      <option v-for="(value, key, index) in searchResult.value" :key="index" :value="value.display_name" >
                            {{value.display_name}}
                        </option>
                  </datalist>
              </div>
            </div>
            <div class="form-group row">
              <label class="col-sm-3 col-form-label">Select Player</label>
              <div class="col-sm-8">
                <input name="player" autocomplete="off" class="search-player" v-model="player_search" type="text" v-on:keyup="getSearchResultsRole('player')">
                <div class="search-results">
                  <p @click="setvalue" v-for="(value, key, index) in searchResult.value" :key="index" @mousedown="setvalue(value)">
                    {{value.display_name}}
                  </p>
                </div>
              </div>
            </div>
            <div class="formbutton">
              <button :disabled="player_id == '' || type != 'player' " @click="prepateReport('player')">Create Report for a player</button>
              <button :disabled="team_id == '' || type != 'club' " @click="prepateReport('team')">Create Report for a club</button>
              <button>Cancel</button>
            </div>
          </form>
          <playerreportform v-if="player_report && status == '' " :userinfo="userinfo" :createReport="customCreateReport" />

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
  .Loading{
    color: black;
    text-align: center;
    font-size: 20px;
  }
  .search-player {
    &:focus~.search-results {
      position: absolute;
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

  .form-container {
    background-color: #fff;
    border-radius: 5px;
    padding: 20px;
    width: 100%;
  }

  .report-type-form {
    background: white;
    color: #7f8081;
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
        background: #4BBA63;
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

  .profile-item {
    display: flex;
    border-left: 7px solid $main-header-color;
    margin-top: 20px;
    .arrow {
      margin-top: 18px;
      border-left-color: $main-header-color;
    }
    .form-container {
      background-color: #fff;
      border-radius: 5px;
      padding: 20px;
      width: 100%;
    }
  }
</style>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS,
    ASYNC_FAIL,
    ASYNC_LOADING
  } from 'app/constants/AsyncStatus';
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';
  import PlayerReportForm from './components/PlayerReportForm.vue';

  export default {
    name: 'SignupPage',
    components: {
      sidebar: NotificationSidebar,
      playerreportform: PlayerReportForm,
    },
    computed: {
      ...mapGetters(['report', 'searchResult', 'profile', 'filesUpload']),
      userinfo() {
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
            this.$router.push({
              path: '/report/view/' + this.report.value.id
            })
          }
        } else if (this.report.status === ASYNC_LOADING) {
          this.status = 'reportUploading'
        }
      },
      filesUpload() {
        if (this.filesUpload.status === ASYNC_SUCCESS) {
          this.$router.push({
            path: '/report/view/' + this.report.value.id
          })
        } else if (this.filesUpload.status === ASYNC_LOADING) {
          this.status = 'filesUploading'
        }
      }
    },
    methods: {
      ...mapActions(['createReport', 'fetchUserInfo', 'uploadFiles', 'getSearchResults']),
      setvalue(info) {
        this.player_search = info.display_name
        this.player_id = info.id;
      },
      startUpload() {
        var formData = new FormData();
        var fileList = this.files;
        $.each(fileList, function(index, value) {
          formData.append('files[' + value.name + ']', value);
        });
        formData.append('report_id', this.report.value.id);
        this.uploadFiles(formData);
      },
      getSearchResultsRole(role) {
        return this.getSearchResults({
          searchTerm: this.player_search,
          role: role
        })
      },
      prepateReport(type) {
        if (type == 'player') {
          this.player_report = true;
          this.fetchUserInfo({
            id: this.player_id
          });
        }
      },
      customCreateReport(reportdata, filelist) {
        this.files = filelist;
        reportdata.type_report = this.type
        reportdata.player_id = this.player_id
        reportdata.team_id = this.team_id
        this.createReport(reportdata);
      },
    },
    data() {
      return {
        status: '',
        player_report: false,
        team_report: false,
        type: '',
        job_type: 'independent',
        job_id: '',
        team_id: '',
        player_id: '',
        player_search: '',
      };
    }
  };
</script>