<template>
  <form @submit.prevent class="report-form ft-form">
    <div class="form-group row report-name">
      <div class="col-sm-12">
        <label class="col-md-12 col-form-label">Report Name</label>
        <input type="text" class="col-md-12 form-control" v-model="headline">
      </div>
    </div>
    <div class="form-group row">
      <div class="col-sm-12">
        <label class="col-md-12 label-price" v-if="request">Price In Marketplace</label>
        <label class="col-md-12 label-price" v-if="!request">Price</label>
        <div class="price-input">
          <currencyinput :value="price" />
          <p v-if="price.value == 0" class="info">The report will be free</p>
        </div>
      </div>
    </div>
    <h5 class="menu" @click="playersummary = !playersummary" :class="playersummary ? 'active' : ''">
      <i class="sub-menu-arrow" :class="playersummary ? 'active' : ''"></i> Player Summary </h5>
    <div class="form-group form-inner" v-if="playerEditable">
      <transition name="fade">
        <div class="form-group" v-if="playersummary">
          <div class="row">
            <div class="col-sm-4">
              <label class="col-sm-12 col-form-label">Age</label>
              <input type="number" class="col-sm-12 form-control" v-model="meta_data.userinfo.age" :placeholder="agePlaceHolder" :readonly="userinfo != null">
            </div>
            <div class="col-sm-4">
              <label class="col-sm-12 col-form-label">Approximate Height (cm)</label>
              <input type="number" class="col-sm-12 form-control" v-model="meta_data.userinfo.height" :placeholder="heightPlaceHolder" :readonly="userinfo != null">
            </div>
            <div class="col-sm-4">
              <label class="col-sm-12 col-form-label">Approximate Weight (kg)</label>
              <input type="number" class="col-sm-12 form-control" v-model="meta_data.userinfo.weight" :placeholder="weightPlaceHolder" :readonly="userinfo != null">
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <label class="col-sm-12 col-form-label">Position</label>
              <playerposition :value="meta_data.userinfo.playing_position" v-on:update:val="meta_data.userinfo.playing_position = $event" :readonly="userinfo != null"
              />
            </div>
            <div class="col-sm-6">
              <label class="col-sm-12 col-form-label">Preferred Foot</label>
              <preferredfoot :value="meta_data.userinfo.preferred_foot" v-on:update:val="meta_data.userinfo.preferred_foot = $event" :readonly="userinfo != null" />
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <label class="col-sm-12 col-form-label">Nationality</label>
              <countryselect :value="meta_data.userinfo.nationality_country_code" v-on:update:val="meta_data.userinfo.nationality_country_code = $event" :readonly="userinfo != null"
              /> </div>
            <div class="col-sm-6">
              <label class="col-sm-12 col-form-label">Based In</label>
              <countryselect :value="meta_data.userinfo.residence_country_code" v-on:update:val="meta_data.userinfo.residence_country_code = $event" :readonly="userinfo != null"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12">
              <label class="col-sm-12 col-form-label">Language(s)</label>
              <language :value="meta_data.userinfo.languages" v-on:update:val="meta_data.userinfo.languages = $event" :readonly="userinfo != null" />
            </div>
          </div>
        </div>
      </transition>
    </div>
    <h5 class="menu" @click="transfersummary = !transfersummary" :class="transfersummary ? 'active' : ''">
      <i class="sub-menu-arrow" :class="transfersummary ? 'active' : ''"></i> Transfer Summary </h5>
    <div class="form-group form-inner">
      <transition name="fade">
        <div class="form-group" v-if="transfersummary">
          <div class="row">
            <label class="col-sm-1 col-form-label">Wage</label>
            <div class="col-sm-11">
              <currencyinput :value="meta_data.transfer_sum.wage" />
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12">
              <label class="col-sm-12 ftcheckbox-inner col-form-label" :class="meta_data.transfer_sum.transfer_interested == 'yes' ? 'active' : ''">
                <span class="title">Interested in Transfer ?</span>
                <i class="sub-menu-arrow" :class="meta_data.transfer_sum.transfer_interested == 'yes' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="meta_data.transfer_sum.transfer_interested" v-on:update:val="meta_data.transfer_sum.transfer_interested = $event"
                />
              </label>
              <transition name="fade">
                <div class="transfer-value col-sm-12 row" v-if="meta_data.transfer_sum.transfer_interested === 'yes'">
                  <div class="col-sm-6">
                    <label class="col-sm-12 col-form-label">Availability for transfer</label>
                    <currencyinput :value="meta_data.transfer_sum.transfer_availability" />
                  </div>
                  <div class="col-sm-6">
                    <label class="col-sm-12 col-form-label">Transfer Budget</label>
                    <currencyinput :value="meta_data.transfer_sum.transfer_budget" />
                  </div>
                </div>
              </transition>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12">
              <label class="col-sm-12 ftcheckbox-inner col-form-label" :class="meta_data.transfer_sum.loan_interested == 'yes' ? 'active' : ''">
                <span class="title">Interested in Loan ?</span>
                <i class="sub-menu-arrow" :class="meta_data.transfer_sum.loan_interested == 'yes' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="meta_data.transfer_sum.loan_interested" v-on:update:val="meta_data.transfer_sum.loan_interested = $event"
                />
              </label>
              <transition name="fade">
                <div class="transfer-value col-sm-12 row" v-if="meta_data.transfer_sum.loan_interested === 'yes'">
                  <div class="col-sm-6">
                    <label class="col-sm-12 col-form-label">Availability for Loan</label>
                    <currencyinput :value="meta_data.transfer_sum.loan_availability" />
                  </div>
                  <div class="col-sm-6">
                    <label class="col-sm-12 col-form-label">End of Contract</label>
                    <input type="number" v-model="meta_data.transfer_sum.contract_end" class="col-sm-12 form-control">
                  </div>
                </div>
              </transition>
            </div>
          </div>
        </div>
      </transition>
    </div>
    <div class="form-group">
      <label>Analysis of Trainings/Matches</label>
      <matchanalyzed :analyzed_matches="meta_data.analyzed_matches" type="player" />
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Current Ability Overview</label>
      <div class="col-md-12">
        <textarea class="col-md-12 form-control" v-model="meta_data.overview" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Physical Attribute(s)</label>
      <div class="col-md-12">
        <textarea class="col-md-12 form-control" v-model="meta_data.physical_attributes" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Mental Attribute(s)</label>
      <div class="col-md-12">
        <textarea class="col-md-12 form-control" v-model="meta_data.mental_attributes" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Technical Attribute(s)</label>
      <div class="col-md-12">
        <textarea class="col-md-12 form-control" v-model="meta_data.technical_attributes" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Personality</label>
      <div class="col-md-12">
        <textarea type="text" class="col-md-12 form-control" v-model="meta_data.personality" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Potential</label>
      <div class="col-md-12">
        <textarea type="text" class="col-md-12 form-control" v-model="meta_data.potential" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Other Observations & Viewpoints To Note</label>
      <div class="col-md-12 ">
        <textarea type="text" class="col-md-12 form-control" v-model="meta_data.observations" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Conclusions</label>
      <div class="col-md-12">
        <textarea class="col-md-12 form-control" v-model="meta_data.conclusion" />
      </div>
    </div>
    <addattachments :attachments="report ? report.attachments.attachments : null" v-on:update:remove="remove_attachment = $event"
      v-on:update:files="files = $event" />
    <div class="form-group buttons-inner">
      <button v-if="!report && !request" id="submit" class="btn btn-primary ft-button" @click="handleSubmit('publish')">Publish</button>
      <button v-if="report" id="submit" class="btn btn-primary ft-button" @click="handleSubmit">Update</button>
      <button v-if="!report && request" id="submit" class="btn btn-primary ft-button" @click="handleSubmit('publish')">Send Report & Publish in MarketPlace</button>
      <button v-if="!report && request" id="submit" class="btn btn-primary ft-button" @click="handleSubmit('private')">Send Report</button>
      <button @click="cancelAction" id="cancel" name="cancel" class="btn btn-default ft-button">Cancel</button>
    </div>
  </form>
