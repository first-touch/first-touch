<template>
  <div>
    <h4 v-if="!edit" class="header">New Player Job</h4>
    <h4 v-if="edit" class="header">Edit Player Job</h4>
    {{this.edit}}
    <timeline-item>
      <form @submit.prevent class="player-request ft-form">
        <ul class="error" v-if="errors">
          <li v-for="(error) in errors.errors" v-bind:key="error.id">
            {{ error }}
          </li>
        </ul>
        <div class="row">
          <div class="col-sm-4 form-group">
            <label class="col-md-12">League Name</label>
            <inputsearch class="col-md-12" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="league" v-on:update:val="meta_data.league_id = $event"
            /> </div>
          <div class="col-sm-4 form-group">
            <label class="col-md-12">Team Name</label>
            <inputsearch class="col-md-12" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="team" v-on:update:val="meta_data.team_id = $event"
            /> </div>
          <div class="col-sm-4 form-group">
            <label class="col-md-12 required">Player Name</label>
            <inputsearch class="col-md-12" :onkeyup="getSearchResultsRole" :edit="player" :searchResult="searchResult" type="player"
              taggable="true" :required="true" v-on:update:val="meta_data.player_id = $event" v-on:update:search="meta_data.player_name = $event"
            />
          </div>
        </div>
        <div class="player-summary row">
          <div class="col-sm-4 form-group">
            <label class="col-md-12 col-form-label">Age</label>
            <input type="number" class="col-md-12 form-control" v-model="meta_data.age">
          </div>
          <div class="col-sm-4 form-group">
            <label class="col-md-12 col-form-label">Nationality</label>
            <countryselect class="col-md-12" :value="meta_data.nationality_country_code" v-on:update:val="meta_data.nationality_country_code = $event"
            />
          </div>
          <div class="col-sm-4 form-group">
            <label class="col-md-12 col-form-label">Based In</label>
            <countryselect class="col-md-12" :value="meta_data.residence_country_code" v-on:update:val="meta_data.residence_country_code = $event"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-sm-7 form-group">
            <label class="col-md-12">Language(s)</label>
            <language class="col-md-12" :value="meta_data.languages" v-on:update:val="meta_data.languages = $event" />
          </div>
          <div class="col-sm-5 form-group">
            <label class="col-md-12">Position(s)</label>
            <playerposition class="col-md-12" :value="meta_data.playing_position" v-on:update:val="meta_data.playing_position = $event"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-sm-6 form-group">
            <label class="col-md-12">Preferred Foot</label>
            <preferredfoot class="col-md-12" :value="meta_data.preferred_foot" v-on:update:val="meta_data.preferred_foot = $event" />
          </div>
        </div>

        <div class="row">
          <div class="col-sm-6 form-group">
            <label class="col-md-12">Minimum number of Matches observed</label>
            <input type="number" class="col-md-12 form-control" v-model="meta_data.min_matches">
          </div>
          <div class="col-md-6 form-group">
            <label class="col-md-12">Training Report Required</label>
            <vselect v-model="training_report_select" @input="meta_data.training_report = training_report_select.value" :options="options.required"
              :searchable="false" />
          </div>
        </div>

        <div class="row col-md-12 form-group">
          <label class="col-md-12">Additional Comments</label>
          <textarea class="col-md-12 form-control" v-model="meta_data.comments" />
        </div>

        <div class="row col-md-12 form-group">
          <label class="col-md-12 required">Deadline</label>
          <ftdatepicker class="col-md-3 form-control" :disabled="disabled" :value="deadline" v-on:update:val="deadline = $event" />
        </div>
        <div class="row col-md-12 form-group">
          <label class="col-md-12">Price Range</label>
          <currencyinput :value="price" max="true" />
        </div>
        <div class="form-group buttons-inner">
          <button v-if="!edit" id="submit" class="btn btn-primary ft-button" @click="handleSubmit">CREATE</button>
          <button v-if="edit" id="submit" class="btn btn-primary ft-button" @click="handleSubmit">UPDATE</button>
          <button id="cancel" name="cancel" class="btn btn-default ft-button" @click="cancelAction">CANCEL</button>
        </div>
      </form>
    </timeline-item>

  </div>
</template>
<style lang="scss">
@import '~stylesheets/form';
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
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
      disabled: {
        to: new Date()
      },
      training_report_select: {
        label: 'No',
        value: 'no'
      },
      meta_data: {
        team_id: '',
        league_id: '',
        player_id: '',
        training_report: 'no',
        languages: [],
        playing_position: []
      },
      price: {
        value: 0,
        currency: 'USD',
        max: 0
      },
      options: {
        required: [
          {
            label: 'No',
            value: 'no'
          },
          {
            label: 'Yes',
            value: 'yes'
          }
        ]
      },
      deadline: ''
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
      if (this.player) {
        this.player.id = this.edit.player.id;
        this.player.search = this.edit.player.first_name + ' ' + this.edit.player.last_name;
      }
    }
  },
  watch: {
    'price.max': function(newVal, oldVal) {
      this.price.value = this.price.value > this.price.max ? this.price.max : this.price.value;
    }
  },
  methods: {
    ...mapActions(['getSearchResults']),
    updatePrice() {
      this.price.max = this.price.value > this.price.max ? this.price.value : this.price.max;
    },
    getSearchResultsRole(role, term) {
      this.getSearchResults({
        searchTerm: term,
        role: role
      });
    },
    showCalendar: function(index) {
      this.$refs.datepicker.showCalendar();
    },
    handleSubmit() {
      this.submit({
        meta_data: this.meta_data,
        deadline: this.deadline,
        price: this.price,
        type_request: 'player',
        status: 'publish'
      });
    }
  }
};
</script>
