<template>
  <form @submit.prevent>
    <div class="form-group row">
      <label class="col-lg-3 col-form-label">Select report type</label>
      <div class="col-lg-6">
        <v-select placeholder="Choose the report type" v-model="reportType" :options="options.reportType" :searchable="true" :clearable="true" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-lg-3 col-form-label">Select a League</label>
      <div class="col-lg-6">
        <v-select placeholder="Search for the competition" v-model="competition" :onSearch="searchCompetitions" label="name" :options="options.competitions" :searchable="true" :clearable="true" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-lg-3 col-form-label">Select a Club</label>
      <div class="col-lg-6">
        <v-select placeholder="Search for the club" v-model="club" :disabled="missingLeague" :onSearch="searchClubs" label="team_name" :options="options.clubs" :searchable="true" :clearable="true"/>
      </div>
    </div>
    <div class="form-group row" v-if="isPlayerReport">
      <label class="col-lg-3 col-form-label">Select a Player</label>
      <div class="col-lg-6">
        <v-select
          placeholder="Search for the player"
          v-model="player"
          :disabled="missingClub"
          :onSearch="searchPlayers"
          label="display_name"
          :options="options.players"
          :searchable="true"
          :clearable="true"
          :taggable="true"
        />
      </div>
    </div>
    <div class="buttons-inner row">
      <div class="col-sm-1 m-1">
        <button class="btn btn-danger">Cancel</button>
      </div>
      <div class="col-sm-3 m-1">
        <button v-if="isPlayerReport" class="btn btn-primary" :disabled="missingPlayer" @click="startReport">Create Report for a player</button>
        <button v-if="isTeamReport" class="btn btn-primary" :disabled="missingClub" @click="startReport">Create Report for a team</button>
      </div>
    </div>
  </form>
</template>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import VSelect from 'vue-select';

  export default {
    name: 'ReportBasicForm',
    props: ['prepareReport'],
    components: {
      VSelect
    },
    watch: {
      competition(newCompetition) {
        this.club = '';
        this.options.clubs = [];
      },
      club(newClub) {
        this.player = '';
        this.options.players = [];
      },
      player(chosenPlayer) {
        if(_.isObject(chosenPlayer)) return;

        let playerNames = chosenPlayer.split(' ');
        const lastName = playerNames.splice(playerNames.length-1, 1);
        const firstName = playerNames.splice(0, 1);
        const middleNames = playerNames.join(" ");
        this.player = {
          display_name: chosenPlayer,
          first_name: firstName,
          last_name: lastName,
          middle_name: middleNames,
          role_name: "player"
        }
      }
    },
    data() {
      return {
        player_report: false,
        team_report: false,
        job_type: 'independent',
        club: {
          team_name: ''
        },
        competition: {
          name: ''
        },
        team: {
          team_name: ''
        },
        player: {
          display_name: ''
        },
        reportType: undefined,
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
      missingPlayer() {
        return _.isEmpty(this.player);
      },
      missingLeague() {
        return !(this.competition && this.competition.id);
      },
      missingClub() {
        return !(this.club && this.club.id);
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
        const reportData = {
          type_report: this.reportType,
          team: { id: this.club.id },
          league: { id: this.competition.id },
          player: this.player
        }
        this.$emit('start-report', reportData);
      }
    }
  };
</script>
