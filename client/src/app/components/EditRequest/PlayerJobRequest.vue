<template>
  <div>
    <h4 v-if="!edit" class="header">New Player Job</h4>
    <h4 v-if="edit" class="header">Edit Player Job</h4>
    <timeline-item>
      <form @submit.prevent class="player-request">
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
            <label class="col-md-12">Player Name</label>
            <inputsearch class="col-md-12" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="player" v-on:update:val="meta_data.player_id = $event"
            />
          </div>
        </div>
        <div class="player-summary row">
          <div class="col-sm-4 form-group">
            <label class="col-md-12 col-form-label">Age</label>
            <input type="number" class="col-md-12 form-control" v-model="meta_data.player_info.age">
          </div>
          <div class="col-sm-4 form-group">
            <label class="col-md-12 col-form-label">Nationality</label>
            <countryselect class="col-md-12" :value="meta_data.player_info.nationality_country_code" v-on:update:val="meta_data.player_info.nationality_country_code = $event"
            />
          </div>
          <div class="col-sm-4 form-group">
            <label class="col-md-12 col-form-label">Based In</label>
            <countryselect class="col-md-12" :value="meta_data.player_info.residence_country_code" v-on:update:val="meta_data.player_info.nationality_country_code = $event"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-sm-7 form-group">
            <label class="col-md-12">Language(s)</label>
            <language class="col-md-12" :value="meta_data.player_info.languages" v-on:update:val="meta_data.player_info.languages = $event"
            />
          </div>
          <div class="col-sm-5 form-group">
            <label class="col-md-12">Position(s)</label>
            <playerposition class="col-md-12" :value="meta_data.player_info.playing_position" v-on:update:val="meta_data.player_info.playing_position = $event"
            />
          </div>
        </div>
        <div class="row">
          <div class="col-sm-6 form-group">
            <label class="col-md-12">Preferred Foot</label>
            <preferredfoot class="col-md-12" :value="meta_data.player_info.preferred_foot" v-on:update:val="meta_data.player_info.preferred_foot = $event"
            />
          </div>
        </div>

        <div class="row">
          <div class="col-sm-6 form-group">
            <label class="col-md-12">Minimum number of Matches observed</label>
            <input type="number" class="col-md-12 form-control" v-model="meta_data.min_matches">
          </div>
          <div class="col-md-6 form-group">
            <label class="col-md-12">Training Report Required</label>
            <vselect v-model="meta_data.player_info.training_report" :options="options.required" :searchable="false" />
          </div>
        </div>

        <div class="row col-md-12 form-group">
          <label class="col-md-12">Additional Comments</label>
          <textarea class="col-md-12 form-control" v-model="meta_data.comments" />
        </div>

        <div class="row col-md-12 form-group">
          <label class="col-md-12">Deadline</label>
          <div class="col-md-3 form-control" :class="deadline != '' ? 'date-selected': ''">
            <datepicker ref="datepicker" :input-class="[deadline != '' ? 'selected': '', 'input-date'].join(' ')" v-model="deadline"
              class="datepicker col-sm-10" format="dd,MMM yyyy"></datepicker>
            <span @click="deadline = ''" class="icon-inner">
              <icon name='times' v-if="deadline!= ''"></icon>
            </span>
            <span @click="showCalendar()" class="icon-inner">
              <icon name='calendar-alt' v-if="deadline == ''"></icon>
              <icon name='calendar-check' v-if="deadline != ''"></icon>
            </span>
          </div>
        </div>
        <div class="row col-md-12 form-group">
          <label class="col-md-12">Price Range</label>
          <currencyinput :value="price" v-on:update="updatePrice()">
            <span class="separator">—</span>
            <autonumeric class="form-control" v-model="price.max" :options="{
         digitGroupSeparator: '.',
         decimalCharacter: ',',
         decimalCharacterAlternative: '.',
         roundingMethod: 'U',
         minimumValue: '0'
     }" />
          </currencyinput>

        </div>
        <div class="form-group buttons">
          <button v-if="!edit" id="submit" class="btn btn-primary" @click="handleSubmit"> CREATE</button>
          <button v-if="edit" id="submit" class="btn btn-primary" @click="handleSubmit"> UPDATE</button>
          <button id="cancel" name="cancel" class="btn btn-default" @click="cancelAction">CANCEL</button>
        </div>
      </form>
    </timeline-item>

  </div>
</template>
<style lang="scss">
@import '~stylesheets/variables';

.player-request {
  .ft-input {
    padding: 0;
  }
  .datepicker {
    background: white;
    display: inline-block;
    input.input-date {
      color: $main-text-color;
      cursor: pointer;
      width: 100%;
      border: 0px;
      height: 2.3em;
      background: white;
    }
  }
}
</style>
<style lang="scss" scoped>
@import '~stylesheets/variables';
form {
  background: $form-background;
  color: $main-text-color;
  padding: 40px 40px 80px 40px;

  .icon-inner {
    cursor: pointer;
    &:hover {
      color: $secondary-header-color;
    }
  }
  .btn {
    cursor: pointer;
  }
  .error {
    li {
      color: red;
      display: list-item;
      list-style: disc;
      &:first-letter {
        text-transform: capitalize;
      }
    }
  }
  .buttons {
    float: right;
  }
  .player-summary {
    margin-bottom: 30px;
  }
  .form-group {
    padding: 0;
  }
}
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import inputSearch from 'app/components/Input/InputSearch.vue';
import PlayerPosition from 'app/components/Input/PlayerPosition';
import Nationality from 'app/components/Input/Nationality';
import Language from 'app/components/Input/Language';
import PreferredFoot from 'app/components/Input/PreferredFoot';
import Datepicker from 'vuejs-datepicker';
import TimelineItem from 'app/components/TimelineItem';
import vSelect from 'vue-select';
import 'vue-awesome/icons/calendar-alt';
import 'vue-awesome/icons/calendar-check';
import 'vue-awesome/icons/times';
import Icon from 'vue-awesome/components/Icon';
import CurrencyInput from 'app/components/Input/CurrencyInput';
import VueAutonumeric from 'vue-autonumeric/src/components/VueAutonumeric.vue';

export default {
  name: 'PlayerJobRequest',
  props: ['submit', 'errors', 'edit', 'cancelAction'],
  components: {
    inputsearch: inputSearch,
    playerposition: PlayerPosition,
    countryselect: Nationality,
    language: Language,
    preferredfoot: PreferredFoot,
    datepicker: Datepicker,
    'timeline-item': TimelineItem,
    vselect: vSelect,
    icon: Icon,
    currencyinput: CurrencyInput,
    autonumeric: VueAutonumeric
  },
  data() {
    return {
      meta_data: {
        team_id: '',
        league_id: '',
        player_id: '',
        player_info: {
          training_report: false,
          training_report: {
            label: 'No',
            value: 'no'
          },
          languages: [],
          playing_position: []
        }
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
      this.min_price = this.edit.min_price;
      this.max_price = this.edit.max_price;
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
        min_price: this.min_price,
        max_price: this.max_price,
        type_request: 'player',
        status: 'publish'
      });
    }
  }
};
</script>
