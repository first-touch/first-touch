<template>
  <form class="report-type-form" @submit.prevent>
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Select report type</label>
      <div class="col-sm-6">
        <select v-model="type" class="form-control">
          <option disabled value="" selected>Report type</option>
          <option value="player">Player</option>
          <option value="team">Team</option>
        </select>
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Job request type</label>
      <div class="col-sm-6">
        <select v-model="job_type" class="form-control">
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
        <input type="text" class="col-sm-12 form-control" v-model="job_id" :disabled="job_type == 'independent'" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Select Team</label>
      <inputsearch class="col-sm-6" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="team" v-on:update:val="team_id = $event"
      />
    </div>
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Select Player</label>
      <inputsearch class="col-sm-6" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="player" v-on:update:val="player_id = $event"
      />
    </div>
    <div class="formbutton col-md-9">
      <button v-if="type == 'player'" class="bar-button col-md-6"  :disabled="player_id == ''" @click="startReport">Create Report for a player</button>
      <button v-if="type == 'team'" class="bar-button col-md-6" :disabled="team_id == ''" @click="startReport">Create Report for a team</button>
      <button class="bar-button" >Cancel</button>
    </div>
  </form>
</template>
<style lang="scss" scoped>
@import '~stylesheets/variables';
.form-container {
  background-color: #fff;
  border-radius: 5px;
  padding: 20px;
  width: 100%;
}

.report-type-form {
  background: white;
  color: $main-text-color;
  padding: 20px;
  label {
    padding-top: 0;
  }
  .formbutton {
    text-align: center;
    float:right;
    button {
      float:left;
      display: inline-block;
      min-height: 60px;
      color: $main-text-color;
      border: 1px solid $main-text-color;
          background-color: rgba(255, 255, 255, 0.2);
      cursor: pointer;
      &:disabled {
        cursor: not-allowed;
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

import inputSearch from 'app/components/Input/InputSearch.vue';

export default {
  name: 'ReportBasicForm',
  props: ['prepateReport'],
  components: {
    inputsearch: inputSearch
  },
  data() {
    return {
      player_report: false,
      team_report: false,
      type: '',
      job_type: 'independent',
      job_id: '',
      team_id: '',
      player_id: ''
    };
  },
  computed: {
    ...mapGetters(['searchResult'])
  },
  methods: {
    ...mapActions(['getSearchResults']),
    getSearchResultsRole(role, term) {
      this.getSearchResults({
        searchTerm: term,
        role: role
      });
    },
    startReport() {
      this.prepateReport(this.type, this.player_id, this.team_id, this.job_id);
    }
  }
};
</script>
