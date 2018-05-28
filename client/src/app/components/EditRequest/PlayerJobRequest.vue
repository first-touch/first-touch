<template>
  <div>
    <h4 v-if="!edit" class="header">Creating Player ASSIGNMENT</h4>
    <h4 v-if="edit" class="header">Editing Player ASSIGNMENT</h4>
    <timeline-item>
      <form @submit.prevent class="player-request ft-form">
        <ul class="error" v-if="errors">
          <li v-for="(error) in errors.errors" v-bind:key="error.id">
            {{ error }}
          </li>
        </ul>
        <div class="row created_at" v-if="edit">
          <label class="col-lg-3">Request created on</label>
          <p class="col-lg-9">{{edit.created_at | moment}}</p>
        </div>
        <h5 class="row">The Scouting Target</h5>
        <div class="select-player" v-if="!edit">
          <div class="col col-lg-6 form-group">
            <inputsearch :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="competition" v-on:update:val="setLeague($event)"
              ref="league_search" :taggable="true" label="name" v-on:update:search="meta_data.search.league = $event" placeholder="League is"
            />
          </div>
          <div class="col col-lg-6 form-group">
            <inputsearch :readonly="league_id == ''" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="team" ref="team_search"
              :taggable="true" v-on:update:obj="setTeam($event)"  label="team_name" v-on:update:search="meta_data.search.team = $event" placeholder="Team name is"
            />
          </div>
          <div class="col col-lg-6 form-group">
            <inputsearch :readonly="team_id == ''" :taggable="true" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="player"
              label="display_name" v-on:update:val="setPlayer($event)" v-on:update:search="meta_data.search.player = $event" placeholder="Player name is"
              :required="true" />
          </div>
        </div>
        <div class="player-summary" v-if="player_id == -1">
          <div class="row">
            <div class="col-lg-4 form-group">
              <input type="number" min="0" class="col-lg-12 form-control" v-model="meta_data.age" placeholder="Age">
            </div>
            <div class="col-lg-4 form-group">
              <countryselect class="col-lg-12" :value="meta_data.nationality_country_code"  placeholder="Nationality is"
              v-on:update:val="meta_data.nationality_country_code = $event"
              />
            </div>
            <div class="col-lg-4 form-group">
              <countryselect class="col-lg-12" :value="meta_data.residence_country_code" placeholder="Based in"
               v-on:update:val="meta_data.residence_country_code = $event"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-lg-7 form-group">
              <language class="col-lg-12" :value="meta_data.languages" placeholder="Speaking languages are"
               v-on:update:val="meta_data.languages = $event" />
            </div>
            <div class="col-lg-5 form-group">
              <playerposition class="col-lg-12" :value="meta_data.playing_position" placeholder="Positions are"
               v-on:update:val="meta_data.playing_position = $event"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-lg-6 form-group">
              <preferredfoot class="col-lg-12" :value="meta_data.preferred_foot"  placeholder="Preferred foot is"
               v-on:update:val="meta_data.preferred_foot = $event" />
            </div>
          </div>
        </div>
        <h5 class="row">Your Scouting Requirements</h5>
        <div class="row">
          <div class="col-lg-6 form-group">
            <input type="number" min="0" class="col-lg-12 form-control" v-model="meta_data.min_matches" placeholder="Minimum of Matches observed">
          </div>
          <div class="col-lg-6 form-group">
            <vselect v-model="training_report_select" @input="meta_data.training_report = training_report_select.value" :options="options.required"
            placeholder="Training Report required"
              :searchable="false" />
          </div>
        </div>
        <div class="row col-lg-12 form-group">
          <ftdatepicker class="col-lg-3 form-control" :disabled="disabled" :value="deadline" v-on:update:val="deadline = $event" ref="deadline" placeholder="Deadline"
          />
        </div>
        <div class="col-lg-12 form-group">
          <currencyinput :value="price" max="true" placeholder="Bid between" placeholder1="And"/>
        </div>
        <h5 class="row">Other Details</h5>
        <div class="row col-lg-12 form-group">
          <textarea class="col-lg-12 form-control" v-model="meta_data.comments"  v-autosize="meta_data.comments" placeholder="Any additional comments" />
        </div>
        <div class="form-group buttons-inner row">
          <button v-if="!edit" id="submit" class="ft-button ft-button-success"  :disabled="!canValidate" @click="handleSubmit">CREATE</button>
          <button v-if="edit" id="submit" class="ft-button ft-button-success"  :disabled="!canValidate" @click="handleSubmit">UPDATE</button>
          <button id="cancel" name="cancel" class="ft-button" @click="cancelAction">CANCEL</button>
        </div>
      </form>
    </timeline-item>

  </div>
