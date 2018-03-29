<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h5 class="row">REPORT MARKETPLACE</h5>
        <div class="filters-marketplace row col-md-12">
          <form @submit.prevent="search" class="col-md-12">
            <h6 class="row" >Filter Report</h6>
            <fieldset class="form-group col-md-2 filter">
              <label class="col-sm-12">Report Type</label>
              <select v-model="params.type_report" class="col-md-12">
                <option value="player">Player</option>
                <option value="team">Team</option>
              </select>
            </fieldset>
            <fieldset class="form-group col-md-2 filter">
              <label class="col-sm-12">Scout Name</label>
              <input class="col-sm-12" type="text" v-model="params.user_name" />
            </fieldset>
            <fieldset class="form-group col-md-2 filter">
              <label class="col-sm-12">Date Created</label>
              <datepicker :input-class="[params.created_date != '' ? 'selected': '', 'input-date','col-sm-12'].join(' ')" v-model="params.created_date"
                class="datepicker col-sm-12"></datepicker>
            </fieldset>
            <fieldset class="form-group col-md-4 filter">
              <label class="col-sm-12">Price Range (Min - Max)</label>
              <input type="number" class="col-sm-5" v-model="params.price_min" />
              <span class="separator">—</span>
              <input type="number" class="col-sm-5" v-model="params.price_max" />
            </fieldset>
            <fieldset class="form-group col-md-1 filter">
              <button class="btn-info">Filter</button>
            </fieldset>
          </form>
        </div>
        <!-- Modal Component -->
        <b-modal id="metaModal" size="lg" ref="metaModal">
          <playerreportpopup v-if="reportSelected && reportSelected.type_report == 'player'" :report="reportSelected" />
          <clubreportpopup v-if="reportSelected && reportSelected.type_report == 'team'" :report="reportSelected" />
        </b-modal>

        <reportitem v-for="report in searchReport.value.report" :key="report.id" class="row report col-md-12" :report="report" :viewAction="viewAction"
          :summaryAction="playerAction" />
      </div>
    </div>
  </div>
</template>

<style lang="scss">
@import '~stylesheets/variables';

#metaModal {
  color: black;
  header {
    display: none;
  }
  h5 {
    margin-bottom: 35px;
  }
  .modal-content {
    padding: 50px 80px;
  }
  .reportHeadline {
    margin-bottom: 40px;
    p.col {
      margin: 0;
    }
  }
  .infos .row {
    margin-top: 10px;
    .col {
      margin: 0;
      .list {
        text-transform: capitalize;
      }
    }
  }
}
.filters-marketplace {
  .datepicker {
    color:black;
    margin-right: 5px;
    background: white;
    input.input-date {
      border: 1px solid $secondary-text-color !important;
      cursor: pointer;
      width: 100%;
      height: 2em;
      border: 0px;
      background: white;
      background: url('/images/calendar.png') no-repeat;
      background-size: 2em 1.7em;
      background-position: center;
      text-indent: 100%;
      white-space: nowrap;
      overflow: hidden;
      &.selected {
        background: url('/images/calendar-fill.png') no-repeat;
        background-size: 2em 1.7em;
        background-position: center;
      }
    }
  }
}
</style>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.filters-marketplace {
  background: white;
  color: black;
  .filter {
    display: inline-block;
    label {
      float: left;
    }
    input, select {
      float: left;
      height: 2em;
    }
    .datepicker {
      float: left;
    }
    button {
      float: left;
    }
    .separator {
      float: left;
      margin-right: 5px;
      font-size: 19px;
      font-weight: 800;
    }
  }
}

.report {
  background: white;
  color: black;
  padding: 30px 50px;
  margin-top: 20px;
  .buttons {
    display: flex;
    button {
      align-self: flex-end;
    }
  }
  .user {
    .name {
      text-align: center;
      text-transform: capitalize;
      background: #e8e8e8;
      margin-top: 15px;
      padding: 10px;
    }
  }
  .report-info {
    margin-left: 30px;
    margin-top: 20px;
    p::first-letter {
      text-transform: capitalize;
    }
  }
}
</style>

<script>
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import ReportItem from 'app/components/ReportItem';
import PlayerReportPopup from './components/PlayerReportPopup';
import ClubReportPopup from './components/ClubReportPopup';
import Datepicker from 'vuejs-datepicker';

export default {
  name: 'MarketPlacePage',
  components: {
    sidebar: NotificationSidebar,
    reportitem: ReportItem,
    playerreportpopup: PlayerReportPopup,
    clubreportpopup: ClubReportPopup,
    datepicker: Datepicker
  },
  data() {
    return {
      reportSelected: null,
      params: {
        type_report: '',
        price_min: '',
        price_max: '',
        user_name: '',
        created_date: ''
      }
    };
  },
  mounted() {
    this.getReports({
      t: 't'
    });
  },
  computed: {
    ...mapGetters(['searchReport'])
  },
  methods: {
    ...mapActions(['getReports']),
    viewAction(report) {
      this.$router.push({
        path: '/report/view/' + report.id
      });
    },
    playerAction(report) {
      this.reportSelected = report;
      this.$refs.metaModal.show();
    },
    search() {
      var params = this.params;
      if (params.created_date_from) {
        params.created_date_from = this.$options.filters.railsdate(params.created_date_from);
      }
      if (params.created_date_to) {
        params.created_date_to = this.$options.filters.railsdate(params.created_date_to);
      }
      var url = Object.keys(params)
        .map(function(k) {
          return encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);
        })
        .join('&');
      this.getReports(url);
    }
  }
};
</script>