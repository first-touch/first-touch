<template>
  <div>
    <h4 v-if="!edit" class="header">Creating Position ASSIGNMENT</h4>
    <h4 v-if="edit" class="header">Editing Position ASSIGNMENT</h4>
    <timeline-item>
      <div class="form-group buttons-inner row">
        <button id="cancel" name="cancel" class="ft-button ft-button-right" @click="cancelAction">CANCEL</button>
      </div>
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
          <h5 class="row request-section">Headline</h5>
          <div class="row col-lg-12 required-before">
            <textarea class="col-lg-12 form-control" v-model="meta_data.headline" v-autosize="meta_data.headline" placeholder="Give your assignment a descriptive and eye-catching headline"
            />
          </div>
          <h5 class="row request-section">Playing Criteria</h5>
          <div class="row">
            <div class="col-lg-6 form-group required-before">
              <playerposition class="col-lg-12 select-positions" :value="meta_data.playing_position" v-on:update:val="meta_data.playing_position = $event"
                placeholder="Select position(s)" />
            </div>
            <div class="col-lg-6 form-group">
              <preferredfoot class="col-lg-12" :value="meta_data.preferred_foot" v-on:update:val="meta_data.preferred_foot = $event" placeholder="Select preferred foot…"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-lg-12 form-group">
              <textarea class="col-lg-12 form-control" v-model="meta_data.desirable_attributes" v-autosize="meta_data.desirable_attributes"
                placeholder="Describe the key attributes that you are looking for in this position
EXAMPLE: Looking for a tall target man. Must be strong enough to hold off defenders. The player will be the key fulcrum in the transition from defence to attack. Decent heading ability to complement their height and strength. Would also prefer players that have a good first touch.
                " />
            </div>
          </div>
        </div>
        <h5 class="row request-section">Non-Playing Criteria</h5>
        <div class="col-md-12">
          <div class="row">
            <div class="col-lg-4 row form-group">
              <label class="col-md-12">Select age range</label>
              <input type="number" min="0" class="col-lg-5 form-control" v-model="meta_data.min_age" placeholder="Min age">
              <span class="separator col-lg-1">-</span>
              <input type="number" min="0" class="col-lg-5 form-control" v-model="meta_data.max_age" placeholder="Max age">
            </div>
            <div class="col-lg-4 row form-group">
              <label class="col-md-12">Select Height (cm)</label>
              <input type="number" min="0" class="col-lg-5 form-control" v-model="meta_data.min_height" placeholder="Min height">
              <span class="separator col-lg-1">-</span>
              <input type="number" min="0" class="col-lg-5 form-control" v-model="meta_data.max_height" placeholder="Max height">
            </div>
            <div class="col-lg-4 row form-group">
              <label class="col-md-12">Select Weight (kg)</label>
              <input type="number" min="0" class="col-lg-5 form-control" v-model="meta_data.min_weight" placeholder="Min weight">
              <span class="separator col-lg-1">-</span>
              <input type="number" min="0" class="col-lg-5 form-control" v-model="meta_data.max_weight" placeholder="Max weight">
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-12 form-group">
            <language class="col-lg-12" :value="meta_data.languages" v-on:update:val="meta_data.languages = $event" placeholder="Speaking languages are"
            />
          </div>
        </div>
        <div class="form-group">
          <textarea class="col-lg-12 form-control" v-model="meta_data.eligibility" v-autosize="meta_data.eligibility" placeholder="Describe your eligibility requirements. EXAMPLE: Looking for EU national or players with valid visas to live and work in Europe."
          />
        </div>
        <h5 class="row request-section">Transfer Criteria</h5>
        <div class="row">

          <div class="col-lg-12 form-group player-value-group">
            <label class="col-md-12">Select an approximate player value…</label>
            <currencyinput :value="meta_data.value" max="true" />
          </div>
        </div>

        <h5 class="row request-section">Your Scouting Requirements</h5>

        <div class="row col-lg-12 form-group required-before">
          <ftdatepicker class="col-lg-12 form-control" :disabled="disabled" :value="deadline" v-on:update:val="deadline = $event" placeholder="Select a deadline"
          />
        </div>
        <div class="col-lg-12 form-group">
          <div class="row bid-range">
            <currencyinput :value="price" max="true" maxValue="999999" :noHyphen="true" placeholder="Desired bid range" class="col" />
            <span class="bid-range-icon-inner" v-b-tooltip.hover placement="topleft" title="Bid level reflects your appetite to spend on reports and is for reference only. Scouts determine their own rates, so the actual rate you pay is up to you and the Scout.">
              <icon name='question-circle'></icon>
            </span>
          </div>
        </div>

        <h5 class="row section request-section">Other Details</h5>
        <div class="row">
          <textarea class="col-lg-12 form-control" v-model="meta_data.comments" v-autosize="meta_data.comments" placeholder="Add comments"
          />
        </div>
        <div class="form-group buttons-inner row">
          <button v-if="!edit" id="submit" class="ft-button ft-button-success" :disabled="!canValidate" @click="handleSubmit('publish')">Publish</button>
          <button v-if="edit" id="submit" class="ft-button ft-button-success" :disabled="!canValidate" @click="handleSubmit(null)">UPDATE</button>
          <button v-if="!edit" id="submit" class="ft-button ft-button-success" :disabled="!canValidate" @click="handleSubmit(null)">Save & Exit</button>
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

  .range {
    margin: 0;
    input {
      padding-right: 0;
    }
  }

  .select-positions {
    display: block;
    padding: 0;
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

  .player-value-group {
    margin-top: 20px;
  }

  .expiring-container {
    margin-bottom: 20px;
  }

  .request-section {
    padding: 20px 0;
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
  import Icon from 'vue-awesome/components/Icon';
  import 'vue-awesome/icons/question-circle';

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
      currencyinput: CurrencyInput,
      icon: Icon,

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
          min_height: 160,
          max_height: 180,
          min_weight: 75,
          max_weight: 95,
          min_age: 16,
          max_age: 40,
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
      handleSubmit(status) {
        if (status == null) {
          status = this.edit ? this.edit.status : 'private';
        }
        this.submit({
          meta_data: this.meta_data,
          deadline: this.deadline,
          price: this.price,
          type_request: 'position',
          status
        });
      }
    }
  };
</script>
