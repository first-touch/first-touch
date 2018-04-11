<template>
  <div>
    <form @submit.prevent>
      <div class="content">
        <ul class="error" v-if="errors">
          <li v-for="(error) in errors.errors" v-bind:key="error.id">
            {{ error }}
          </li>
        </ul>
        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Select Position</label>
          <playerposition class="col-sm-9" :value="meta_data.playing_position" v-on:update:val="meta_data.playing_position = $event"
          />
        </fieldset>

        <fieldset class="form-group col-md-12 availability">
          <label class="col-sm-3 label">Availability</label>
          <div class="blocks col-md-8">
            <div class="block col-md-12">
              <label class="col-sm-3">
                <input type="checkbox" name="transfer" v-model="meta_data.transfer">Transfer</label>
              <div class="block-input">
                <input type="number" class="col-sm-3" v-model="meta_data.transfer_min" :disabled="!meta_data.transfer">
                <span class="separator">—</span>
                <input type="number" class="col-sm-3" v-model="meta_data.transfer_max" :disabled="!meta_data.transfer">
              </div>
            </div>
            <div class="block  col-md-12">
              <label class="col-sm-3">
                <input type="checkbox" name="transfer" v-model="meta_data.loan">Loan</label>
              <div class="block-input">
                <input type="number" class="col-sm-3" v-model="meta_data.loan_min" :disabled="!meta_data.loan">
                <span class="separator">—</span>
                <input type="number" class="col-sm-3" v-model="meta_data.loan_max" :disabled="!meta_data.loan">
              </div>
            </div>
            <div class="block col-md-12">
              <label class="col-sm-3">
                <input type="checkbox" name="transfer" v-model="meta_data.free_agent">Free Agent</label>
            </div>
            <div class="block col-md-12">
              <label class="col-sm-3">
                <input type="checkbox" name="transfer" v-model="meta_data.expiring_contract">Expiring Contract</label>
              <div class="block-input">
                <input type="number" class="col-sm-3" v-model="meta_data.expiring_contract_min" :disabled="!meta_data.expiring_contract">
                <span class="separator">—</span>
                <input type="number" class="col-sm-3" v-model="meta_data.expiring_contract_max" :disabled="!meta_data.expiring_contract">
              </div>
            </div>
          </div>
        </fieldset>

        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Transfer Budget (in SGD)</label>
          <input type="number" class="col-sm-4" v-model="meta_data.transfer_budget">
        </fieldset>

        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Wage Budget per year (in SGD)</label>
          <input type="number" class="col-sm-4" v-model="meta_data.wage_budget">
        </fieldset>
        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Age</label>
          <input type="number" class="col-sm-1" v-model="meta_data.age_min">
          <span class="separator">—</span>
          <input type="number" class="col-sm-1" v-model="meta_data.age_max">
        </fieldset>

        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Desirable Attributes</label>
          <textarea class="col-sm-4" v-model="meta_data.desirable_attributes" />
        </fieldset>

        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Based In</label>
          <countryselect class="col-sm-4" :value="meta_data.residence_country_code" v-on:update:val="meta_data.residence_country_code = $event"
          />
        </fieldset>

        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Height (Cm)</label>
          <input type="number" class="col-sm-1" v-model="meta_data.min_heigth">
          <span class="separator">—</span>
          <input type="number" class="col-sm-1" v-model="meta_data.max_heigth">
        </fieldset>

        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Weight (kg) </label>
          <input type="number" class="col-sm-1" v-model="meta_data.min_weight">
          <span class="separator">—</span>
          <input type="number" class="col-sm-1" v-model="meta_data.max_weight">
        </fieldset>

        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Language Spoken</label>
          <language class="col-sm-9" :value="meta_data.languages" v-on:update:val="meta_data.languages = $event" />
        </fieldset>

        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Nationality</label>
          <countryselect class="col-sm-4" :value="meta_data.nationality_country_code" v-on:update:val="meta_data.nationality_country_code = $event"
          />
        </fieldset>

        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Paspport (Eligibility)</label>
          <input type="text" class="col-sm-4" v-model="meta_data.passport">
        </fieldset>

        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Preferred Foot</label>
          <preferredfoot class="col-sm-4" :value="meta_data.preferred_foot" v-on:update:val="meta_data.preferred_foot = $event" />
        </fieldset>

        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Report Deadline</label>
          <datepicker :input-class="[deadline != '' ? 'selected': '', 'input-date'].join(' ')" v-model="deadline" class="datepicker col-sm-4"
           format="dd,MMM yyyy"></datepicker>
        </fieldset>

        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Additional Comments</label>
          <textarea class="col-sm-4" v-model="meta_data.comments" />
        </fieldset>

        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-3">Price Range</label>
          <input type="number" class="col-sm-1" v-model="min_price" />
          <span class="separator">—</span>
          <input type="number" class="col-sm-1" v-model="max_price" />
        </fieldset>

        <div class="form-group buttons">
          <button v-if="!edit" id="submit" class="btn btn-primary" @click="handleSubmit"> CREATE</button>
          <button v-if="edit" id="submit" class="btn btn-primary" @click="handleSubmit"> UPDATE</button>
          <button id="cancel" name="cancel" class="btn btn-default"  @click="cancelAction" >CANCEL</button>
        </div>

      </div>
    </form>
  </div>
