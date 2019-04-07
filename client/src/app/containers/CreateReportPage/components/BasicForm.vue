<template>
  <form class="report-type-form" @submit.prevent>
    <div class="form-group row">
      <label class="col-lg-3 col-form-label">Select report type</label>
      <div class="col-lg-6">
        <vselect placeholder="Choose the report type" v-model="reportType" :options="options.reportType" :searchable="false" :clearable="false" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-lg-3 col-form-label">Select a League</label>
      <div class="col-lg-6">
        <vselect placeholder="Search for the competition" v-model="competition" :onSearch="searchCompetitions" label="name" :options="options.competitions" :searchable="true" :clearable="true" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-lg-3 col-form-label">Select a Club</label>
      <div class="col-lg-6">
        <vselect placeholder="Search for the club" v-model="club" :disabled="missingLeague" :onSearch="searchClubs" label="team_name" :options="options.clubs" :searchable="true" :clearable="true" :taggable="true"/>
      </div>
    </div>
    <div class="form-group row" v-if="isPlayerReport">
      <label class="col-lg-3 col-form-label">Select a Player</label>
      <div class="col-lg-6">
        <vselect placeholder="Search for the player" v-model="player" :disabled="missingClub" :onSearch="searchPlayers" label="display_name" :options="options.players" :searchable="true" :clearable="true" :taggable="true"/>
      </div>
    </div>
    <div class="form-group row" v-if="isTeamReport">
      <label class="col-lg-3 col-form-label">Select a Team</label>
      <div class="col-lg-6">
        <team-select v-model="team" :disabled="missingClub" placeholder="Choose a team"></team-select>
      </div>
    </div>
    <div class="buttons-inner row">
      <button class="btn btn-danger col-lg-1">Cancel</button>
      <button v-if="isPlayerReport" class="btn btn-primary ml-1 col-lg-3" :disabled="!player == ''" @click="startReport">Create Report for a player</button>
      <button v-if="isTeamReport" class="btn btn-primary ml-1 col-lg-3" :disabled="!team" @click="startReport">Create Report for a team</button>
    </div>
  </form>
</template>

<style lang="scss">
// NOTE: This will move to the main scss once we clean up the
// use of v-select
.v-select {
  background: #fff;
  border-radius: 0.25rem;
}

.v-select.single.open .selected-tag {
  position: relative;
}

.v-select.open .dropdown-toggle {
  border-color: #a8cb5c
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
        club: {},
        competition: {},
        team: '',
        player: {},
        search: {
          player: '',
          league: '',
          club: ''
        },
        reportType: '',
        options: {
          reportType: ['Player', 'Team'],
          competitions: [],
          clubs: [],
          players: []
        }
      };
    },
    computed: {
      ...mapGetters(['searchResult']),
      isTeamReport() {
        return this.reportType == "Team";
      },
      isPlayerReport() {
        return this.reportType == "Player";
      },
      missingLeague() {
        return !(this.competition && this.competition.id);
      },
      missingClub() {
        return !(this.club && this.club.id);
      },
      league_id() {
        console.log("remove this reference");
        return this.competition.id;
      },
      team_id() {
        console.log("remove this reference");
        return this.team.id;
      }
    },
    methods: {
      ...mapActions([
        'getSearchResults',
        'getSearchResultsTeams',
        'getSearchResultsCompetition',
      ]),
      searchCompetitions(searchTerm, loading) {
        loading(true);
        this.getSearchResultsCompetition({searchTerm}).then(res => {
          this.options.competitions = res;
          loading(false);
        });
      },
      searchClubs(searchTerm, loading) {
        loading(true);
        this.getSearchResultsTeams({
          searchTerm,
          league: this.competition.id
        }).then(res => {
          this.options.clubs = res;
          loading(false);
        });
      },
      searchPlayers(searchTerm, loading) {
        loading(true);
        this.getSearchResults({
          searchTerm,
          role: "player",
          team: this.club.id
        }).then(res => {
          this.options.players = res;
          loading(false);
        });
      },
      startReport() {
        var ids = {
          player: this.player_id > 0 ? this.player_id : '',
          team: this.team_id > 0 ? this.team_id : '',
          league: this.league_id > 0 ? this.league_id : '',
        }
        this.prepareReport(this.reportType, ids, this.search);
      }
    }
  };
</script>