</template>

<style lang="scss">
@import '~stylesheets/form';
</style>
<style lang="scss" scoped>
@import '~stylesheets/variables';

.fade-enter-active,
.fade-leave-active {
  transition: all 0.75s;
  max-height: 500px;
}

.fade-enter,
.fade-leave-to {
  opacity: 0.1;
  max-height: 0px;
}

.report-form {
  .radio-group {
    label {
      width: 10%;
    }
  }
  .transfer-value {
    padding: 0 30px;
    div {
      overflow: hidden;
      height: 100%;
    }
  }
  h5 {
    &.menu {
      cursor: pointer;
    }
  }

  .sub-menu-arrow {
    &::before {
      margin-top: 3px;
      border-color: rgba(60, 60, 60, 0.5);
      border-style: solid;
      border-width: 3px 3px 0 0;
      content: '';
      height: 10px;
      vertical-align: top;
      transform: rotate(45deg);
      box-sizing: inherit;
      display: inline-block;
      transition: all 0.15s cubic-bezier(1, -0.115, 0.975, 0.855);
      transition-timing-function: cubic-bezier(1, -0.115, 0.975, 0.855);
      width: 10px;
    }
    &.active::before {
      transform: rotate(133deg);
    }
  }
  h5 {
    color: $main-text-color;
    font-size: 15px;
    font-weight: 700;
  }
  .form-inner {
    margin-left: 20px;
    .form-group {
      padding: 10px;
    }
  }
  .report-name {
    label {
      margin-right: 20px;
    }
  }
  .label-price {
    margin-top: 8px;
  }
}
</style>

