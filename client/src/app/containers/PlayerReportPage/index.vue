<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page edit-profile">
        <h4 class="header">Create User Report</h4>
        <div class="report-form">
          <div class="arrow"></div>
          <div class="form-container">
            <newplayerform v-if="isNew" :createUserInfo="createUserInfo" />
            <playerreportform v-if="!isNew" :userinfo="userinfo" :createReport="customCreateReport" :reportStatus="reportStatus" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .report-form {
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
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';
  import PlayerReportForm from './components/PlayerReportForm.vue';
  import NewPlayerForm from './components/NewPlayerForm.vue';

  import {
    ASYNC_SUCCESS,
    ASYNC_FAIL
  } from 'app/constants/AsyncStatus';

  export default {
    name: 'PlayerReportPage',
    props: [
      'type',
    ],
    data() {
      return {
        isNew: this.$route.params.id == "new",
        player: '',
        files: null
      };
    },
    components: {
      sidebar: NotificationSidebar,
      playerreportform: PlayerReportForm,
      newplayerform: NewPlayerForm
    },
    computed: {
      ...mapGetters(['report', 'newUser', 'profile']),
      userinfo() {
        if (this.profile.status === ASYNC_SUCCESS) {
          var personal_profile = this.profile.value.personal_profile;
          var birthday = new Date(personal_profile.birthday)
          // personal_profile.playing_position = JSON.parse(personal_profile.playing_position)
          personal_profile.bMonth = birthday.getMonth()
          personal_profile.bDay = birthday.getDate();
          personal_profile.bYear = birthday.getFullYear();
          return personal_profile;
        }
        return {};
      },
      reportStatus() {

        return this.report.status === ASYNC_FAIL ?
          this.report : null
      }
    },
    mounted() {
      this.fetchUserInfo({
        id: this.$route.params.id
      });
    },
    watch: {
      report() {
        if (this.report.status === ASYNC_SUCCESS) {
          var formData = new FormData();
          if (this.files.length > 0) {
            var fileList = this.files;
            $.each(fileList, function(index, value) {
              formData.append('files[' + value.name + ']', value);
            });
            formData.append('report_id', this.report.value.id);
            this.uploadFiles(formData);
          }
        }
      },
      newUser() {
        if (this.newUser.status === ASYNC_SUCCESS) {
          var userId = this.newUser.value.user.id
          this.isNew = false
          this.$route.params.id = userId
          this.$router.push({
            path: `/users/${userId}/report`
          })
          this.fetchUserInfo({
            id: this.$route.params.id
          });
        }
      }
    },
    methods: {
      ...mapActions(['createReport', 'importUser', 'fetchUserInfo', 'uploadFiles']),
      createUserInfo(data) {
        this.importUser(data);
      },
      customCreateReport(reportdata, filelist) {
        this.files = filelist;
        this.createReport(reportdata);
      },
    }
  };
</script>