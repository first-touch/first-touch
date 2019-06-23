<template>
  <div class="container">
    <div class="float-right">
      <button id="cancel" name="cancel" class="btn btn-secondary" @click="handleCancel">Cancel</button>
    </div>
    <form @submit.prevent class="player-request ft-form">
      <ul class="error" v-if="errors">
        <li v-for="(error) in errors.errors" v-bind:key="error.id">
          {{ error }}
        </li>
      </ul>
      <div class="row created_at" v-if="isEdit">
        <label class="col-lg-3">Request created on</label>
        <p class="col-lg-9">{{edit.created_at | moment}}</p>
      </div>

      <h5 class="row" >The Scouting Target</h5>
      <div class="row">
        <div class="col col-lg-12 form-group required-before">
          <inputsearch
              ref="league_search"
              placeholder="Choose a league..."
              :onkeyup="getSearchResultsRole"
              :searchResult="searchResult"
              type="competition"
              :taggable="true"
              label="name"
              v-on:update:search="meta_data.search.league = $event"
              v-on:update:val="setLeague($event)"
              :edit="leagueEditInfo"
          />
          <input type="text" class="d-none" name="league" v-model="league_id" v-validate="'required'" />
          <span class="text-danger">{{ errors.first('league') }}</span>
        </div>
        <div class="col col-lg-12 form-group required-before">
          <inputsearch
            :readonly="league_id == ''"
            :onkeyup="getSearchResultsRole"
            :searchResult="searchResult"
            type="team"
            ref="team_search"
            :taggable="true"
            v-on:update:obj="setTeam($event)"
            label="team_name"
            v-on:update:search="meta_data.search.club = $event"
            placeholder="Choose a team..."
            :edit="teamEditInfo"
          />
          <input type="text" class="d-none" name="team" v-model="team_id" v-validate="'required'" />
          <span class="text-danger">{{ errors.first('team') }}</span>
        </div>
        <div class="col col-lg-12 form-group required-before">
          <inputsearch
            :readonly="team_id == ''"
            :taggable="true"
            :onkeyup="getSearchResultsRole"
            :searchResult="searchResult"
            type="player"
            label="display_name"
            v-on:update:val="setPlayer($event)"
            v-on:update:search="meta_data.search.player = $event"
            placeholder="Choose a player..."
            :required="true"
            :edit="playerEditInfo"
            />
          <input type="text" class="d-none" name="player" v-model="player_id" v-validate="'required'" />
          <span class="text-danger">{{ errors.first('player') }}</span>
        </div>
      </div>

      <div class="player-summary" v-if="player_id == -1">
        <h5 class="row">{{ $t("requests.new_player_entry") }}</h5>
        <div class="row">
          <div class="col-lg-4 form-group">
            <input type="number" min="0" class="col-lg-12 form-control" v-model.number="meta_data.age" placeholder="Age">
          </div>
          <div class="col-lg-4 form-group">
            <countryselect :value="meta_data.nationality_country_code" placeholder="Nationality is" v-on:update:val="meta_data.nationality_country_code = $event"
            />
          </div>
          <div class="col-lg-4 form-group">
            <countryselect :value="meta_data.residence_country_code" placeholder="Based in" v-on:update:val="meta_data.residence_country_code = $event"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-lg-7 form-group">
            <language :value="meta_data.languages" placeholder="Speaking languages are" v-on:update:val="meta_data.languages = $event"
            />
          </div>
          <div class="col-lg-5 form-group">
            <playerposition :value="meta_data.playing_position" placeholder="Positions are" v-on:update:val="meta_data.playing_position = $event"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-lg-6 form-group">
            <preferredfoot :value="meta_data.preferred_foot" placeholder="Preferred foot is" v-on:update:val="meta_data.preferred_foot = $event" />
          </div>
        </div>
      </div>

      <h5 class="row">Your Scouting Requirements</h5>
      <div class="row">

        <div class="col-lg-12 form-group required-before">
          <input type="number" min="0" class="col-lg-12 form-control" v-validate="'required|max_value:9'" v-model.number="meta_data.min_matches"
            name="min_match" placeholder="Select number of matches to be observed">
          <span class="text-danger">{{ errors.first('min_match') }}</span>

        </div>

        <div class="col-lg-12 form-group">
          <vselect v-model="training_report_select"
                   @input="meta_data.training_report = training_report_select.value"
                   :options="options.required"
                   placeholder="Select whether the report should include training observations"
                   :searchable="false"
          />
        </div>

        <div class="col-lg-12 form-group required-before">
          <ftdatepicker class="col-lg-12 form-control" :disabled="disabledDates" :value="deadline" v-on:update:val="deadline = $event" ref="deadline"
            placeholder="Select a deadline" />
          <input type="text" class="d-none" name="deadline" v-model="deadline" v-validate="'required|date_format:yyyy-MM-dd'" />
          <span class="text-danger">{{ errors.first('deadline') }}</span>
        </div>
        <div class="col-lg-12 form-group required-before">
          <div class="row bid-range col-lg-12">
            <currencyinput :value="price" max="true" :noHyphen="true" maxValue="999999" placeholder="Desired bid range" class="col" />
            <span class="bid-range-icon-inner" v-b-tooltip.hover placement="topleft" title="Bid level reflects your appetite to spend on reports and is for reference only. Scouts determine their own rates, so the actual rate you pay is up to you and the Scout.">
              <icon name='question-circle'></icon>
            </span>
            <input type="text" class="d-none" name="price" v-model="price.value" v-validate="'required'" />
            <input type="text" class="d-none" name="price" v-model="price.max" v-validate="'required'" />
          </div>
          <span class="text-danger">{{ errors.first('price') }}</span>
        </div>
      </div>
      <h5 class="row">Other Details</h5>
      <div class="row col-lg-12 form-group">
        <textarea class="col-lg-12 form-control" v-model="meta_data.comments" v-autosize="meta_data.comments" placeholder="Add comments"
        />
      </div>
      <div class="form-group float-right">
        <button v-if="!isEdit" id="submit" class="btn btn-success" @click="handleSubmit('publish')">Publish</button>
        <button v-if="isEdit" id="submit" class="btn btn-success" @click="handleSubmit(null)">Update</button>
        <button v-if="!isEdit" id="submit" class="btn btn-secondary" @click="handleSubmit(null)">Save & Exit</button>
      </div>
    </form>
  </div>
