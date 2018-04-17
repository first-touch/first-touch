<template>
  <div>
    <h4 v-if="!edit" class="header">New Position Job</h4>
    <h4 v-if="edit" class="header">Edit Position Job</h4>
    <timeline-item>
      <form @submit.prevent class="position-request ft-form">
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
                <input type="number" class="col-sm-5 form-control" v-model="report_data.min_heigth">
                <span class="separator col-sm-2">—</span>
                <input type="number" class="col-sm-5 form-control" v-model="report_data.max_heigth">
              </div>
            </div>
            <div class="col-sm-4 form-group">
              <label class="col-md-12">Weight Range (Kg)</label>
              <div class="col-md-12 row">
                <input type="number" class="col-sm-5 form-control" v-model="report_data.min_weight">
                <span class="separator col-sm-2">—</span>
                <input type="number" class="col-sm-5 form-control" v-model="report_data.max_weight">
              </div>
            </div>
            <div class="col-sm-4 form-group">
              <label class="col-md-12">Age Range</label>
              <div class="col-md-12 row">
                <input type="number" class="col-sm-5 form-control" v-model="report_data.age_min">
                <span class="separator col-sm-2">—</span>
                <input type="number" class="col-sm-5 form-control" v-model="report_data.age_max">
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-sm-6 form-group">
              <label class="col-md-12">Position(s)</label>
              <playerposition class="col-md-12" :value="report_data.playing_position" v-on:update:val="report_data.playing_position = $event"
              />
            </div>
            <div class="col-sm-6 form-group">
              <label class="col-md-12">Preferred Foot</label>
              <preferredfoot class="col-md-12" :value="report_data.preferred_foot" v-on:update:val="report_data.preferred_foot = $event"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-sm-7 form-group">
              <label class="col-md-12">Language(s) Spoken</label>
              <language class="col-md-12" :value="report_data.languages" v-on:update:val="report_data.languages = $event" />
            </div>
            <div class="col-sm-5 form-group">
              <label class="col-md-12">Nationality</label>
              <countryselect class="col-md-12" :value="report_data.nationality_country_code" v-on:update:val="report_data.nationality_country_code = $event"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 form-group">
              <label class="col-sm-12">Based In</label>
              <countryselect class="col-sm-12" :value="report_data.residence_country_code" v-on:update:val="report_data.residence_country_code = $event"
              />
            </div>
            <div class="col-sm-6 form-group">
              <label class="col-sm-12">Passport (Eligibility)</label>
              <input type="text" class="col-sm-12 form-control" v-model="report_data.passport">
            </div>
          </div>

          <div class="row">
            <label class="col-sm-3 label">Availability</label>
            <div class="col-sm-12">
              <label class="col-sm-12 ftcheckbox-inner col-form-label" :class="report_data.transfer == 'yes' ? 'active' : ''">
                <span class="title">Interested in Transfer ?</span>
                <i class="sub-menu-arrow" :class="report_data.transfer == 'yes' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="report_data.transfer" v-on:update:val="report_data.transfer = $event" />
              </label>
              <transition name="fade">
                <div class="transfer-value col-sm-12 row" v-if="report_data.transfer === 'yes'">
                  <currencyinput :value="report_data.transfer_range" max="true" />
                </div>
              </transition>
            </div>
            <div class="col-sm-12">
              <label class="col-sm-12 ftcheckbox-inner col-form-label" :class="report_data.loan == 'yes' ? 'active' : ''">
                <span class="title">Interested in Loan ?</span>
                <i class="sub-menu-arrow" :class="report_data.loan == 'yes' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="report_data.loan" v-on:update:val="report_data.loan = $event" />
              </label>
              <transition name="fade">
                <div class="transfer-value col-sm-12 row" v-if="report_data.loan === 'yes'">
                  <currencyinput :value="report_data.loan_range" max="true" />
                </div>
              </transition>
            </div>
            <div class="col-sm-12">
              <label class="col-sm-12 ftcheckbox-inner col-form-label" :class="report_data.expiring_contract == 'yes' ? 'active' : ''">
                <span class="title">Expiring Contract ?</span>
                <i class="sub-menu-arrow" :class="report_data.expiring_contract == 'yes' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="report_data.expiring_contract" v-on:update:val="report_data.expiring_contract = $event"
                />
              </label>
              <transition name="fade">
                <div class="transfer-value col-sm-12 row" v-if="report_data.expiring_contract === 'yes'">
                  <ftdatepicker class="col-md-4 form-control" :value="report_data.expiring_contract_min" v-on:update:val="report_data.expiring_contract_min = $event"
                  />
                  <span class="separator">—</span>
                  <ftdatepicker class="col-md-4 form-control" :value="report_data.expiring_contract_max" v-on:update:val="report_data.expiring_contract_max = $event"
                  />
                </div>
              </transition>
            </div>
          </div>

          <div class="row">
            <label class="col-sm-12">Player Value</label>
            <div class="col-md-8">
              <currencyinput :value="report_data.value" max="true" />
            </div>
          </div>
          <div class="row">
            <label class="col-md-12">Wage Budget per year</label>
            <div class="col-md-8">
              <currencyinput :value="report_data.wage_budget" />
            </div>
          </div>

          <div class="row">
            <label class="col-sm-12">Desirable Attributes</label>
            <textarea class="col-sm-12 form-control" v-model="report_data.desirable_attributes" />
          </div>

          <div class="row">
            <label class="col-sm-12">Additional Comments</label>
            <textarea class="col-sm-12 form-control" v-model="report_data.comments" />
          </div>

          <div class="row">
            <label class="col-md-12 required">Deadline</label>
            <ftdatepicker class="col-md-6 form-control" :disabled="disabled" :value="deadline" v-on:update:val="deadline = $event" />
          </div>
          <div class="row">
            <label class="col-md-12">Price Range</label>
            <currencyinput :value="price" max="true" />
          </div>

          <div class="form-group buttons-inner">
            <button v-if="!edit" id="submit" class="btn btn-primary ft-button" @click="handleSubmit"> CREATE</button>
            <button v-if="edit" id="submit" class="btn btn-primary ft-button" @click="handleSubmit"> UPDATE</button>
            <button id="cancel" name="cancel" class="btn btn-default ft-button" @click="cancelAction">CANCEL</button>
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
import inputSearch from 'app/components/Input/InputSearch.vue';
import PlayerPosition from 'app/components/Input/PlayerPosition';
import Nationality from 'app/components/Input/Nationality';
import Language from 'app/components/Input/Language';
import PreferredFoot from 'app/components/Input/PreferredFoot';
import FtCheckbox from 'app/components/Input/FtCheckbox';
import FtDatepicker from 'app/components/Input/FtDatepicker';
import TimelineItem from 'app/components/TimelineItem';
import CurrencyInput from 'app/components/Input/CurrencyInput';
export default {
  name: 'PlayerJobRequest',
  props: ['submit', 'errors', 'edit', 'cancelAction'],
  components: {
    inputsearch: inputSearch,
    playerposition: PlayerPosition,
    countryselect: Nationality,
    language: Language,
    preferredfoot: PreferredFoot,
    ftdatepicker: FtDatepicker,
    ftcheckbox: FtCheckbox,
    'timeline-item': TimelineItem,
    currencyinput: CurrencyInput
  },
  data() {
    return {
      disabled: {
        to: new Date()
      },
      report_data: {
        playing_position: [],
        languages: [],
        expiring_contract: false,
        transfer: false,
        loan: false,
        expiring_contract: 'No',
        expiring_contract_max: '',
        expiring_contract_min: '',
        transfer_range: {
          value: 0,
          currency: 'USD',
          max: 0
        },
        loan_range: {
          value: 0,
          currency: 'USD',
          max: 0
        },
        wage_budget: {
          value: 0,
          currency: 'USD',
          max: 0
        },
        value: {
          value: 0,
          currency: 'USD',
          max: 0
        }
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
      this.report_data = this.edit.report_data;
      this.deadline = this.edit.deadline;
      this.min_price = this.edit.min_price;
      this.max_price = this.edit.max_price;
    }
  },
  methods: {
    showCalendar: function(index) {
      this.$refs[index].showCalendar();
    },
    handleSubmit() {
      this.submit({
        report_data: this.report_data,
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
