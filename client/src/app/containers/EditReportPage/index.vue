<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page ">
        <h4 class="header">Edit Report</h4>
        <action-item v-if="searchReport.value.report">
          <button class="timeline-widget-button">
            <span>
              <icon name='eye' scale="1.5"></icon>
            </span>
              <router-link :to="{ name: 'scoutReportView', params: { id: searchReport.value.report.id }}">View</router-link>
          </button>
          <button class="timeline-widget-button">
            <span>
              <icon name='edit' scale="1.5"></icon>
            </span>
    <router-link  :to="{ name: 'scoutReportEdit', params: { id: searchReport.value.report.id }}" class="active">Edit</router-link>
          </button>
          <button class="timeline-widget-button button-right" v-if="searchReport.value.report.status == 'publish'" @click="updateStatus('private')">
            <span class="unpublish">
              <icon name="eye-slash" scale="1.5"></icon>
            </span>
            <a>Unpublish Report</a>
          </button>
          <button class="timeline-widget-button button-right" v-if="searchReport.value.report.status == 'private'" @click="updateStatus('publish')">
            <span class="publish">
              <icon name="eye"></icon>
            </span>
            <a>Publish Report</a>
          </button>
        </action-item>
        <div v-if="searchReport.value.report" class="report-container">
          <div data-v-5d9799ca="" class="arrow"></div>
          <div class="form-container">
            <ul class="error" v-if="report.errors">
              <li v-for="(error) in report.errors.error" v-bind:key="error.id">
                {{ error }}
              </li>
            </ul>
            <playerreportform v-if="searchReport.value && searchReport.value.report.type_report == 'player' " :submitReport="customUpdateReport"
              class="report" :report="searchReport.value.report" :cancelAction="cancel" />
            <clubreportform v-if="searchReport.value && searchReport.value.report.type_report == 'team' " :submitReport="customUpdateReport"
              class="report" :report="searchReport.value.report" :cancelAction="cancel" />
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
.Loading {
  color: black;
  text-align: center;
  font-size: 20px;
}

.error {
  color: red;
}

.search-player {
  &:focus ~ .search-results {
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
  border-left: 7px solid #a8cb5c;
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
  border-left-color: #a8cb5c;
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
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS, ASYNC_LOADING } from 'app/constants/AsyncStatus';
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import PlayerReportForm from 'app/components/EditReport/PlayerReportForm.vue';
import ClubReportForm from 'app/components/EditReport/ClubReportForm.vue';
import 'vue-awesome/icons/edit';
import 'vue-awesome/icons/eye';
import 'vue-awesome/icons/eye-slash';

import Icon from 'vue-awesome/components/Icon';
import ActionsItem from 'app/components/ActionsItem';

export default {
  name: 'CreateReportPage',
  components: {
    sidebar: NotificationSidebar,
    playerreportform: PlayerReportForm,
    clubreportform: ClubReportForm,
    icon: Icon,
    'action-item': ActionsItem
  },
  computed: {
    ...mapGetters(['report', 'searchReport', 'filesUpload'])
  },
  watch: {
    report() {
      this.status = '';
      if (this.report.status === ASYNC_SUCCESS) {
        this.searchReport.value.report = this.report.value;
        if (this.files) {
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
        }
      } else if (this.report.status === ASYNC_LOADING) {
        this.status = 'reportUploading';
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
        path: '/report/view/' + this.$route.params.id
      });
    },
    updateStatus(status) {
      var report = {
        status: status
      };
      this.updateReport({
        report,
        id: this.searchReport.value.report.id
      });
    },
    startUpload() {
      var formData = new FormData();
      var fileList = this.files;
      var i = 0;
      $.each(fileList, function(index, value) {
        formData.append('files[' + i++ + ']', value);
        i++;
      });
      formData.append('report_id', this.report.value.id);
      this.uploadFiles(formData);
    },
    customUpdateReport(report, filelist) {
      for (var f in report.remove_attachment) {
        if (report.remove_attachment[f] === false) {
          delete report.remove_attachment[f];
        }
      }
      this.report.errors = null;
      this.files = filelist;
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
