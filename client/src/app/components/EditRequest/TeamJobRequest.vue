<template>
  <div>
    <h4 v-if="!edit" class="header">Creating Team ASSIGNMENT</h4>
    <h4 v-if="edit" class="header">Editing Team ASSIGNMENT</h4>
    <timeline-item>
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
          <div class="row" v-if="!edit">
            <div class="col-lg-6 form-group">
              <inputsearch class="col-lg-12" :taggable="true" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="competition"
                v-on:update:val="setLeague($event)" v-on:update:search="meta_data.search.league = $event" ref="team_search"
                placeholder="League is" label="name" />
            </div>
            <div class="col-lg-6 form-group">
              <inputsearch :edit="team_search" :readonly="league_id == ''" class="col-lg-12" :taggable="true" :onkeyup="getSearchResultsRole"
                placeholder="Team is" ref="team_search" v-on:update:search="meta_data.search.team = $event" :searchResult="searchResult"
                type="team" v-on:update:obj="setTeam($event)" :required="true" label="team_name" />
            </div>
          </div>

          <div class="row">
            <div class="col-lg-6 form-group">
              <input type="number" min="0" class="col-lg-12 form-control" v-model="meta_data.min_matches" placeholder="Minimum of Matches observed">
            </div>
            <div class="col-lg-6 form-group">
              <vselect v-model="training_report_select" @input="meta_data.training_report = training_report_select.value" :options="options.required"
                :searchable="false" />
            </div>
          </div>
          <div class="row col-lg-12 form-group">
            <textarea class="col-lg-12 form-control" v-model="meta_data.comments" v-autosize="meta_data.comments"  placeholder="Any additional comments" />
          </div>
          <div class="row col-lg-12 form-group">
            <ftdatepicker class="col-lg-6 form-control" :disabled="disabled" :value="deadline" v-on:update:val="deadline = $event" placeholder="Deadline" />
          </div>
          <div class="col-lg-12 form-group">
            <currencyinput :value="price" max="true" placeholder="Bid between" placeholder1="And" />
          </div>
          <div class="form-group buttons-inner row">
            <button v-if="!edit" id="submit" class="ft-button ft-button-success" :disabled="!canValidate" @click="handleSubmit"> CREATE</button>
            <button v-if="edit" id="submit" class="ft-button ft-button-success" :disabled="!canValidate" @click="handleSubmit"> UPDATE</button>
            <button id="cancel" name="cancel" class="ft-button" @click="cancelAction">CANCEL</button>
          </div>
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
  import vSelect from 'vue-select';
  import CurrencyInput from 'app/components/Input/CurrencyInput';
  import TimelineItem from 'app/components/TimelineItem';
  import FtDatepicker from 'app/components/Input/FtDatepicker';

  export default {
    name: 'PlayerJobRequest',
    props: ['submit', 'errors', 'edit', 'cancelAction'],
    components: {
      inputsearch: inputSearch,
      vselect: vSelect,
      currencyinput: CurrencyInput,
      'timeline-item': TimelineItem,
      ftdatepicker: FtDatepicker
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
          label: 'Training Report required',
          value: 'no'
        },
        meta_data: {
          training_report: 'no',
          search: {
            league: '',
            team: ''
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
        }
      };
    },
    computed: {
      ...mapGetters(['searchResult']),
      canValidate() {
        if (this.team_id == '') return false;
        if (this.deadline == '') return false;
        return true;
      }
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
    },
    methods: {
      ...mapActions(['getSearchResultsTeams', 'getSearchResultsCompetition', 'flushSearchResults']),
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
      showCalendar: function (index) {
        this.$refs.datepicker.showCalendar();
      },
      handleSubmit() {
        this.submit({
          meta_data: this.meta_data,
          deadline: this.deadline,
          team_id: this.team_id,
          price: this.price,
          type_request: 'team',
          status: 'publish'
        });
      }
    }
  };
</script>
