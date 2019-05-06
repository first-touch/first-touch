<template>
<div class="container">
    <div class="form-group buttons-inner row">
      <button id="cancel" name="cancel" class="ft-button ft-button-right" @click="handleCancel">CANCEL</button>
    </div>
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

      <h5 class="row" v-if="!edit">The Scouting Target</h5>
      <div class="row" v-if="!edit">
        <div class="col col-lg-12 form-group required-before">
          <inputsearch :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="competition" v-on:update:val="setLeague($event)"
            ref="league_search" :taggable="true" label="name" v-on:update:search="meta_data.search.league = $event" placeholder="Choose a league..."
          />
          <input type="text" class="hide" name="league" v-model="league_id" v-validate="'required'" />
          <span class="text-danger">{{ errors.first('league') }}</span>
        </div>
        <div class="col col-lg-12 form-group required-before">
          <inputsearch :readonly="league_id == ''" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="team" ref="team_search"
            :taggable="true" v-on:update:obj="setTeam($event)" label="team_name" v-on:update:search="meta_data.search.club = $event"
            placeholder="Choose a team..." />
          <input type="text" class="hide" name="team" v-model="team_id" v-validate="'required'" />
          <span class="text-danger">{{ errors.first('team') }}</span>
        </div>
        <div class="col col-lg-12 form-group required-before">
          <inputsearch :readonly="team_id == ''" :taggable="true" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="player"
            label="display_name" v-on:update:val="setPlayer($event)" v-on:update:search="meta_data.search.player = $event"
            placeholder="Choose a player..." :required="true" />
          <input type="text" class="hide" name="player" v-model="player_id" v-validate="'required'" />
          <span class="text-danger">{{ errors.first('player') }}</span>
        </div>
      </div>
      <div class="player-summary" v-if="player_id == -1">
        <div class="row">
          <div class="col-lg-4 form-group">
            <input type="number" min="0" class="col-lg-12 form-control" v-model.number="meta_data.age" placeholder="Age">
          </div>
          <div class="col-lg-4 form-group">
            <countryselect class="col-lg-12" :value="meta_data.nationality_country_code" placeholder="Nationality is" v-on:update:val="meta_data.nationality_country_code = $event"
            />
          </div>
          <div class="col-lg-4 form-group">
            <countryselect class="col-lg-12" :value="meta_data.residence_country_code" placeholder="Based in" v-on:update:val="meta_data.residence_country_code = $event"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-lg-7 form-group">
            <language class="col-lg-12" :value="meta_data.languages" placeholder="Speaking languages are" v-on:update:val="meta_data.languages = $event"
            />
          </div>
          <div class="col-lg-5 form-group">
            <playerposition class="col-lg-12" :value="meta_data.playing_position" placeholder="Positions are" v-on:update:val="meta_data.playing_position = $event"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-lg-6 form-group">
            <preferredfoot class="col-lg-12" :value="meta_data.preferred_foot" placeholder="Preferred foot is" v-on:update:val="meta_data.preferred_foot = $event"
            />
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
          <vselect v-model="training_report_select" class="col-lg-12 form-control" @input="meta_data.training_report = training_report_select.value"
            :options="options.required" placeholder="Select whether the report should include training observations" :searchable="false"
          />
        </div>

        <div class="col-lg-12 form-group required-before">
          <ftdatepicker class="col-lg-12 form-control" :disabled="disabled" :value="deadline" v-on:update:val="deadline = $event" ref="deadline"
            placeholder="Select a deadline" />
          <input type="text" class="hide" name="deadline" v-model="deadline" v-validate="'required|date_format'" />
          <span class="text-danger">{{ errors.first('deadline') }}</span>
        </div>
        <div class="col-lg-12 form-group required-before">
          <div class="row bid-range col-lg-12">
            <currencyinput :value="price" max="true" :noHyphen="true" maxValue="999999" placeholder="Desired bid range" class="col" />
            <span class="bid-range-icon-inner" v-b-tooltip.hover placement="topleft" title="Bid level reflects your appetite to spend on reports and is for reference only. Scouts determine their own rates, so the actual rate you pay is up to you and the Scout.">
              <icon name='question-circle'></icon>
            </span>
            <input type="text" class="hide" name="price" v-model="price.value" v-validate="'required'" />
            <input type="text" class="hide" name="price" v-model="price.max" v-validate="'required'" />
          </div>
          <span class="text-danger">{{ errors.first('price') }}</span>
        </div>
      </div>
      <h5 class="row">Other Details</h5>
      <div class="row col-lg-12 form-group">
        <textarea class="col-lg-12 form-control" v-model="meta_data.comments" v-autosize="meta_data.comments" placeholder="Add comments"
        />
      </div>
      <div class="form-group buttons-inner row">
        <button v-if="!edit" id="submit" class="ft-button ft-button-success" @click="handleSubmit('publish')">Publish</button>
        <button v-if="edit" id="submit" class="ft-button ft-button-success"  @click="handleSubmit(null)">UPDATE</button>
        <button v-if="!edit" id="submit" class="ft-button ft-button-success" @click="handleSubmit(null)">Save & Exit</button>
      </div>
    </form>
</div>
</template>
<style lang="scss">
  @import '~stylesheets/form';
</style>
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
      return {
        player: {},
        league_id: '',
        team_id: '',
        player_id: '',
        disabled: false,/*{
          to: new Date()
        },*/
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
    },
    computed: {
      ...mapGetters(['searchResult'])
    },
    created() {
      if (this.edit) {
        this.meta_data = this.edit.meta_data;
        this.deadline = new Date(this.edit.deadline);
        this.price = this.edit.price;
        if (!this.edit.player)
          this.player_id = -1;
      }
      this.$validator.localize(this.dictionary);

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
              status = this.edit ? this.edit.status : 'private';
            }
            var request = {
              meta_data: this.meta_data,
              deadline: this.deadline,
              price: this.price,
              type_request: 'player',
              status
            }
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
