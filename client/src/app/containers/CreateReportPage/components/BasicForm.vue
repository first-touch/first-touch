<template>
  <form class="report-type-form ft-form" @submit.prevent>
    <div class="form-group row">
      <label class="col-lg-3 col-form-label required">Select report type</label>
      <vselect v-model="vselect_type" class="col-lg-6 form-control" :options="options.type_report" :class="type == '' ? 'empty' : '' "
        :searchable="false" clearable="false" />
    </div>
    <div class="form-group row">
      <label class="col-lg-3 col-form-label">Select a League</label>
      <inputsearch class="col-lg-6" :onkeyup="getSearchResultsRole" placeholder="League is" :required="team_id == -1" :searchResult="searchResult"
        type="competition" v-on:update:val="setLeague($event)" ref="league_search" :taggable="true" label="name" v-on:update:search="search.league = $event"
      />
    </div>
    <div class="form-group row">
      <label class="col-lg-3 col-form-label" :class="type == 'team' ? 'required' : ''">Select a Club</label>
      <inputsearch class="col-lg-6" v-if="league_id != ''" placeholder="Club is" :onkeyup="getSearchResultsRole" :searchResult="searchResult"
        type="team" ref="team_search" :taggable="true" v-on:update:obj="setTeam($event)" label="team_name" v-on:update:search="search.club = $event"
      />
    </div>
    <div class="form-group row" v-if="type == 'player'">
      <label class="col-lg-3 col-form-label" :class="type == 'player' ? 'required' : ''">Select a Player</label>
      <inputsearch class="col-lg-6" v-if="team_id != ''" placeholder="Player is" :taggable="true" :onkeyup="getSearchResultsRole"
        :searchResult="searchResult" type="player" label="display_name" v-on:update:val="player_id = $event" v-on:update:search="search.player = $event"
      />
    </div>
    <div class="form-group row" v-if="team_id != '' && type == 'team'">
      <label class="col-lg-3 col-form-label" >Select a Team</label>
      <team-select class="col-lg-6" v-on:update:val="category = $event" placeholder="Team is"></team-select>
    </div>
    <div class="buttons-inner col-lg-12 row">
      <button class="bar-button ft-button">Cancel</button>
      <button v-if="type == 'player'" class="ft-button" :disabled="player_id == ''" @click="startReport">Create Report for a player</button>
      <button v-if="type == 'team'" class=" ft-button" :disabled="team_id == '' || category == ''" @click="startReport">Create Report for a team</button>
    </div>
  </form>
</template>
<style lang="scss">
  @import '~stylesheets/variables';
  @import '~stylesheets/form';

  .report-type-form {
    .buttons-inner {
      display: flex;
      flex-direction: row-reverse;
      .ft-button {
        margin-right: 5%;
      }
    }
  }
</style>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import vSelect from 'vue-select';
  import TeamSelect from 'app/components/Input/TeamSelect';
  import inputSearch from 'app/components/Input/InputSearch';

  export default {
    name: 'ReportBasicForm',
    props: ['prepareReport'],
    components: {
      inputsearch: inputSearch,
      vselect: vSelect,
      'team-select': TeamSelect,
    },
    data() {
      return {
        player_report: false,
        team_report: false,
        job_type: 'independent',
        category: '',
        team_id: '',
        league_id: '',
        player_id: '',
        search: {
          player: '',
          league: '',
          club: ''
        },
        vselect_type: {
          label: 'Select a report type',
          value: ''
        },
        options: {
          type_report: [
            {
              label: 'Player',
              value: 'player'
            },
            {
              label: 'Team',
              value: 'team'
            }
          ]
        }
      };
    },
    computed: {
      ...mapGetters(['searchResult']),
      type() {
        if (this.vselect_type)
          return this.vselect_type.value;
        return '';
      }
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
          this.team_id = '';
          if (this.$refs.team_search) this.$refs.team_search.clear();
          if (this.league_id > 0) this.search.league = ''
        }
      },
      setTeam(team) {
        if (team != null) {
          this.team_id = team.id;
          if (team.id == -1) {} else {
            this.league_id = team.competition_id;
            this.$refs.league_search.search = team.competition_name;
            this.search.club = ''
          }
        }
      },
      setPlayer(player_id) {
        if (this.player_id != player_id) {
          this.player_id = player_id;
          if (this.player_id > 0) this.search.player = ''
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
        var ids = {
          player: this.player_id > 0 ? this.player_id : '',
          team: this.team_id > 0 ? this.team_id : '',
          league: this.league_id > 0 ? this.league_id : '',
          category: this.category
        }
        this.prepareReport(this.type, ids, this.search);
      }
    }
  };
</script>
