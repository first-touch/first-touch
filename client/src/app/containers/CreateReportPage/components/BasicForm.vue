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
      <label class="col-sm-3 col-form-label">Select a League</label>
      <inputsearch class="col-sm-6" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="competition" v-on:update:val="setLeague($event)" ref="league_search"
        minChar=3 label="name" />
    </div>
    <div class="form-group row">
      <label class="col-sm-3 col-form-label">Select a Team</label>
      <inputsearch class="col-sm-6" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="team" ref="team_search"
        v-on:update:obj="setTeam($event)" minChar=3 label="team_name" />
    </div>
    <div class="form-group row" v-if="type == 'player'">
      <label class="col-sm-3 col-form-label">Select a Player</label>
      <inputsearch class="col-sm-6" :taggable="true" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="player"
        label="display_name" v-on:update:val="player_id = $event" />
    </div>
    <div class="formbutton col-md-9">
      <button v-if="type == 'player'" class="bar-button col-md-6" :disabled="player_id == ''" @click="startReport">Create Report for a player</button>
      <button v-if="type == 'team'" class="bar-button col-md-6" :disabled="team_id == ''" @click="startReport">Create Report for a team</button>
      <button class="bar-button">Cancel</button>
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
      float: right;
      button {
        float: left;
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
  }
</style>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';

  import inputSearch from 'app/components/Input/InputSearch.vue';

  export default {
    name: 'ReportBasicForm',
    props: ['prepareReport'],
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
        league_id: '',
        player_id: ''
      };
    },
    computed: {
      ...mapGetters(['searchResult'])
    },
    methods: {
      ...mapActions([
        'getSearchResults',
        'getSearchResultsTeams',
        'getSearchResultsCompetition',
        'flushSearchResults'
      ]),
      setLeague(league_id) {
        if (this.league_id != league_id) {
          this.league_id = league_id;
          this.$refs.team_search.clear();
        }
      },
      setTeam(team) {
        if (team != null){
          this.team_id = team.id;
          if (this.league_id == '')
            this.league_id = team.competition_id;
          this.$refs.league_search.search = team.competition_name;
          console.log(team)
        }
      },
      getSearchResultsRole(role, searchTerm) {
        this.flushSearchResults();
        switch (role) {
          case 'team':
            this.getSearchResultsTeams({
              searchTerm,
              league: this.league_id
            });
            break;
          case 'competition':
            this.getSearchResultsCompetition({
              searchTerm
            });
            break;
          default:
            this.getSearchResults({
              searchTerm,
              role,
              team: this.team_id
            });
            break;
        }
      },
      startReport() {
        this.prepareReport(this.type, this.player_id, this.team_id, this.job_id);
      }
    }
  };
</script>
