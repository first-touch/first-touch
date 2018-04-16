<template>
  <form @submit.prevent id="report-form">
    <div class="form-group row report-name">
      <div class="col-sm-10">
        <label class="col-form-label">Report Name</label>
        <input type="text" class="col-md-6" v-model="headline">
      </div>
    </div>
    <h3> Player Summary </h3>
    <div class="form-group form-inner">
      <div class="form-group">
        <div class="row">
          <label class="col-sm-2 col-form-label">Age</label>
          <div class="col-sm-10">
            <input type="number" class="col-sm-4" v-model="meta_data.player_info.age">
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Approximate Height (cm)</label>
          <div class="col-sm-10">
            <input type="number" class="col-sm-4" v-model="meta_data.player_info.height">
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Approximate Weight (kg)</label>
          <div class="col-sm-10">
            <input type="number" class="col-sm-4" v-model="meta_data.player_info.weight">
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Nationality</label>
          <div class="col-sm-10">
            <countryselect :value="meta_data.player_info.nationality_country_code" v-on:update:val="meta_data.player_info.nationality_country_code = $event"  />
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Based In</label>
          <div class="col-sm-10">
            <countryselect :value="meta_data.player_info.residence_country_code"  v-on:update:val="meta_data.player_info.residence_country_code = $event" />
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Language</label>
          <div class="col-sm-10">
            <language class="col-sm-12" :value="meta_data.player_info.languages" v-on:update:val="meta_data.player_info.languages = $event"/>
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Position</label>
          <div class="col-sm-10">
            <playerposition class="col-sm-12" :value="meta_data.player_info.playing_position" v-on:update:val="meta_data.player_info.playing_position = $event" />
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Preferred Foot</label>
          <div class="col-sm-10">
            <preferredfoot :value="meta_data.player_info.preferred_foot"  v-on:update:val="meta_data.player_info.preferred_foot = $event" />
          </div>
        </div>
      </div>
    </div>
    <h3> Transfert Summary </h3>
    <div class="form-group form-inner">
      <div class="form-group">
        <div class="row">
          <label class="col-sm-2 col-form-label">Interested in Transfert</label>
          <div class="col-sm-10 radio-group">
            <label class="radio-inline">
              <input type="radio" id="one" value="true" v-model="meta_data.transfert_sum.transfert_interested">Yes</label>
            <label class="radio-inline">
              <input type="radio" id="one" value="false" v-model="meta_data.transfert_sum.transfert_interested">No</label>
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Availability for transfert</label>
          <div class="col-sm-10">
            <input type="number" v-model="meta_data.transfert_sum.transfert_availability" class="col-sm-4">
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Transfert Budget</label>
          <div class="col-sm-10">
            <input type="number" v-model="meta_data.transfert_sum.transfert_budget" class="col-sm-4">
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Interested in Loan</label>
          <div class="col-sm-10 radio-group">
            <label class="radio-inline">
              <input type="radio" id="one" value="true" v-model="meta_data.transfert_sum.loan_interested">Yes</label>
            <label class="radio-inline">
              <input type="radio" id="one" value="false" v-model="meta_data.transfert_sum.loan_interested">No</label>
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Availability for Loan</label>
          <div class="col-sm-10">
            <input type="number" v-model="meta_data.transfert_sum.loan_availability" class="col-sm-4">
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">End of Contract</label>
          <div class="col-sm-10">
            <input type="number" v-model="meta_data.transfert_sum.contract_end" class="col-sm-4">
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Free agent</label>
          <div class="col-sm-10 radio-group">
            <label class="radio-inline">
              <input type="radio" id="one" value="true" v-model="meta_data.transfert_sum.free_agent">Yes</label>
            <label class="radio-inline">
              <input type="radio" id="one" value="false" v-model="meta_data.transfert_sum.free_agent">No</label>
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Agent Commission</label>
          <div class="col-sm-10">
            <input type="number" v-model="meta_data.transfert_sum.agent_commission" class="col-sm-4">
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Wage (SGD per year) </label>
          <div class="col-sm-10">
            <input type="number" v-model="meta_data.transfert_sum.wage" class="col-sm-4">
          </div>
        </div>
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Current Ability Overview</label>
      <div class="col-md-12">
        <textarea class="col-md-8" v-model="meta_data.overview" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Physical Attribute(s)</label>
      <div class="col-md-12">
        <textarea class="col-md-8" v-model="meta_data.physical_attributes" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Mental Attribute(s)</label>
      <div class="col-md-12">
        <textarea class="col-md-8" v-model="meta_data.mental_attributes" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Technical Attribute(s)</label>
      <div class="col-md-12">
        <input type="text" class="col-md-8" v-model="meta_data.technical_attributes" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Personality</label>
      <div class="col-md-12">
        <input type="text" class="col-md-8" v-model="meta_data.personality" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Potential</label>
      <div class="col-md-12">
        <input type="text" class="col-md-8" v-model="meta_data.potential" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Other Observations & Viewpoints To Note</label>
      <div class="col-md-12 ">
        <input type="text" class="col-md-8" v-model="meta_data.observations" />
      </div>
    </div>
    <div class="form-group">
      <label>Analysis of Trainings/Matches</label>
      <matchanalyzed :analyzed_matches="meta_data.analyzed_matches" type="player" />
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Conclusions</label>
      <div class="col-md-12">
        <input type="text" class="col-md-8" v-model="meta_data.conclusion" />
      </div>
    </div>
    <div class="form-group row attachments-div">
      <label class="col-md-12 col-form-label">Attachments:</label>
      <div class="col-md-12">
        <input type="file" name="files" ref="myFiles" @change="previewFiles" multiple class="col-md-4">
        <ul class="col-md-6">
          <li class="list" v-for="file in files" :key="file.id"> {{file.name}} </li>
        </ul>
      </div>
    </div>
    <div v-if="report">
      <div class="form-group row update-attachments" v-for="attachment in report.attachments.attachments" :key="attachment.id">
        <label class="col-sm-2">Attachment</label>
        <div class="col col-sm-6">
          <p v-bind:class="[{ 'removed' : remove_attachment[attachment.id] }]">{{attachment.filename}}</p>
          <p class="remove col col-sm-2" @click="removeAttachment(attachment.id)">X</p>
        </div>
      </div>
    </div>
    <div class="form-group col-md-12">
      <div class="row">
        <label class="col-md-2 label-price">Price (in SGD)</label>
        <div class="price-input col-md-6">
          <input type="number" v-model="price" class="form-control" min="0" max="999999" />
          <p v-if="price == 0" class="info">The report will be free</p>
        </div>
      </div>
    </div>
    <div class="form-group buttons">
      <button id="submit" class="btn btn-primary" @click="handleSubmit">Publish</button>
      <button @click="cancelAction" id="cancel" name="cancel" class="btn btn-default">Cancel</button>
    </div>
  </form>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