</template>
<style lang="scss">
  @import '~stylesheets/variables';
  @import '~stylesheets/form';
</style>
<style lang="scss" scoped>
.select-player{
  .col{
    padding-left:0;
  }
}
h5{
      margin-bottom: 20px;
}
</style>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import inputSearch from 'app/components/Input/InputSearch.vue';
  import PlayerPosition from 'app/components/Input/PlayerPosition';
  import Nationality from 'app/components/Input/Nationality';
  import Language from 'app/components/Input/Language';
  import PreferredFoot from 'app/components/Input/PreferredFoot';
  import TimelineItem from 'app/components/TimelineItem';
  import vSelect from 'vue-select';
  import CurrencyInput from 'app/components/Input/CurrencyInput';
  import FtDatepicker from 'app/components/Input/FtDatepicker';

  export default {
    name: 'PlayerJobRequest',
    props: ['submit', 'errors', 'edit', 'cancelAction'],
    components: {
      inputsearch: inputSearch,
      playerposition: PlayerPosition,
      countryselect: Nationality,
      language: Language,
      preferredfoot: PreferredFoot,
      'timeline-item': TimelineItem,
      vselect: vSelect,
      currencyinput: CurrencyInput,
      ftdatepicker: FtDatepicker
    },
    data() {
      return {
        player: {},
        league_id: '',
        team_id: '',
        player_id: '',
        disabled: {
          to: new Date()
        },
        training_report_select: {
          label: 'Training Report required',
          value: 'no'
        },
        options: {
          required: [{
              label: 'No',
              value: 'no'
            },
            {
              label: 'Yes',
              value: 'yes'
            }
          ]
        },
        meta_data: {
          training_report: 'no',
          languages: [],
          playing_position: [],
          search: {
            league: '',
            team: '',
            player: ''
          }
        },
        price: {
          value: null,
          currency: 'USD',
          max: null
        },
        deadline: ''
      };
    },
    computed: {
      ...mapGetters(['searchResult']),
      canValidate() {
        if (this.player_id == '') return false;
        if (this.deadline == '') return false;
        return true;
      }
    },
    created() {
      if (this.edit) {
        this.meta_data = this.edit.meta_data;
        this.deadline = new Date(this.edit.deadline);
        this.price = this.edit.price;
        if (!this.edit.player)
          this.player_id = -1;
      }
    },
    methods: {
      ...mapActions([
        'getSearchResults',
        'flushSearchResults',
        'getSearchResultsTeams',
        'getSearchResultsCompetition'
      ]),
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
      setLeague(league_id) {
        if (this.league_id != league_id) {
          this.league_id = league_id;
          this.team_id = '';
          if (this.$refs.team_search) this.$refs.team_search.clear();
          if (this.league_id > 0) this.meta_data.search.league = '';
        }
      },
      setTeam(team) {
        this.team_id = ''
        if (team != null) {
          this.team_id = team.id;
          if (team.id == -1) {} else {
            this.meta_data.search.team = '';
          }
        }
      },
      setPlayer(player_id) {
        if (this.player_id != player_id) {
          this.player_id = player_id;
          if (this.player_id > 0) this.meta_data.search.player = '';
        }
      },
      showCalendar: function (index) {
        this.$refs.datepicker.showCalendar();
      },
      handleSubmit() {
        var request = {
          meta_data: this.meta_data,
          deadline: this.deadline,
          price: this.price,
          type_request: 'player',
          status: 'publish'
        }
        if (!this.edit) {
          request = Object.assign(request, {
            player_id: this.player_id,
            league_id: this.league_id,
            team_id: this.team_id
          })
        }
        this.submit(request);
      }
    }
  };
</script>
