<template>
  <form class="report-type-form" @submit.prevent>
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Select report type</label>
      <div class="col-sm-6">
        <select v-model="type">
          <option disabled value="" selected>Report type</option>
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
        <input name="team" autocomplete="off" class="search-player" v-model="team_search" type="text" v-on:keyup="getSearchResultsRole('player',team_search)">
        <div class="search-results">
          <p v-for="(value, key, index) in searchResult.value" :key="index" @mousedown="setvalue(value,'team')">
            {{value.display_name}}
          </p>
        </div>
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Select Player</label>
      <div class="col-sm-8">
        <input name="player" autocomplete="off" class="search-player" v-model="player_search" type="text" v-on:keyup="getSearchResultsRole('player',player_search)">
        <div class="search-results">
          <p v-for="(value, key, index) in searchResult.value" :key="index" @mousedown="setvalue(value,'player')">
            {{value.display_name}}
          </p>
        </div>
      </div>
    </div>
    <div class="formbutton">
      <button :disabled="player_id == '' || type != 'player' " @click="startReport">Create Report for a player</button>
      <button :disabled="team_id == '' || type != 'team' " @click="startReport">Create Report for a team</button>
      <button>Cancel</button>
    </div>
  </form>
</template>
<style lang="scss" scoped>
@import "~stylesheets/variables";
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
export default {
  name: 'ReportBasicForm',
  props: ['prepateReport'],
  data() {
    return {
      player_report: false,
      team_report: false,
      type: '',
      job_type: 'independent',
      job_id: '',
      team_id: '',
      player_id: '',
      player_search: '',
      team_search: ''
    };
  },
  computed: {
    ...mapGetters(['searchResult'])
  },
  methods: {
    ...mapActions(['getSearchResults']),
    setvalue(info, type) {
      if (type == 'player') {
        this.player_search = info.display_name;
        this.player_id = info.id;
      } else if (type == 'team') {
        this.team_search = info.display_name;
        this.team_id = info.id;
      }
    },
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