<script>
import MatchAnalyzed from 'app/components/Input/MatchAnalyzed';
import PlayerPosition from 'app/components/Input/PlayerPosition';
import Nationality from 'app/components/Input/Nationality';
import Language from 'app/components/Input/Language';
import PreferredFoot from 'app/components/Input/PreferredFoot';
import FtCheckbox from 'app/components/Input/FtCheckbox';
import AddAttachments from 'app/components/Input/AddAttachments';
import 'vue-awesome/icons/trash';
import Icon from 'vue-awesome/components/Icon';
import CurrencyInput from 'app/components/Input/CurrencyInput';

export default {
  name: 'PlayerReportForm',
  components: {
    matchanalyzed: MatchAnalyzed,
    playerposition: PlayerPosition,
    countryselect: Nationality,
    language: Language,
    preferredfoot: PreferredFoot,
    ftcheckbox: FtCheckbox,
    addattachments: AddAttachments,
    icon: Icon,
    currencyinput: CurrencyInput
  },
  props: ['userinfo', 'submitReport', 'reportStatus', 'report', 'cancelAction', 'request','player_search'],
  data() {
    return {
      playersummary: true,
      playerEditable: this.userinfo == undefined ? true : false,
      transfersummary: true,
      meta_data: {
        userinfo: {
          nationality_country_code: '',
          languages: [],
          playing_position: [],
          age: null,
          preferred_foot: ''
        },
        transfer_sum: {
          loan_interested: 'No',
          transfer_interested: 'No',
          free_agent: 'No',
          wage: {
            value: null,
            currency: 'USD'
          },
          loan_availability: {
            value: null,
            currency: 'USD'
          },
          transfer_budget: {
            value: null,
            currency: 'USD'
          },
          transfer_availability: {
            value: null,
            currency: 'USD'
          }
        },
        analyzed_matches: [
          {
            date: '',
            opponent: '',
            venue: '',
            comment: '',
            training: 'No'
          }
        ]
      },
      price: {
        value: 0,
        currency: 'USD'
      },
      headline: '',
      edit_mode: !!this.report,
      files: [],
      remove_attachment: {}
    };
  },
  computed: {
    agePlaceHolder() {
      if (this.request && this.request.type_request == 'position')
        return `Between ${this.request.meta_data.age_min} and ${this.request.meta_data.age_max}`;
      return 'Age';
    },
    weightPlaceHolder() {
      if (this.request && this.request.type_request == 'position')
        return `Between ${this.request.meta_data.min_weight} and ${
          this.request.meta_data.max_weight
        }`;
      return 'Weight';
    },
    heightPlaceHolder() {
      if (this.request && this.request.type_request == 'position')
        return `Between ${this.request.meta_data.min_heigth} and ${
          this.request.meta_data.max_heigth
        }`;
      return 'Height';
    }
  },
  watch: {
    userinfo() {
      if (this.userinfo.constructor === Object && !this.report) {
        var birthday = new Date(this.userinfo.birthday);
        var ageDifMs = Date.now() - birthday.getTime();
        var ageDate = new Date(ageDifMs); // miliseconds from epoch
        this.meta_data.userinfo = this.userinfo;
        this.meta_data.userinfo.age = Math.abs(ageDate.getUTCFullYear() - 1970);
        this.playerEditable = true;
        this.playersummary = false;
      }
    }
  },
  beforeMount() {
    if (this.report) {
      this.meta_data = this.report.meta_data;
      this.price = this.report.price;
      this.headline = this.report.headline;
    }
    if (this.request) {
      this.price = this.request.price;
      this.price.value = parseInt(this.request.request_bids.price);
      this.headline = 'Report on ';
      this.headline += this.request.meta_data.player_name ? this.request.meta_data.player_name : '';
      this.meta_data.userinfo.languages = this.request.meta_data.languages;
      this.meta_data.userinfo.preferred_foot = this.request.meta_data.preferred_foot;
      this.meta_data.userinfo.residence_country_code = this.request.meta_data.residence_country_code;
      this.meta_data.userinfo.nationality_country_code = this.request.meta_data.nationality_country_code;
      this.meta_data.userinfo.playing_position = this.request.meta_data.playing_position;
      this.$forceUpdate();
    }
  },
  methods: {
    handleSubmit(status) {
      if (this.player_search)
        this.meta_data.userinfo.player_search = this.player_search;
      var report = {
        headline: this.headline,
        price: this.price,
        meta_data: this.meta_data,
        remove_attachment: this.remove_attachment,
        status
      };
      this.submitReport(report, this.files, status);
      $('html, body').animate(
        {
          scrollTop: 0
        },
        100
      );
    }
  }
};
</script>