</template>
<style lang="scss">
.datepicker {
  background: white;
  float: left;
  padding: 0;
  input.input-date {
    width: 100%;
    cursor: pointer;
    height: 2.5em;
    background: white;
    background: url('/images/calendar.png') no-repeat;
    background-size: 3em 2.5em;
    background-position: right;
    &.selected {
      background: url('/images/calendar-fill.png') no-repeat;
      background-size: 3em 2.5em;
      background-position: right;
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
  .availability {
    .label {
      float: left;
    }
    .blocks {
      float: left;
      padding: 0;
      .block {
        padding: 0;
        overflow: hidden;
        label {
          float: left;
          padding: 0;
          max-width: 140px;
        }
        .block-input {
          float: left;
          padding-left: 10px;
          input {
            padding: 0;
          }
        }
      }
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
  h5 {
    margin-top: 20px;
  }
  .player-summary {
    margin-bottom: 30px;
  }
  .form-group {
    display: inline-block;
  }
  .filter {
    label {
      float: left;
    }
    input {
      float: left;
    }
    .separator {
      float: left;
      margin: 0 10px;
    }
    .radio-group {
      label {
        width: 10%;
      }
    }
  }
}
</style>

<script>
import inputSearch from 'app/components/Input/InputSearch.vue';
import PlayerPosition from 'app/components/Input/PlayerPosition';
import Nationality from 'app/components/Input/Nationality';
import Language from 'app/components/Input/Language';
import PreferredFoot from 'app/components/Input/PreferredFoot';
import Datepicker from 'vuejs-datepicker';
export default {
  name: 'PlayerJobRequest',
  props: ['submit', 'errors', 'edit', 'cancelAction'],
  components: {
    inputsearch: inputSearch,
    playerposition: PlayerPosition,
    countryselect: Nationality,
    language: Language,
    preferredfoot: PreferredFoot,
    datepicker: Datepicker
  },
  data () {
    return {
      meta_data: {
        playing_position: [],
        languages: [],
        expiring_contract: false,
        free_agent: false,
        transfer: false,
        loan: false
      },
      deadline: '',
      min_price: 0,
      max_price: ''
    };
  },
  created () {
    if (this.edit) {
      this.meta_data = this.edit.meta_data;
      this.deadline = this.edit.deadline;
      this.min_price = this.edit.min_price;
      this.max_price = this.edit.max_price;
    }
  },
  methods: {
    handleSubmit () {
      this.submit({
        meta_data: this.meta_data,
        deadline: this.deadline,
        min_price: this.min_price,
        max_price: this.max_price,
        type_request: 'position',
        status: 'publish'
      });
    }
  }
};
</script>
