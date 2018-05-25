<template>
  <div>
    <h4 v-if="!edit" class="header">New Player Job</h4>
    <h4 v-if="edit" class="header">Edit Player Job</h4>
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
        <div class="row" v-if="!edit">
          <div class="col-lg-4 form-group">
            <label class="col-lg-12">League Name</label>
            <inputsearch :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="competition" v-on:update:val="setLeague($event)"
              ref="league_search" :taggable="true" label="name" v-on:update:search="meta_data.search.league = $event"
            />
          </div>
          <div class="col-lg-4 form-group">
            <label class="col-lg-12">Team Name</label>
            <inputsearch :readonly="league_id == ''" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="team" ref="team_search"
              :taggable="true" v-on:update:obj="setTeam($event)"  label="team_name" v-on:update:search="meta_data.search.team = $event"
            />
          </div>
          <div class="col-lg-4 form-group">
            <label class="col-lg-12 required">Player Name </label>
            <inputsearch :readonly="team_id == ''" :taggable="true" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="player"
              label="display_name" v-on:update:val="setPlayer($event)" v-on:update:search="meta_data.search.player = $event"
              :required="true" />
          </div>
        </div>
        <div class="player-summary" v-if="player_id == -1">
          <div class="row">
            <div class="col-lg-4 form-group">
              <label class="col-lg-12 col-form-label">Age</label>
              <input type="number" min="0" class="col-lg-12 form-control" v-model="meta_data.age">
            </div>
            <div class="col-lg-4 form-group">
              <label class="col-lg-12 col-form-label">Nationality</label>
              <countryselect class="col-lg-12" :value="meta_data.nationality_country_code" v-on:update:val="meta_data.nationality_country_code = $event"
              />
            </div>
            <div class="col-lg-4 form-group">
              <label class="col-lg-12 col-form-label">Based In</label>
              <countryselect class="col-lg-12" :value="meta_data.residence_country_code" v-on:update:val="meta_data.residence_country_code = $event"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-lg-7 form-group">
              <label class="col-lg-12">Language(s)</label>
              <language class="col-lg-12" :value="meta_data.languages" v-on:update:val="meta_data.languages = $event" />
            </div>
            <div class="col-lg-5 form-group">
              <label class="col-lg-12">Position(s)</label>
              <playerposition class="col-lg-12" :value="meta_data.playing_position" v-on:update:val="meta_data.playing_position = $event"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-lg-6 form-group">
              <label class="col-lg-12">Preferred Foot</label>
              <preferredfoot class="col-lg-12" :value="meta_data.preferred_foot" v-on:update:val="meta_data.preferred_foot = $event" />
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-lg-6 form-group">
            <label class="col-lg-12">Minimum number of Matches observed</label>
            <input type="number" min="0" class="col-lg-12 form-control" v-model="meta_data.min_matches">
          </div>
          <div class="col-lg-6 form-group">
            <label class="col-lg-12">Training Report Required</label>
            <vselect v-model="training_report_select" @input="meta_data.training_report = training_report_select.value" :options="options.required"
              :searchable="false" />
          </div>
        </div>

        <div class="row col-lg-12 form-group">
          <label class="col-lg-12">Additional Comments</label>
          <textarea class="col-lg-12 form-control" v-model="meta_data.comments"  v-autosize="meta_data.comments" />
        </div>

        <div class="row col-lg-12 form-group">
          <label class="col-lg-12 required">Deadline</label>
          <ftdatepicker class="col-lg-3 form-control" :disabled="disabled" :value="deadline" v-on:update:val="deadline = $event" ref="deadline"
          />
        </div>
        <div class="row col-lg-12 form-group">
          <label class="col-lg-12">Price Range</label>
          <currencyinput :value="price" max="true" />
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
          label: 'No',
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
          value: 0,
          currency: 'USD',
          max: 0
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
