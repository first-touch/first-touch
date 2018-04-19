<template>
  <div class="widget-request ft-search-widget">
    <h4 class="header">My Jobs List</h4>
    <timeline-item>
      <div class="widget-content col col-md-12">
        <div class="row align-items-start">
          <div class="col-md-2">
            <h6 class="list-title">Request Count</h6>
            <h1 class="list-count">{{listRequest.length}}</h1>
          </div>
          <form @submit.prevent="search" class="col-md-10 row">
            <fieldset class="col-md-4 filter">
              <vselect v-model="vselect_type" :options="options.type_request" :searchable="false" clearable="false" />
            </fieldset>
            <ftdatepicker class="col-md-5 filter form-control" :value="params.created_date" :clearable="false" v-on:update:val="params.created_date = $event; search()"
            />
            <fieldset class="col-md-3 filter">
              <vselect v-model="vselect_sort" @input="search" :options="options.order" :searchable="false" />
            </fieldset>
          </form>
        </div>
      </div>
      <b-modal id="metaModal" size="lg" ref="metaModal">
        <div>
          <playerrequestpopup v-if="selected && selected.type_request == 'player' " :request="selected" :closeAction="closeAction"
            />
          <teamrequestpopup v-if="selected && selected.type_request == 'team' " :request="selected" :closeAction="closeAction"
             />
          <positionrequestpopup v-if="selected && selected.type_request == 'position' " :request="selected" :closeAction="closeAction"
             />
        </div>
      </b-modal>
      <request v-for="request in listRequest" :key="request.id" :request="request" :viewSummary="viewSummary" ></request>
    </timeline-item>
  </div>
</template>


<style lang="scss">
@import '~stylesheets/variables';
@import '~stylesheets/modal';
@import '~stylesheets/search';
.ft-form {
  padding: 0 !important;
}

.widget-request {
  .datepicker {
    padding: 0;
    input.input-date {
      cursor: pointer;
      min-height: 2em;
      border: 0px;
    }
  }
  .dropdown-toggle {
    max-height: 35px;
    border: 0px;
  }
}
</style>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.widget-request {
  color: $main-text-color;
  .form-control {
    padding: 0;
  }
  .list-title {
    color: $main-text-color;
    font-size: 0.95em;
    text-transform: uppercase;
  }
  .list-count {
    color: $main-header-color;
    font-size: 4em;
    text-align: center;
  }
  .filter {
    margin: 5px;
    max-width: 23%;
    input,
    select {
      height: 100%;
      padding: 10px;
    }
    .icon-inner {
      margin-top: 5px;
      display: inline-block;
      cursor: pointer;
      &:hover {
        color: $secondary-header-color;
      }
    }
    .datepicker {
      float: left;
    }
  }
}
</style>
<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import Datepicker from 'vuejs-datepicker';
import RequestItem from 'app/components/RequestItem';
import TimelineItem from 'app/components/TimelineItem';
import vSelect from 'vue-select';
import FtDatepicker from 'app/components/Input/FtDatepicker';
import PlayerRequestPopup from 'app/components/RequestPopup/PlayerRequestPopup';
import PositionRequestPopup from 'app/components/RequestPopup/PositionRequestPopup';
import TeamRequestPopup from 'app/components/RequestPopup/TeamRequestPopup';

export default {
  name: 'JobRequestWidget',
  components: {
    datepicker: Datepicker,
    'timeline-item': TimelineItem,
    request: RequestItem,
    vselect: vSelect,
    ftdatepicker: FtDatepicker,
    teamrequestpopup: TeamRequestPopup,
    playerrequestpopup: PlayerRequestPopup,
    positionrequestpopup: PositionRequestPopup
  },
  data() {
    return {
      selected: null,
      wantbid: false,
      params: {
        id: '',
        created_date: '',
        order: '',
        status: '',
        type_request: '',
        bids_status: 'accepted'
      },
      vselect_type: {
        label: 'Request Type',
        value: ''
      },
      vselect_sort: {
        label: 'Sort by',
        value: ''
      },
      options: {
        type_request: [
          {
            label: 'Request Type',
            value: ''
          },
          {
            label: 'Player',
            value: 'player'
          },
          {
            label: 'Position',
            value: 'position'
          },
          {
            label: 'Team',
            value: 'team'
          }
        ],
        order: [
          {
            label: 'Sort by',
            value: ''
          },
          {
            label: 'Updated date',
            value: 'updated_at'
          },
          {
            label: 'Type',
            value: 'type_request'
          },
          {
            label: 'Max Price',
            value: 'max_price'
          }
        ],
        status: [
          {
            label: 'Status',
            value: ''
          },
          {
            label: 'Draft',
            value: 'draft'
          },
          {
            label: 'Closed',
            value: 'close'
          },
          {
            label: 'Publish',
            value: 'publish'
          },
          {
            label: 'Private',
            value: 'private'
          }
        ]
      }
    };
  },
  mounted() {
    this.search();
  },
  computed: {
    ...mapGetters(['searchRequest']),
    listRequest() {
      if (this.searchRequest.status === ASYNC_SUCCESS) {
        return this.searchRequest.value.request;
      }
      return [];
    },
    url() {
      var params = this.params;
      return Object.keys(params)
        .map(function(k) {
          return encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);
        })
        .join('&');
    }
  },
  watch: {
    vselect_type: function() {
      this.params.type_request = this.vselect_type.value;
      this.search();
    },
    vselect_status: function() {
      this.params.status = this.vselect_status.value;
      this.search();
    }
  },
  methods: {
    ...mapActions(['getRequests', 'createBid', 'clearBid', 'updateBid']),
    search() {
      this.getRequests(this.url);
    },
    closeAction(request) {
      this.$refs.metaModal.hide();
      // this.wantbid = false;
      // this.selected = null;
      // this.clearBid();
      // this.search();
    },
    viewSummary(request) {
      this.wantbid = false;
      this.selected = request;
      this.$refs.metaModal.show();
    }
  }
};
</script>
