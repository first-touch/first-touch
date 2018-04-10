<template>
  <form @submit.prevent id="report-form">
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
          <!-- <input type="number" v-model="price" class="form-control" min="0" max="999999" /> -->
          <p v-if="price.value == 0" class="info">The report will be free</p>
        </div>
      </div>
    </div>
    <h3 class="menu" @click="playersummary = !playersummary" :class="playersummary ? 'active' : ''">
      <i class="sub-menu-arrow" :class="playersummary ? 'active' : ''"></i> Player Summary </h3>
    <div class="form-group form-inner">
      <transition name="fade">
        <div class="form-group" v-if="playersummary">
          <div class="row">
            <div class="col-sm-4">
              <label class="col-sm-12 col-form-label">Age</label>
              <input type="number" class="col-sm-12 form-control" v-model="meta_data.userinfo.age" placeholder="Age">
            </div>
            <div class="col-sm-4">
              <label class="col-sm-12 col-form-label">Approximate Height (cm)</label>
              <input type="number" class="col-sm-12 form-control" v-model="meta_data.userinfo.height" placeholder="Height">
            </div>
            <div class="col-sm-4">
              <label class="col-sm-12 col-form-label">Approximate Weight (kg)</label>
              <input type="number" class="col-sm-12 form-control" v-model="meta_data.userinfo.weight" placeholder="Weight">
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <label class="col-sm-12 col-form-label">Position</label>
              <playerposition v-once :value="meta_data.userinfo.playing_position" v-on:update:val="meta_data.userinfo.playing_position = $event"
              />
            </div>
            <div class="col-sm-6">
              <label class="col-sm-12 col-form-label">Preferred Foot</label>
              <preferredfoot v-once :value="meta_data.userinfo.preferred_foot" v-on:update:val="meta_data.userinfo.preferred_foot = $event"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6">
              <label class="col-sm-12 col-form-label">Nationality</label>
              <countryselect v-once :value="meta_data.userinfo.nationality_country_code" v-on:update:val="meta_data.userinfo.nationality_country_code = $event"
              /> </div>
            <div class="col-sm-6">
              <label class="col-sm-12 col-form-label">Based In</label>
              <countryselect v-once :value="meta_data.userinfo.residence_country_code" v-on:update:val="meta_data.userinfo.residence_country_code = $event"
              />
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12">
              <label class="col-sm-12 col-form-label">Language(s)</label>
              <language :value="meta_data.userinfo.languages" v-on:update:val="meta_data.userinfo.languages = $event" />
            </div>
          </div>
        </div>
      </transition>
    </div>
    <h3 class="menu" @click="transfersummary = !transfersummary" :class="transfersummary ? 'active' : ''">
      <i class="sub-menu-arrow" :class="transfersummary ? 'active' : ''"></i> Transfer Summary </h3>
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
              <label class="col-sm-12 interested col-form-label" :class="meta_data.transfer_sum.transfer_interested == 'true' ? 'active' : ''">
                <span class="title">Interested in Transfer ?</span>
                <i class="sub-menu-arrow" :class="meta_data.transfer_sum.transfer_interested == 'true' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="meta_data.transfer_sum.transfer_interested" v-on:update:val="meta_data.transfer_sum.transfer_interested = $event"
                />
              </label>
              <transition name="fade">
                <div class="transfer-value col-sm-12 row" v-if="meta_data.transfer_sum.transfer_interested === 'true'">
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
              <label class="col-sm-12 interested col-form-label" :class="meta_data.transfer_sum.loan_interested == 'true' ? 'active' : ''">
                <span class="title">Interested in Loan ?</span>
                <i class="sub-menu-arrow" :class="meta_data.transfer_sum.loan_interested == 'true' ? 'active' : ''"></i>
                <ftcheckbox class="ftcheckbox" :value="meta_data.transfer_sum.loan_interested" v-on:update:val="meta_data.transfer_sum.loan_interested = $event"
                />
              </label>
              <transition name="fade">
                <div class="transfer-value col-sm-12 row" v-if="meta_data.transfer_sum.loan_interested === 'true'">
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
    <div class="form-group row">
      <div class="form-group row attachments-div col-md-6">
        <label class="col-md-12 col-form-label">Add Attachments:
          <input type="file" name="files" ref="myFiles" @change="previewFiles" multiple class="col-md-4">
        </label>
        <div class="col-md-12">
          <ul class="col-md-6">
            <li class="list" v-for="file in files" :key="file.id"> {{file.name}} </li>
          </ul>
        </div>
      </div>
      <div v-if="report" class="form-group row col-md-6">
        <label class="col-sm-12">Current Attachments</label>
        <div class="update-attachments col col-sm-12" v-for="attachment in report.report_data.attachments.attachments" :key="attachment.id">
          <div class="col col-sm-12 file" :class="remove_attachment[attachment.id]?'removed':'remove'" @click="removeAttachment(attachment.id)">
            <p>{{attachment.filename}}</p>
            <p class="col col-sm-2">
              <icon name='trash'></icon>
            </p>
          </div>
        </div>
      </div>
    </div>
    <div class="form-group buttons">
      <button v-if="!report" id="submit" class="btn btn-primary" @click="handleSubmit">Publish</button>
      <button v-if="report" id="submit" class="btn btn-primary" @click="handleSubmit">Update</button>
      <button @click="cancelAction" id="cancel" name="cancel" class="btn btn-default">Cancel</button>
    </div>
  </form>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .fade-enter-active,
  .fade-leave-active {
    transition: all 0.75s;
    max-height: 500px;
  }

  .fade-enter,
  .fade-leave-to {
    opacity: 0;
    max-height: 0px;
  }

  #report-form {
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
    h3 {
      &.menu {
        cursor: pointer;
      }
    }
    .interested {
      text-align: left;
      font-size: 14px;
      cursor: pointer;
      .ftcheckbox {
        transform: scale(0.7);
        float: left;
        margin-right: 20px;
      }
      .sub-menu-arrow {
        float: right;
      }
      .title {
        margin-top: 10px;
        display: inline-block;
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
    label {
      font-size: 12px;
    }
    h3 {
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
    .list {
      color: #535ee2;
    }
    .attachments-div {
      ul {
        li {
          display: list-item;
          list-style: disc;
        }
      }
    }

    .price-input {
      .info {
        color: green;
        font-weight: bold;
        margin: 0;
        float: left;
      }
    }
    .button {
      padding: 10px;
    }
    .form-group {
      label {
        color: $main-text-color;
      }
      .bar-button {
        color: $main-text-color;
        border: 1px solid $main-text-color;
      }
    }
    textarea {
      resize: none;
      min-height: 130px;
      overflow-y: scroll;
    }
    .text-input {
      height: 100px;
    }
    .buttons {
      float: right;
      button {
        margin: 0;
        padding: 4px;
        border-radius: 4px;
        color: white;
        min-height: 20px;
        color: $main-text-color;
        border: 1px solid $main-text-color;
        background-color: $button-background;
        cursor: pointer;
        &:hover {
          background-color: $button-background-hover;
        }
      }
    }
    overflow: hidden;
    .update-attachments {
      color: $main-text-color;
      .file {
        cursor: pointer;
        &.removed {
          p {
            text-decoration: line-through;
            color: red;
          }
          .fa-icon {
            color: green;
          }
        }
        &.remove {
          .fa-icon {
            color: red;
          }
        }
        p {
          display: inline-block;
        }
      }
    }
  }
</style>

<script>
  import MatchAnalyzed from './MatchAnalyzed';
  import PlayerPosition from 'app/components/Input/PlayerPosition';
  import Nationality from 'app/components/Input/Nationality';
  import Language from 'app/components/Input/Language';
  import PreferredFoot from 'app/components/Input/PreferredFoot';
  import FtCheckbox from 'app/components/Input/FtCheckbox';
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
      icon: Icon,
      currencyinput: CurrencyInput
    },
    props: ['userinfo', 'submitReport', 'reportStatus', 'report', 'cancelAction'],
    data() {
      return {
        playersummary: true,
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
          this.meta_data.userinfo.age = Math.abs(ageDate.getUTCFullYear() - 1970);
          this.meta_data.userinfo.weight = this.userinfo.weight;
          this.meta_data.userinfo.height = this.userinfo.height;
          this.meta_data.userinfo.preferred_foot = this.userinfo.preferred_foot;
          this.meta_data.userinfo.playing_position = [];
          if (this.userinfo.playing_position) {
            this.meta_data.userinfo.playing_position = JSON.parse(this.userinfo.playing_position);
          }
        }
      }
    },
    beforeMount() {
      if (this.report) {
        this.meta_data = this.report.report_data.meta_data;
        this.price = this.report.price;
        this.headline = this.report.headline;
      }
    },
    methods: {
      removeAttachment(id) {
        var obj = this.remove_attachment;
        if (this.remove_attachment[id] === true) delete obj[id];
        else {
          obj[id] = true;
        }
        this.remove_attachment = Object.assign({}, obj);
      },
      previewFiles() {
        this.files = this.$refs.myFiles.files;
      },
      handleSubmit() {
        var report = {
          headline: this.headline,
          price: this.price,
          report_data: this.meta_data,
          remove_attachment: this.remove_attachment
        };
        this.submitReport(report, this.$refs.myFiles.files);
        $('html, body').animate({
            scrollTop: 0
          },
          100
        );
      }
    }
  };
</script>
