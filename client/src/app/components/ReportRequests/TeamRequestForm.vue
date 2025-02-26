<template>
  <div class="container">
    <div class="float-right">
      <button id="cancel" name="cancel" class="btn btn-secondary" @click="handleCancel">Cancel</button>
    </div>
    <form @submit.prevent class="team-request ft-form">
      <div class="content">
        <ul class="error" v-if="errors">
          <li v-for="(error) in errors.errors" v-bind:key="error.id">
            {{ error }}
          </li>
        </ul>
        <div class="row created_at" v-if="isEdit">
          <label class="col-lg-3">Request created on</label>
          <p class="col-lg-9">{{edit.created_at | moment}}</p>
        </div>

        <h5 class="row">The Scouting Target</h5>
        <div class="row">
          <div class="col-lg-6 form-group required-before">
            <input-search
              ref="team_search"
              class="col-lg-12"
              :taggable="true"
              :onkeyup="getSearchResultsRole"
              :searchResult="searchResult"
              type="competition"
              v-on:update:val="setLeague($event)" v-on:update:search="meta_data.search.league = $event"
              placeholder="Select a league" label="name"
              :edit="leagueEditInfo"
              />
            <input type="text" class="d-none" name="league" v-model="league_id" v-validate="'required'" />
            <span class="text-danger">{{ errors.first('league') }}</span>
          </div>
          <div class="col-lg-6 form-group required-before">
            <input-search
              :readonly="league_id == ''"
              class="col-lg-12"
              :taggable="true"
              :onkeyup="getSearchResultsRole"
              placeholder="Select a club"
              ref="team_search"
              v-on:update:search="meta_data.search.club = $event"
              :searchResult="searchResult"
              type="team"
              v-on:update:obj="setClub($event)"
              :required="true"
              label="team_name"
              :edit="teamEditInfo"
              />
            <input type="text" class="d-none" name="club" v-model="team_id" v-validate="'required'" />
            <span class="text-danger">{{ errors.first('club') }}</span>
          </div>
          <div class="col-lg-6 form-group required-before">
            <team-select
              @input="updateClubTeam"
              :readonly="team_id == ''"
              placeholder="Select a team"
              :value="isEdit && edit.meta_data.team ? edit.meta_data.team : ''"/>
            <input type="text" class="d-none" name="team" v-model="meta_data.team" v-validate="'required'" />
            <span class="text-danger">{{ errors.first('team') }}</span>
          </div>
        </div>
        <h5 class="row">Your Scouting Requirements</h5>
        <div class="row">
          <div class="col-lg-12 form-group required-before">
            <input type="number" min="0" class="col-lg-12 form-control" v-model.number="meta_data.min_matches" name="min_match" v-validate="'required|max_value:9'"
              placeholder="Select number of matches to be observed">
            <span class="text-danger">{{ errors.first('min_match') }}</span>
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
            <ftdatepicker class="col-lg-12 form-control" :disabledDates="disabledDates" :value="deadline" v-on:update:val="deadline = $event" placeholder="Select a deadline"
            />
            <input type="text" class="d-none" name="deadline" v-model="deadline" v-validate="'required|date_format:yyyy-MM-dd'" />
            <span class="text-danger">{{ errors.first('deadline') }}</span>
          </div>
        </div>
        <div class="col-lg-12 form-group row required-before">
          <div class="row col-lg-12 bid-range">
            <currencyinput :value="price" :noHyphen="true" max="true" maxValue="999999" placeholder="Desired bid range" class="col" />
            <span class="bid-range-icon-inner" v-b-tooltip.hover placement="topleft" title="Bid level reflects your appetite to spend on reports and is for reference only. Scouts determine their own rates, so the actual rate you pay is up to you and the Scout.">
              <icon name='question-circle'></icon>
            </span>
            <input type="text" class="d-none" name="price" v-model="price.value" v-validate="'required'" />
            <input type="text" class="d-none" name="price" v-model="price.max" v-validate="'required'" />
          </div>
          <span class="text-danger row">{{ errors.first('price') }}</span>

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
      </div>
    </form>
  </div>
</template>

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
  import InputSearch from 'app/components/Input/InputSearch';
  import vSelect from 'vue-select';
  import CurrencyInput from 'app/components/Input/CurrencyInput';
  import TeamSelect from 'app/components/Input/TeamSelect';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import Icon from 'vue-awesome/components/Icon';
  import 'vue-awesome/icons/question-circle';
  export default {
    name: 'PlayerJobRequest',
    props: ['submit', 'serverErrors', 'edit', 'cancelAction'],
    components: {
      InputSearch,
      vselect: vSelect,
      currencyinput: CurrencyInput,
      ftdatepicker: FtDatepicker,
      TeamSelect,
      Icon,
    },
    data() {
      return {
        disabledDates: {
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
      ...mapGetters(['searchResult']),

      isEdit(){
        return (this.edit && 'id' in this.edit);
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
      if (this.edit && "id" in this.edit) {
        let request = this.edit;
        this.meta_data = this.edit.meta_data;
        this.deadline = this.edit.deadline;
        this.price = this.edit.price;

        let search = request.meta_data.search;
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

        const index = this.$options.filters.searchInObj(
          this.options.required,
          option => option.value === this.edit.meta_data.training_report
        );
        if (index > 0){
          this.training_report_select = this.options.required[index];
        }
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
      setClub(club) {
        this.team_id = ''
        if (club != null) {
          this.team_id = club.id;
          if (club.id == -1) {} else {
            this.meta_data.search.club = '';
          }
        }
      },
      updateClubTeam(team){
        if (team){
          this.meta_data.team = team.value;
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

            const request = {
              meta_data: this.meta_data,
              deadline: this.deadline,
              team_id: this.team_id,
              league_id: this.league_id,
              price: this.price,
              type_request: 'team',
              status
            }

            if (this.edit){ request.id = this.edit.id; }

            this.$emit('submit', request);
          }
        }).catch(() => {

        });
      },

      handleCancel() {
        this.$emit('cancel');
      }
    }
  };
</script>
