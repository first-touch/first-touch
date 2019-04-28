<template>
  <div>
    <h4 v-if="!edit" class="header">Creating Team ASSIGNMENT</h4>
    <h4 v-if="edit" class="header">Editing Team ASSIGNMENT</h4>
    <timeline-item>
      <div class="form-group buttons-inner row">
        <button id="cancel" name="cancel" class="ft-button ft-button-right" @click="cancelAction">CANCEL</button>
      </div>
      <form @submit.prevent class="team-request ft-form">
        <div class="content">
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
            <div class="col-lg-6 form-group required-before">
              <inputsearch class="col-lg-12" :taggable="true" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="competition"
                v-on:update:val="setLeague($event)" v-on:update:search="meta_data.search.league = $event" ref="team_search"
                placeholder="Select a league" label="name" />
              <input type="text" class="hide" name="league" v-model="league_id" v-validate="'required'" />
              <span class="validate-errors">{{ errors.first('league') }}</span>
            </div>
            <div class="col-lg-6 form-group required-before">
              <inputsearch :edit="team_search" :readonly="league_id == ''" class="col-lg-12" :taggable="true" :onkeyup="getSearchResultsRole"
                placeholder="Select a club" ref="team_search" v-on:update:search="meta_data.search.club = $event" :searchResult="searchResult"
                type="team" v-on:update:obj="setClub($event)" :required="true" label="team_name" />
              <input type="text" class="hide" name="club" v-model="team_id" v-validate="'required'" />
              <span class="validate-errors">{{ errors.first('club') }}</span>
            </div>
            <div class="col-lg-6 form-group required-before">
              <team-select v-on:update:val="meta_data.team = $event" :readonly="team_id == '' " placeholder="Select a team"></team-select>
              <input type="text" class="hide" name="team" v-model="meta_data.team" v-validate="'required'" />
              <span class="validate-errors">{{ errors.first('team') }}</span>
            </div>
          </div>
          <h5 class="row">Your Scouting Requirements</h5>
          <div class="row">
            <div class="col-lg-12 form-group required-before">
              <input type="number" min="0" class="col-lg-12 form-control" v-model.number="meta_data.min_matches" name="min_match" v-validate="'required|max_value:9'"
                placeholder="Select number of matches to be observed">
              <span class="validate-errors">{{ errors.first('min_match') }}</span>
            </div>
          </div>
          <div class="row">
            <div class="col-lg-12 form-group">
              <vselect v-model="training_report_select" @input="meta_data.training_report = training_report_select.value" :options="options.required"
                placeholder="Select whether the report should include training observations" :searchable="false" />
            </div>
          </div>
          <div class="row">
            <div class="col-lg-12 form-group required-before">
              <ftdatepicker class="col-lg-12 form-control" :disabled="disabled" :value="deadline" v-on:update:val="deadline = $event" placeholder="Select a deadline"
              />
              <input type="text" class="hide" name="deadline" v-model="deadline" v-validate="'required|date_format'" />
              <span class="validate-errors">{{ errors.first('deadline') }}</span>
            </div>
          </div>
          <div class="col-lg-12 form-group row required-before">
            <div class="row col-lg-12 bid-range">
              <currencyinput :value="price" :noHyphen="true" max="true" maxValue="999999" placeholder="Desired bid range" class="col" />
              <span class="bid-range-icon-inner" v-b-tooltip.hover placement="topleft" title="Bid level reflects your appetite to spend on reports and is for reference only. Scouts determine their own rates, so the actual rate you pay is up to you and the Scout.">
                <icon name='question-circle'></icon>
              </span>
              <input type="text" class="hide" name="price" v-model="price.value" v-validate="'required'" />
              <input type="text" class="hide" name="price" v-model="price.max" v-validate="'required'" />
            </div>
            <span class="validate-errors row">{{ errors.first('price') }}</span>

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
        </div>
      </form>
    </timeline-item>
  </div>
</template>

<style lang="scss">
  @import '~stylesheets/form';
</style>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

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
  import vSelect from 'vue-select';
  import CurrencyInput from 'app/components/Input/CurrencyInput';
  import TeamSelect from 'app/components/Input/TeamSelect';
  import TimelineItem from 'app/components/TimelineItem';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import Icon from 'vue-awesome/components/Icon';
  import 'vue-awesome/icons/question-circle';
  export default {
    name: 'PlayerJobRequest',
    props: ['submit', 'serverErrors', 'edit', 'cancelAction'],
    components: {
      inputsearch: inputSearch,
      vselect: vSelect,
      currencyinput: CurrencyInput,
      'timeline-item': TimelineItem,
      ftdatepicker: FtDatepicker,
      'team-select': TeamSelect,
      icon: Icon,
    },
    data() {
      return {
        disabled: {
          to: new Date()
        },
        team_id: '',
        league_id: '',
        team_search: '',
        training_report_select: {
          label: 'Select whether the report should include training observations',
          value: 'no'
        },
        meta_data: {
          training_report: 'no',
          team: '',
          search: {
            league: '',
            club: ''
          }
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
        deadline: '',
        price: {
          value: null,
          currency: 'USD',
          max: null
        },
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
        this.deadline = this.edit.deadline;
        this.price = this.edit.price;
        const index = this.$options.filters.searchInObj(
          this.options.required,
          option => option.value === this.edit.meta_data.training_report
        );
        if (index > 0)
          this.training_report_select = this.options.required[index];
      }
      this.$validator.localize(this.dictionary);

    },
    methods: {
      ...mapActions(['getSearchResultsTeams', 'getSearchResultsCompetition']),
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
      setClub(team) {
        this.team_id = ''
        if (team != null) {
          this.team_id = team.id;
          if (team.id == -1) {} else {
            this.meta_data.search.club = '';
          }
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
            this.submit({
              meta_data: this.meta_data,
              deadline: this.deadline,
              team_id: this.team_id,
              league_id: this.league_id,
              price: this.price,
              type_request: 'team',
              status
            });
          }
        }).catch(() => {

        });
      }
    }
  };
</script>
