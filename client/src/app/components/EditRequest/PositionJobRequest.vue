<template>
  <div>
    <h4 v-if="!edit" class="header">Creating Position ASSIGNMENT</h4>
    <h4 v-if="edit" class="header">Editing Position ASSIGNMENT</h4>
    <timeline-item>
      <form @submit.prevent class="position-request ft-form">
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
          <h5 class="row">The Scouting Target</h5>
          <div class="row">
            <div class="col-lg-4 form-group">
              <div class="col-lg-12 row range">
                <input type="number" min="0" class="col-lg-5 form-control" v-model="meta_data.min_heigth" placeholder="Min height">
                <span class="separator col-lg-1">-</span>
                <input type="number" min="0" class="col-lg-5 form-control" v-model="meta_data.max_heigth" placeholder="Max height">
              </div>
            </div>
            <div class="col-lg-4 form-group">
              <div class="col-lg-12 row range">
                <input type="number" min="0" class="col-lg-5 form-control" v-model="meta_data.min_weight" placeholder="Min weight">
                <span class="separator col-lg-1">-</span>
                <input type="number" min="0" class="col-lg-5 form-control" v-model="meta_data.max_weight" placeholder="Max weight">
              </div>
            </div>
            <div class="col-lg-4 form-group">
              <div class="col-lg-12 row range">
                <input type="number" min="0" class="col-lg-5 form-control" v-model="meta_data.age_min" placeholder="Min age">
                <span class="separator col-lg-1">-</span>
                <input type="number" min="0" class="col-lg-5 form-control" v-model="meta_data.age_max" placeholder="Max age">
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-lg-6 form-group">
              <playerposition class="col-lg-12" :value="meta_data.playing_position" v-on:update:val="meta_data.playing_position = $event"
                placeholder="Positions in" />
            </div>
            <div class="col-lg-6 form-group">
              <preferredfoot class="col-lg-12" :value="meta_data.preferred_foot" v-on:update:val="meta_data.preferred_foot = $event" placeholder="Preferred foot is"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-lg-7 form-group">
              <language class="col-lg-12" :value="meta_data.languages" v-on:update:val="meta_data.languages = $event" placeholder="Speaking languages are"
              />
            </div>
            <div class="col-lg-5 form-group">
              <countryselect class="col-lg-12" :value="meta_data.nationality_country_code" v-on:update:val="meta_data.nationality_country_code = $event"
                placeholder="Nationality is" />
            </div>
          </div>
          <div class="row">
            <div class="col-lg-6 form-group">
              <countryselect class="col-lg-12" :value="meta_data.residence_country_code" v-on:update:val="meta_data.residence_country_code = $event"
                placeholder="Based in" />
            </div>
            <div class="col-lg-6 form-group">
              <input type="text" class="col-lg-12 form-control" v-model="meta_data.passport" placeholder="Passport">
            </div>
          </div>
          <h5 class="row">Your Scouting Requirements</h5>
          <div class="row">
            <label class="col-lg-3 label">Availability</label>
            <div class="col-lg-12">
              <label class="col-lg-12 ftcheckbox-inner col-form-label" :class="meta_data.transfer == 'yes' ? 'active' : ''">
                <span class="title">Interested in Transfer ?</span>
                <i class="sub-menu-arrow" :class="meta_data.transfer == 'yes' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="meta_data.transfer" v-on:update:val="meta_data.transfer = $event" />
              </label>
              <transition name="fade">
                <div class="transfer-value col-lg-12" v-if="meta_data.transfer === 'yes'">
                  <currencyinput :value="meta_data.transfer_range" max="true" placeholder="Transfer range from" placeholder1="to" />
                </div>
              </transition>
            </div>
            <div class="col-lg-12">
              <label class="col-lg-12 ftcheckbox-inner col-form-label" :class="meta_data.loan == 'yes' ? 'active' : ''">
                <span class="title">Interested in Loan ?</span>
                <i class="sub-menu-arrow" :class="meta_data.loan == 'yes' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="meta_data.loan" v-on:update:val="meta_data.loan = $event" />
              </label>
              <transition name="fade">
                <div class="transfer-value col-lg-12" v-if="meta_data.loan === 'yes'">
                  <currencyinput :value="meta_data.loan_range" max="true" placeholder="Loan range from" placeholder1="to" />
                </div>
              </transition>
            </div>
            <div class="col-lg-12">
              <label class="col-lg-12 ftcheckbox-inner col-form-label" :class="meta_data.expiring_contract == 'yes' ? 'active' : ''">
                <span class="title">Expiring Contract ?</span>
                <i class="sub-menu-arrow" :class="meta_data.expiring_contract == 'yes' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="meta_data.expiring_contract" v-on:update:val="meta_data.expiring_contract = $event"
                />
              </label>
              <transition name="fade">
                <div class="transfer-value col-lg-12 row" v-if="meta_data.expiring_contract === 'yes'">
                  <ftdatepicker class="col-lg-4 form-control" :value="meta_data.expiring_contract_min" v-on:update:val="meta_data.expiring_contract_min = $event"
                    placeholder="Expiring contract from" />
                  <span class="separator">—</span>
                  <ftdatepicker class="col-lg-4 form-control" placeholder="to" :value="meta_data.expiring_contract_max" v-on:update:val="meta_data.expiring_contract_max = $event"
                  />
                </div>
              </transition>
            </div>
          </div>

          <div class="row">
            <div class="col-lg-8">
              <currencyinput :value="meta_data.value" max="true" placeholder="Player value from" placeholder1="to" />
            </div>
          </div>
          <div class="row">
            <div class="col-lg-8">
              <currencyinput :value="meta_data.wage_budget" placeholder="Wage Budget per year" />
            </div>
          </div>

          <div class="row">
            <textarea class="col-lg-12 form-control" v-model="meta_data.desirable_attributes" v-autosize="meta_data.desirable_attributes"
              placeholder="Desirable Attributes" />
          </div>

          <div class="row">
            <ftdatepicker class="col-lg-6 form-control" :disabled="disabled" :value="deadline" v-on:update:val="deadline = $event" placeholder="Deadline"
            />
          </div>
          <currencyinput :value="price" max="true" placeholder="Report price between" placeholder1="And" />
          <h5 class="row">Other Details</h5>
          <div class="row">
            <textarea class="col-lg-12 form-control" v-model="meta_data.comments" v-autosize="meta_data.comments" placeholder="Any additional comments"
            />
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
<style lang="scss" scoped>
  .row {
    padding: 10px 0;
  }

  .range {
    margin: 0;
    input {
      padding-right: 0;
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
        meta_data: {
          playing_position: [],
          languages: [],
          expiring_contract: false,
          transfer: false,
          loan: false,
          expiring_contract: 'No',
          expiring_contract_max: '',
          expiring_contract_min: '',
          transfer_range: {
            value: null,
            currency: 'USD',
            max: null
          },
          loan_range: {
            value: null,
            currency: 'USD',
            max: null
          },
          wage_budget: {
            value: null,
            currency: 'USD',
            max: null
          },
          value: {
            value: null,
            currency: 'USD',
            max: null
          }
        },
        deadline: '',
        price: {
          value: null,
          currency: 'USD',
          max: null
        }
      };
    },
    created() {
      if (this.edit) {
        this.meta_data = this.edit.meta_data;
        this.deadline = this.edit.deadline;
        this.price = this.edit.price;
      }
    },
    computed: {
      canValidate() {
        if (this.deadline == '') return false;
        return true;
      }
    },
    methods: {
      showCalendar: function (index) {
        this.$refs[index].showCalendar();
      },
      handleSubmit() {
        this.submit({
          meta_data: this.meta_data,
          deadline: this.deadline,
          price: this.price,
          type_request: 'position',
          status: 'publish'
        });
      }
    }
  };
</script>