</template>
<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .select-player {
    .col {
      padding-left: 0;
    }
  }

  h5 {
    margin-bottom: 20px;
  }

  .bid-range {
    .bid-range-icon-inner {
      display: flex;
      align-items: center;
      justify-content: center;
      .fa-icon {
        color: $main-header-color;
      }
    }
  }
</style>

<script>
  const initialState = () => {
    return {
        player: {},
        league_id: '',
        team_id: '',
        player_id: '',
        disabledDates: {
          to: new Date()
        },
        training_report_select: {
          label: 'Select whether the report should include training observations',
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
            club: '',
            player: ''
          }
        },
        price: {
          value: null,
          currency: 'USD',
          max: null
        },
        deadline: '',
        dictionary: {
          en: {
            attributes: {
              min_match: 'number of match',
              min_bid: 'bid range'
            }
          }
        }
      };
  }
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import inputSearch from 'app/components/Input/InputSearch';
  import PlayerPosition from 'app/components/Input/PlayerPosition';
  import Nationality from 'app/components/Input/Nationality';
  import Language from 'app/components/Input/Language';
  import PreferredFoot from 'app/components/Input/PreferredFoot';
  import TimelineItem from 'app/components/TimelineItem';
  import vSelect from 'vue-select';
  import CurrencyInput from 'app/components/Input/CurrencyInput';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import Icon from 'vue-awesome/components/Icon';
  import 'vue-awesome/icons/question-circle';
  export default {
    name: 'player-request-form',
    props: ['edit'],
    components: {
      inputsearch: inputSearch,
      playerposition: PlayerPosition,
      countryselect: Nationality,
      language: Language,
      preferredfoot: PreferredFoot,
      vselect: vSelect,
      currencyinput: CurrencyInput,
      ftdatepicker: FtDatepicker,
      icon: Icon,
    },
    data() {
      return initialState();
    },
    computed: {
      ...mapGetters(['searchResult']),
      isEdit(){
        return (this.edit && 'id' in this.edit);
      },
      playerEditInfo(){
        if (!this.isEdit) return false;
        let request = this.edit;

        if (this.player_id == -1){
          return { search: request.meta_data.search.player, id: -1 }
        } else {
          return { search: request.player.name, id: request.player.id }
        }
      },
      leagueEditInfo(){
        if (!this.isEdit) return false;
        let request = this.edit;

        if (this.edit.league){
          return { search: request.league.name, id: request.league.id }
        } else {
          return { search: request.meta_data.search.league, id: -1 }
        }
      },
      teamEditInfo(){
        if (!this.isEdit) return false;
        let request = this.edit;

        if (this.edit.team){
          return { search: request.team.team_name, id: request.team.id }
        } else {
          return { search: request.meta_data.search.club, id: -1 }
        }
      }
    },
    created() {

      if (this.edit && this.edit.id != null) {
        let request = this.edit;
        this.meta_data = request.meta_data;
        this.deadline = new Date(request.deadline);
        this.price = request.price;

        let search = request.meta_data.search;
        if (request.player){
          this.player_id = request.player.id;
        } else {
          this.player_id = -1;
        }

        if (request.league){
          this.league_id = request.league.id;
        } else if (search.league != ''){
          this.league_id = -1;
        }

        if (request.team){
          this.team_id = request.team.id;
        } else if (search.club != ''){
          this.team_id = -1;
        }
      }
      this.$validator.localize(this.dictionary);

    },
    methods: {
      ...mapActions([
        'getSearchResults',
        'getSearchResultsTeams',
        'getSearchResultsCompetition'
      ]),
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
            this.meta_data.search.club = '';
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
      handleSubmit(status) {
        this.$validator.validateAll().then(() => {
          if (this.errors.items.length == 0) {
            if (status == null) {
              status = this.isEdit ? this.edit.status : 'private';
            }
            var request = {
              meta_data: this.meta_data,
              deadline: this.deadline,
              price: this.price,
              type_request: 'player',
              status
            }

            if (this.edit){ request.id = this.edit.id; }

            if (!this.edit) {
              request = Object.assign(request, {
                player_id: this.player_id,
                league_id: this.league_id,
                team_id: this.team_id
              })
            }

            this.$emit('submit', request)
          }
        }).catch((err) => {
          console.error("Failed to submit player request", err);
        });

      },
      handleCancel(){
        this.$emit('cancel');
      }
    }
  };
</script>