#report-form {
  .radio-group {
    label {
      width: 10%;
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
      float: right;
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
    overflow-y: scroll;
  }
  .text-input {
    height: 100px;
  }
  .buttons {
    float: right;
  }
  overflow: hidden;
  .update-attachments {
    color: $main-text-color;
    p {
      display: inline-block;
      &.removed {
        text-decoration: line-through;
      }
      &.remove {
        color: red;
        cursor: pointer;
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

export default {
  name: 'PlayerReportForm',
  components: {
    matchanalyzed: MatchAnalyzed,
    playerposition: PlayerPosition,
    countryselect: Nationality,
    language: Language,
    preferredfoot: PreferredFoot
  },
  props: ['player_info', 'submitReport', 'reportStatus', 'report','cancelAction'],
  data () {
    return {
      meta_data: {
        player_info: {
          nationality_country_code: '',
          languages: [],
          playing_position: [],
          age: null
        },
        transfert_sum: {
          loan_interested: false,
          transfert_interested: false,
          free_agent: 'false'
        },
        analyzed_matches: [
          {
            date: '',
            opponent: '',
            venue: '',
            comment: ''
          }
        ]
      },
      price: 0,
      headline: '',
      edit_mode: !this.report,
      files: [],
      remove_attachment: {}
    };
  },
  watch: {
    player_info () {
      if (this.player_info.birthday) {
        var birthday = new Date(this.player_info.birthday);
        var ageDifMs = Date.now() - birthday.getTime();
        var ageDate = new Date(ageDifMs); // miliseconds from epoch
        this.meta_data.player_info.age = Math.abs(ageDate.getUTCFullYear() - 1970);
        this.meta_data.player_info.weight = this.player_info.weight;
        this.meta_data.player_info.height = this.player_info.height;
        this.meta_data.player_info.preferred_foot = this.player_info.preferred_foot;
        this.meta_data.player_info.playing_position = [];
        if (this.player_info.playing_position) {
          this.meta_data.player_info.playing_position = JSON.parse(this.player_info.playing_position);
        }
      }
    }
  },
  mounted () {
    if (this.report) {
      this.meta_data = this.report.meta_data;
      this.price = this.report.price;
      this.headline = this.report.headline;
    }
  },
  methods: {
    removeAttachment (id) {
      if (this.remove_attachment[id] === true) delete this.remove_attachment[id];
      else {
        var obj = new Object();
        obj[id] = true;
        this.remove_attachment = Object.assign({}, this.remove_attachment, obj);
      }
    },
    previewFiles () {
      this.files = this.$refs.myFiles.files;
    },
    handleSubmit () {
      var report = {
        headline: this.headline,
        price: this.price,
        meta_data: this.meta_data,
        remove_attachment: this.remove_attachment
      };
      this.submitReport(report, this.$refs.myFiles.files);
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
