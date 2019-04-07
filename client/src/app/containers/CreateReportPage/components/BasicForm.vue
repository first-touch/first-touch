<template>
  <form class="report-type-form" @submit.prevent>
    <div class="form-group row">
      <label class="col-lg-3 col-form-label">Select report type</label>
      <div class="col-lg-6">
        <vselect v-model="chosenReportType" :options="options.reportType" :searchable="false" :clearable="false" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-lg-3 col-form-label">Select a League</label>
      <div class="col-lg-6">
        <vselect v-model="competition" :onSearch="searchCompetitions" label="name" :options="options.competitions" :searchable="true" :clearable="true" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-lg-3 col-form-label">Select a Club</label>
      <div class="col-lg-6">
        <vselect v-model="club" :onSearch="searchClubs" label="team_name" :options="options.clubs" :searchable="true" :clearable="true" :taggable="true"/>
      </div>
    </div>
    <!-- <div class="form-group row" v-if="type == 'player'">
      <label class="col-lg-3 col-form-label" :class="type == 'player' ? 'required' : ''">Select a Player</label>
      <inputsearch class="col-lg-6" v-if="team_id != ''" placeholder="Player is" :taggable="true" :onkeyup="getSearchResultsRole"
        :searchResult="searchResult" type="player" label="display_name" v-on:update:val="player_id = $event" v-on:update:search="search.player = $event"
      />
    </div> -->
    <div class="form-group row" v-if="isTeamReport">
      <label class="col-lg-3 col-form-label">Select a Team</label>
      <div class="col-lg-6">
        <team-select v-on:update:val="category = $event" placeholder="Team is"></team-select>
      </div>
    </div>
    <div class="buttons-inner col-lg-12 row">
      <button class="bar-button ft-button">Cancel</button>
      <button v-if="isPlayerReport" class="ft-button" :disabled="player_id == ''" @click="startReport">Create Report for a player</button>
      <button v-if="isTeamReport" class=" ft-button" :disabled="team_id == '' || category == ''" @click="startReport">Create Report for a team</button>
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
        category: '',
        club: {},
        competition: {},
        player_id: '',
        search: {
          player: '',
          league: '',
          club: ''
        },
        chosenReportType: '',
        options: {
          reportType: [
            { label: 'Player', value: 'player' },
            { label: 'Team', value: 'team' }
          ],
          competitions: [],
          clubs: []
        }
      };
    },
    computed: {
      ...mapGetters(['searchResult']),
      reportType() {
        if (this.chosenReportType)
          return this.chosenReportType.value;
        return '';
      },
      isTeamReport() {
        return this.reportType == "team";
      },
      isPlayerReport() {
        return this.reportType == "player";
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
      setPlayer(player_id) {
        if (this.player_id != player_id) {
          this.player_id = player_id;
          if (this.player_id > 0) this.search.player = ''
        }
      },
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
          this.options.teams = res;
          loading(false);
        });
      },
      getSearchResultsRole(role, searchTerm) {
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
        this.prepareReport(this.reportType, ids, this.search);
      }
    }
  };
</script>
