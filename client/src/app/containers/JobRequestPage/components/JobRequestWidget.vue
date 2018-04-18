<template>
  <div class="widget col col-md-12">
    <div class="widget-header" v-if="listRequest">
    </div>
    <div class="widget-content">
      <h5>Filter</h5>
      <form @submit.prevent="search" class="filters-request">
        <fieldset class="form-group col-md-2 filter">
          <label class="col-sm-12">Job REQUEST ID</label>
          <input class="col-md-12" type="number" v-model="params.id" />
        </fieldset>
        <fieldset class="form-group col-md-2 filter">
          <label class="col-sm-12">Job Type</label>
          <select class="col-md-12" name="type_request" v-model="params.type_request">
            <option value="">All</option>
            <option value="player">Player</option>
            <option value="position">Position</option>
            <option value="team">Team</option>
          </select>
        </fieldset>
        <fieldset class="form-group col-md-2 filter">
          <label class="col-sm-12">Status</label>
          <select class="col-md-12" name="type_request" v-model="params.status">
            <option value="">All</option>
            <option value="draft">Draft</option>
            <option value="publish">Publish</option>
            <option value="removed">Closed</option>
            <option value="private">Private</option>
          </select>
        </fieldset>
        <fieldset class="form-group col-md-2 filter">
          <label class="col-sm-12">Date Created
            <span class="clear-date" v-if="params.created_date != ''" @click="params.created_date = ''">X</span>
          </label>
          <datepicker :input-class="[params.created_date != '' ? 'selected': '', 'input-date','col-sm-12'].join(' ')" v-model="params.created_date"
            format="MM/dd/yyyy" class="datepicker col-sm-12"></datepicker>
        </fieldset>
        <fieldset class="form-group col-md-3 filter">
          <label class="col-sm-12">No of bids (Min - Max)</label>
          <input type="number" class="col-sm-5" v-model="params.min_bids" />
          <span class="separator">—</span>
          <input type="number" class="col-sm-5" v-model="params.max_bids" />
        </fieldset>
        <fieldset class="form-group filter">
          <label class="col-sm-12"> - </label>
          <button class="btn-info">FILTER</button>
        </fieldset>
      </form>
      <div class="header col col-md-12">
        <p :class="[params.order == 'id'? 'active':'','order','col col-md-2']" @click="params.order = 'id'; search()">Job REQUEST ID</p>
        <p class="col col-md-2">EDIT/DELETE</p>
        <p :class="[params.order == 'type_request'? 'active':'','order','col col-md-2']" @click="params.order = 'type_request'; search()">JOB TYPE</p>
        <p :class="[params.order == 'created_on'? 'active':'','order','col col-md-2']" @click="params.order = 'created_on'; search()">Created On</p>
        <p :class="[params.order == 'status'? 'active':'','order','col col-md-2']" @click="params.order = 'status'; search()">Status</p>
        <p :class="[params.order == 'nb_bids'? 'active':'','order','col col-md-2']" @click="params.order = 'nb_bids'; search()">No of bids</p>
        <p class="col col-md-2">Action</p>
      </div>
      <div class="newResult col col-md-12" v-if="listRequest.length > 0" v-for="request in listRequest" :key="request.id">
        <p class="col col-md-2">{{request.id | requestId(request.type_request)}} </p>
        <p class="col col-md-2">
          <span class="action col-md-6 ">
            <router-link :to="{ name: 'clubRequest', params: { id: request.id }}">Edit</router-link>
          </span>
          <span class="action col-md-6 ">
            <a href='#' @click="updateStatus(request.id,'deleted')">Delete</a>
          </span>
        </p>
        <p class="col col-md-2">{{request.type_request}} Job Request</p>
        <p class="col col-md-2">{{request.created_at | moment}}</p>
        <p class="col col-md-2">
          <span class="action col-md-6 " v-if="request.status == 'publish'">Active</span>
          <span class="action col-md-6 " v-if="request.status == 'private'">Inactive</span>
          <span v-if="request.status == 'private'" class="action col-md-6 ">
            <a href="#" @click="updateStatus(request.id,'publish')">Active</a>
          </span>
          <span v-if="request.status == 'publish'" class="action col-md-6 ">
            <a href="#" @click="updateStatus(request.id,'private')">Desactivate</a>
          </span>
        </p>
        <p class="col col-md-2">WIP</p>
        <p class="col col-md-2">WIP</p>
      </div>
    </div>
  </div>
</template>


<style lang="scss">
@import '~stylesheets/variables';

.filters-request {
  .datepicker {
    padding: 0;
    color: black;
    margin-right: 5px;
    background: white;
    input.input-date {
      padding: 0;
      border: 1px solid $secondary-text-color !important;
      cursor: pointer;
      width: 100%;
      height: 2em;
      border: 0px;
      background: white;
      background: url('/images/calendar.png') no-repeat;
      background-size: 2em 1.7em;
      background-position: right;
      &.selected {
        background: url('/images/calendar-fill.png') no-repeat;
        background-size: 2em 1.7em;
        background-position: right;
      }
    }
  }
}
</style>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.widget {
  color: $secondary-text-color;
  background: $div-filter-background;
  padding-left: 10px;
  .widget-content {
    padding: 20px 0 0 0;
    .clear-date {
      cursor: pointer;
      color: red;
    }
    h5 {
      margin-left: 30px;
    }
    .header {
      font-size: 13px;
      padding: 0;
      background: white;
      color: black;
      text-align: left;
      margin: 0;
      overflow: hidden;
      margin-bottom: 30px;
      max-height: 50px;

      p {
        border: 1px solid black;
        padding: 20px 0 20px 0px;
        font-weight: bold;
        float: left;
        width: 14.285%;
        text-align: center;
        &.order {
          cursor: pointer;
          &.active {
            text-decoration: underline;
          }
        }
      }
    }
    .newResult {
      font-size: 12px;
      padding: 0;
      overflow: hidden;
      background: white;
      color: black;
      border: 1px solid black;
      max-height: 30px;
      p {
        height: 30px;
        border-right: 1px solid black;
        float: left;
        width: 14.285%;
        text-align: center;
        span {
          padding: 0;
          float: left;
        }
        &:first-letter {
          text-transform: capitalize;
        }
      }
      &::last-child {
        padding: 0;
        p {
          padding: 0;
        }
      }
    }
    .results {
      display: none;
    }
    form {
      background: white;
      display: inline-block;
      border: 1px solid black;
      label {
        padding: 0;
        color: black;
      }
      button {
        border-radius: 5px;
        padding: 0 15px;
      }
    }

    .filter {
      float: left;

      &:nth-child(odd) {
        padding: 0 10px;
      }
      label {
        float: left;
      }
      input,
      select {
        float: left;
        height: 2em;
        box-shadow: 1px 0px #000000;
      }
      .datepicker {
        float: left;
      }
      .separator {
        float: left;
        margin: 0 5px;
        font-size: 19px;
        font-weight: 800;
      }
    }
  }
}
</style>
<script>
import Datepicker from 'vuejs-datepicker';
export default {
  name: 'JobRequestWidget',
  props: ['listRequest', 'getRequests', 'update'],
  components: {
    datepicker: Datepicker
  },
  data() {
    return {
      params: {
        id: '',
        created_date: '',
        order: ''
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
