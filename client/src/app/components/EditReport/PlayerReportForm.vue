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
        <label class="col-md-12 label-price">Price</label>
        <div class="price-input">
          <currencyinput :value="price" />
          <p v-if="price.value == 0" class="info">The report will be free</p>
        </div>
      </div>
    </div>
    <h5 class="menu" @click="playersummary = !playersummary" :class="playersummary ? 'active' : ''">
      <i class="sub-menu-arrow" :class="playersummary ? 'active' : ''"></i> Player Summary </h5>
    <div class="form-group form-inner">
      <transition name="fade">
        <div class="form-group" v-if="playersummary">
          <div class="row">
            <div class="col-sm-4">
              <label class="col-sm-12 col-form-label">Age</label>
              <input type="number" class="col-sm-12 form-control" v-model="report_data.userinfo.age" placeholder="Age">
            </div>
            <div class="col-sm-4">
              <label class="col-sm-12 col-form-label">Approximate Height (cm)</label>
              <input type="number" class="col-sm-12 form-control" v-model="report_data.userinfo.height" placeholder="Height">
            </div>
            <div class="col-sm-4">
              <label class="col-sm-12 col-form-label">Approximate Weight (kg)</label>
              <input type="number" class="col-sm-12 form-control" v-model="report_data.userinfo.weight" placeholder="Weight">
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <label class="col-sm-12 col-form-label">Position</label>
              <playerposition v-once :value="report_data.userinfo.playing_position" v-on:update:val="report_data.userinfo.playing_position = $event"
              />
            </div>
            <div class="col-sm-6">
              <label class="col-sm-12 col-form-label">Preferred Foot</label>
              <preferredfoot v-once :value="report_data.userinfo.preferred_foot" v-on:update:val="report_data.userinfo.preferred_foot = $event"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <label class="col-sm-12 col-form-label">Nationality</label>
              <countryselect v-once :value="report_data.userinfo.nationality_country_code" v-on:update:val="report_data.userinfo.nationality_country_code = $event"
              /> </div>
            <div class="col-sm-6">
              <label class="col-sm-12 col-form-label">Based In</label>
              <countryselect v-once :value="report_data.userinfo.residence_country_code" v-on:update:val="report_data.userinfo.residence_country_code = $event"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12">
              <label class="col-sm-12 col-form-label">Language(s)</label>
              <language :value="report_data.userinfo.languages" v-on:update:val="report_data.userinfo.languages = $event" />
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
              <currencyinput :value="report_data.transfer_sum.wage" />
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12">
              <label class="col-sm-12 ftcheckbox-inner col-form-label" :class="report_data.transfer_sum.transfer_interested == 'yes' ? 'active' : ''">
                <span class="title">Interested in Transfer ?</span>
                <i class="sub-menu-arrow" :class="report_data.transfer_sum.transfer_interested == 'yes' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="report_data.transfer_sum.transfer_interested" v-on:update:val="report_data.transfer_sum.transfer_interested = $event"
                />
              </label>
              <transition name="fade">
                <div class="transfer-value col-sm-12 row" v-if="report_data.transfer_sum.transfer_interested === 'yes'">
                  <div class="col-sm-6">
                    <label class="col-sm-12 col-form-label">Availability for transfer</label>
                    <currencyinput :value="report_data.transfer_sum.transfer_availability" />
                  </div>
                  <div class="col-sm-6">
                    <label class="col-sm-12 col-form-label">Transfer Budget</label>
                    <currencyinput :value="report_data.transfer_sum.transfer_budget" />
                  </div>
                </div>
              </transition>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12">
              <label class="col-sm-12 ftcheckbox-inner col-form-label" :class="report_data.transfer_sum.loan_interested == 'yes' ? 'active' : ''">
                <span class="title">Interested in Loan ?</span>
                <i class="sub-menu-arrow" :class="report_data.transfer_sum.loan_interested == 'yes' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="report_data.transfer_sum.loan_interested" v-on:update:val="report_data.transfer_sum.loan_interested = $event"
                />
              </label>
              <transition name="fade">
                <div class="transfer-value col-sm-12 row" v-if="report_data.transfer_sum.loan_interested === 'yes'">
                  <div class="col-sm-6">
                    <label class="col-sm-12 col-form-label">Availability for Loan</label>
                    <currencyinput :value="report_data.transfer_sum.loan_availability" />
                  </div>
                  <div class="col-sm-6">
                    <label class="col-sm-12 col-form-label">End of Contract</label>
                    <input type="number" v-model="report_data.transfer_sum.contract_end" class="col-sm-12 form-control">
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
      <matchanalyzed :analyzed_matches="report_data.analyzed_matches" type="player" />
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Current Ability Overview</label>
      <div class="col-md-12">
        <textarea class="col-md-12 form-control" v-model="report_data.overview" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Physical Attribute(s)</label>
      <div class="col-md-12">
        <textarea class="col-md-12 form-control" v-model="report_data.physical_attributes" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Mental Attribute(s)</label>
      <div class="col-md-12">
        <textarea class="col-md-12 form-control" v-model="report_data.mental_attributes" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Technical Attribute(s)</label>
      <div class="col-md-12">
        <textarea class="col-md-12 form-control" v-model="report_data.technical_attributes" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Personality</label>
      <div class="col-md-12">
        <textarea type="text" class="col-md-12 form-control" v-model="report_data.personality" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Potential</label>
      <div class="col-md-12">
        <textarea type="text" class="col-md-12 form-control" v-model="report_data.potential" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Other Observations & Viewpoints To Note</label>
      <div class="col-md-12 ">
        <textarea type="text" class="col-md-12 form-control" v-model="report_data.observations" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Conclusions</label>
      <div class="col-md-12">
        <textarea class="col-md-12 form-control" v-model="report_data.conclusion" />
      </div>
    </div>
    <addattachments :attachments="report ? report.report_data.attachments.attachments : null" v-on:update:remove="remove_attachment = $event"
      v-on:update:files="files = $event" />
    <div class="form-group buttons-inner">
      <button v-if="!report" id="submit" class="btn btn-primary ft-button" @click="handleSubmit">Publish</button>
      <button v-if="report" id="submit" class="btn btn-primary ft-button" @click="handleSubmit">Update</button>
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
    props: ['userinfo', 'submitReport', 'reportStatus', 'report', 'cancelAction'],
    data() {
      return {
        playersummary: true,
        transfersummary: true,
        report_data: {
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
          analyzed_matches: [{
            date: '',
            opponent: '',
            venue: '',
            comment: '',
            training: 'No'
          }]
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
    watch: {
      userinfo() {
        if (this.userinfo.birthday && !this.report) {
          var birthday = new Date(this.userinfo.birthday);
          var ageDifMs = Date.now() - birthday.getTime();
          var ageDate = new Date(ageDifMs); // miliseconds from epoch
          this.report_data.userinfo.age = Math.abs(ageDate.getUTCFullYear() - 1970);
          this.report_data.userinfo.weight = this.userinfo.weight;
          this.report_data.userinfo.height = this.userinfo.height;
          this.report_data.userinfo.preferred_foot = this.userinfo.preferred_foot;
          this.report_data.userinfo.playing_position = [];
          if (this.userinfo.playing_position) {
            this.report_data.userinfo.playing_position = JSON.parse(this.userinfo.playing_position);
          }
        }
      }
    },
    beforeMount() {
      if (this.report) {
        this.report_data = this.report.report_data.meta_data;
        this.price = this.report.price;
        this.headline = this.report.headline;
      }
    },
    methods: {
      handleSubmit() {
        var report = {
          headline: this.headline,
          price: this.price,
          report_data: this.report_data,
          remove_attachment: this.remove_attachment
        };
        this.submitReport(report, this.files);
        $('html, body').animate({
            scrollTop: 0
          },
          100
        );
      }
    }
  };
</script>
