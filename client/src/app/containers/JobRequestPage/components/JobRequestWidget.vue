<template>
  <div class="widget-request">
    <h4 class="header">My Jobs Request</h4>
    <timeline-item>
      <div class="widget-content col col-md-12">
        <div class="row">
          <div class="col-md-2">
            <h6 class="list-title">Request Count</h6>
            <h1 class="list-count">{{listRequest.length}}</h1>
          </div>
          <form @submit.prevent="search" class="col-md-10 row">
            <fieldset class="col-md-2 filter">
              <vselect v-model="params.type_request" :on-change="search" :options="options.type_request" :searchable="false" />
            </fieldset>
            <fieldset class="col-md-2 filter">
              <vselect v-model="params.status" :on-change="search" :options="options.status" :searchable="false" />
            </fieldset>
            <fieldset class="col-md-3 filter form-control">
              <datepicker ref="datepicker" @closed="search" :input-class="[params.created_date != '' ? 'selected': '', 'input-date','col-sm-10'].join(' ')"
                v-model="params.created_date" class="datepicker col-md-10" format="dd,MMM yyyy"></datepicker>
              <span @click="params.created_date  = ''; search()" v-if="params.created_date  != ''" class="icon-inner">
                <icon name='times'></icon>
              </span>
              <span @click="showCalendar()" class="icon-inner">
                <icon name='calendar-alt' v-if="params.created_date == ''"></icon>
                <icon name='calendar-check' v-if="params.created_date != ''"></icon>
              </span>
            </fieldset>
            <fieldset class="col-md-3 filter form-control">
              <input type="number" class="col-sm-12" v-model="params.min_bids" />
            </fieldset>
          </form>
        </div>
      </div>
      <request v-for="request in listRequest" :key="request.id" :request="request" ></request>
    </timeline-item>
  </div>
</template>


<style lang="scss">
@import '~stylesheets/variables';
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
import Datepicker from 'vuejs-datepicker';
import RequestItem from './RequestItem';
import TimelineItem from 'app/components/TimelineItem';
import 'vue-awesome/icons/trash';
import 'vue-awesome/icons/calendar-alt';
import 'vue-awesome/icons/calendar-check';
import 'vue-awesome/icons/times';
import Icon from 'vue-awesome/components/Icon';
import vSelect from 'vue-select';
export default {
  name: 'JobRequestWidget',
  props: ['listRequest', 'getRequests', 'update'],
  components: {
    datepicker: Datepicker,
    'timeline-item': TimelineItem,
    request: RequestItem,
    icon: Icon,
    vselect: vSelect
  },
  data() {
    return {
      params: {
        id: '',
        created_date: '',
        order: '',
        status: '',
        type_request: ''
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
        status: [
          {
            label: 'All',
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
            label: 'Privete',
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
    url() {
      var params = this.params;
      return Object.keys(params)
        .map(function(k) {
          return encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);
        })
        .join('&');
    }
  },
  methods: {
    search() {
      this.getRequests(this.url);
    },
    updateStatus(id, status) {
      this.update(id, {
        status
      });
    }
  }
};
</script>
