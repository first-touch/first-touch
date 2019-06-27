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

        <report-type-form v-if="!showForm" v-on:start-report="prepareReport" />
        <div v-if="showForm">
          <keep-alive>
            <player-report-form
              v-if="reportData.type_report == 'Player'"
              :hasBankAccount="hasBankAccount"
              :report="reportData"
              :request="request"
              v-on:submit="customCreateReport"
              v-on:cancel="cancel"
            />
            <team-report-form
              v-if="reportData.type_type == 'Team'"
              :category="category"
              :hasBankAccount="hasBankAccount"
              :submitReport="customCreateReport"
              :team_id="team_id"
              :cancelAction="cancel"
              :request="request"
            />
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

  export default {
    name: 'CreateReportPage',
    props: ['request'],
    components: {
      PlayerReportForm,
      TeamReportForm,
      Status,
      ReportTypeForm,
      TimelineItem
    },
    computed: {
      ...mapGetters(['report', 'searchResult', 'profile', 'teamProfile', 'user']),
      position() {
        if (this.request)
          return this.request.type_request == 'position';
        return false
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
    methods: {
      ...mapActions(['getReport', 'createReport', 'uploadFiles', 'getSearchResults']),
      toPaymentPage() {
        this.$router.push({
          name: 'scoutPaymentDetailPage',
        });
      },
      cancel() {
        this.showForm = false;
      },
      prepareReport(reportData) {
        _.merge(this.reportData, reportData);
        this.showForm = true;
      },
      customCreateReport(filledInfo) {
        this.reportData.headline = filledInfo.headline;
        this.reportData.price = filledInfo.price;
        this.reportData.meta_data = filledInfo.meta_data;
        this.reportData.status = filledInfo.status;
        this.createReport(this.reportData);
      },
    },
    data() {
      return {
        reportData: {},
        status: '',
        job_id: '',
        team_id: '',
        showForm: false,
        category: ''
      };
    },
    mounted() {
      let reportId = this.$route.params.id;
      if (reportId) {
        this.getReport(this.$route.params.id);
      }
    }
  };
</script>
