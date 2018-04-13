<template>
  <div>
    <h4 v-if="!edit" class="header">New Position Job</h4>
    <h4 v-if="edit" class="header">Edit Position Job</h4>
    <timeline-item>
      <form @submit.prevent class="position-request">
        <div class="content">
          <ul class="error" v-if="errors">
            <li v-for="(error) in errors.errors" v-bind:key="error.id">
              {{ error }}
            </li>
          </ul>

          <div class="row">
            <div class="col-sm-4 form-group">
              <label class="col-md-12">Height Range (Cm)</label>
              <div class="col-md-12 row">
                <input type="number" class="col-sm-5 form-control" v-model="meta_data.min_heigth">
                <span class="separator col-sm-2">—</span>
                <input type="number" class="col-sm-5 form-control" v-model="meta_data.max_heigth">
              </div>
            </div>
            <div class="col-sm-4 form-group">
              <label class="col-md-12">Weight Range (Kg)</label>
              <div class="col-md-12 row">
                <input type="number" class="col-sm-5 form-control" v-model="meta_data.min_weight">
                <span class="separator col-sm-2">—</span>
                <input type="number" class="col-sm-5 form-control" v-model="meta_data.max_weight">
              </div>
            </div>
            <div class="col-sm-4 form-group">
              <label class="col-md-12">Age Range</label>
              <div class="col-md-12 row">
                <input type="number" class="col-sm-5 form-control" v-model="meta_data.age_min">
                <span class="separator col-sm-2">—</span>
                <input type="number" class="col-sm-5 form-control" v-model="meta_data.age_max">
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-sm-6 form-group">
              <label class="col-md-12">Position(s)</label>
              <playerposition class="col-md-12" :value="meta_data.playing_position" v-on:update:val="meta_data.playing_position = $event"
              />
            </div>
            <div class="col-sm-6 form-group">
              <label class="col-md-12">Preferred Foot</label>
              <preferredfoot class="col-md-12" :value="meta_data.preferred_foot" v-on:update:val="meta_data.preferred_foot = $event" />
            </div>
          </div>
          <div class="row">
            <div class="col-sm-7 form-group">
              <label class="col-md-12">Language(s) Spoken</label>
              <language class="col-md-12" :value="meta_data.languages" v-on:update:val="meta_data.languages = $event" />
            </div>
            <div class="col-sm-5 form-group">
              <label class="col-md-12">Nationality</label>
              <countryselect class="col-md-12" :value="meta_data.nationality_country_code" v-on:update:val="meta_data.nationality_country_code = $event"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 form-group">
              <label class="col-sm-12">Based In</label>
              <countryselect class="col-sm-12" :value="meta_data.residence_country_code" v-on:update:val="meta_data.residence_country_code = $event"
              />
            </div>
            <div class="col-sm-6 form-group">
              <label class="col-sm-12">Passport (Eligibility)</label>
              <input type="text" class="col-sm-12 form-control" v-model="meta_data.passport">
            </div>
          </div>

          <fieldset class="form-group col-md-12 availability">
            <label class="col-sm-3 label">Availability</label>
            <div class="col-sm-12">
              <label class="col-sm-12 interested col-form-label" :class="meta_data.transfer == 'true' ? 'active' : ''">
                <span class="title">Interested in Transfer ?</span>
                <i class="sub-menu-arrow" :class="meta_data.transfer == 'true' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="meta_data.transfer" v-on:update:val="meta_data.transfer = $event" />
              </label>
              <transition name="fade">
                <div class="transfer-value col-sm-12 row" v-if="meta_data.transfer === 'true'">
                  <input type="number" class="col-sm-3" v-model="meta_data.transfer_min" :disabled="!meta_data.transfer">
                  <span class="separator col-sm-2">—</span>
                  <input type="number" class="col-sm-3" v-model="meta_data.transfer_max" :disabled="!meta_data.transfer">
                </div>
              </transition>
            </div>
            <div class="col-sm-12">
              <label class="col-sm-12 interested col-form-label" :class="meta_data.loan == 'true' ? 'active' : ''">
                <span class="title">Interested in Loan ?</span>
                <i class="sub-menu-arrow" :class="meta_data.loan == 'true' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="meta_data.loan" v-on:update:val="meta_data.loan = $event" />
              </label>
              <transition name="fade">
                <div class="transfer-value col-sm-12 row" v-if="meta_data.loan === 'true'">
                  <input type="number" class="col-sm-3" v-model="meta_data.loan_min">
                  <span class="separator col-sm-2">—</span>
                  <input type="number" class="col-sm-3" v-model="meta_data.loan_max">
                </div>
              </transition>
            </div>
            <div class=" col-md-8">
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
            <label class="col-sm-3">Desirable Attributes</label>
            <textarea class="col-sm-4" v-model="meta_data.desirable_attributes" />
          </fieldset>

          <fieldset class="form-group col-md-12 filter">
            <label class="col-sm-3">Additional Comments</label>
            <textarea class="col-sm-4" v-model="meta_data.comments" />
          </fieldset>

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

        </div>
      </form>
    </timeline-item>
  </div>
</template>
<style lang="scss">
@import '~stylesheets/variables';
.position-request {
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
  .separator {
    text-align: center;
  }
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
  .form-group {
    padding: 0;
  }
}
</style>

<script>
import inputSearch from 'app/components/Input/InputSearch.vue';
import PlayerPosition from 'app/components/Input/PlayerPosition';
import Nationality from 'app/components/Input/Nationality';
import Language from 'app/components/Input/Language';
import PreferredFoot from 'app/components/Input/PreferredFoot';
import FtCheckbox from 'app/components/Input/FtCheckbox';
import Datepicker from 'vuejs-datepicker';
import TimelineItem from 'app/components/TimelineItem';
import CurrencyInput from 'app/components/Input/CurrencyInput';
import VueAutonumeric from 'vue-autonumeric/src/components/VueAutonumeric.vue';
import 'vue-awesome/icons/calendar-alt';
import 'vue-awesome/icons/calendar-check';
import 'vue-awesome/icons/times';
import Icon from 'vue-awesome/components/Icon';
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
    icon: Icon,
    ftcheckbox: FtCheckbox,
    'timeline-item': TimelineItem,
    currencyinput: CurrencyInput,
    autonumeric: VueAutonumeric
  },
  data() {
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
      price: {
        value: 0,
        currency: 'USD',
        max: 0
      }
    };
  },
  created() {
    if (this.edit) {
      this.meta_data = this.edit.meta_data;
      this.deadline = this.edit.deadline;
      this.min_price = this.edit.min_price;
      this.max_price = this.edit.max_price;
    }
  },
  methods: {
    showCalendar: function(index) {
      this.$refs.datepicker.showCalendar();
    },
    handleSubmit() {
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
