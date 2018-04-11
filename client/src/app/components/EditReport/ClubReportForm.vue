<template>
  <div>
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
            <p v-if="price.value == 0" class="info">The report will be free</p>
          </div>
        </div>
      </div>
      <div class="form-group">
        <label class=" col-md-12">Analysis of Trainings/Matches</label>
        <matchanalyzed :analyzed_matches="meta_data.analyzed_matches" type="team" />
      </div>
      <div class="form-group col-md-12">
        <label>Formation(s) Used & Playing Style</label>
        <div class="row">
          <textarea v-model="meta_data.formation" class="col col-md-12 form-control" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Attacking organisation & Transition After Winning Possession</label>
        <div class="row">
          <textarea v-model="meta_data.attacking_organisation" class="col col-md-12 form-control" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Defensive Organisation & Transition After Losing Possession</label>
        <div class="row">
          <textarea v-model="meta_data.defensive_organisation" class="col col-md-12 form-control" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Set plays - For</label>
        <div class="row">
          <textarea v-model="meta_data.setplays_for" class="col col-md-12 form-control" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Set plays - Against</label>
        <div class="row">
          <textarea v-model="meta_data.setplays_against" class="col col-md-12 form-control" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Main threats</label>
        <div class="row">
          <textarea v-model="meta_data.main_threats" class="col col-md-12 form-control" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Other Observations & Viewpoints to Note</label>
        <div class="row">
          <textarea v-model="meta_data.observations" class="col col-md-12 form-control" />
        </div>
      </div>
      <div class="form-group col-md-12">
        <label>Conclusions</label>
        <div class="row">
          <textarea v-model="meta_data.conclusions" class="col col-md-12 form-control" />
        </div>
      </div>
      <addattachments :attachments="report ? report.report_data.attachments.attachments : null" v-on:update:remove="remove_attachment = $event"
        v-on:update:files="files = $event" />
      <div class="form-group buttons">
        <button id="submit" class="btn btn-primary" @click="handleSubmit">Publish</button>
        <button @click="cancelAction" id="cancel" name="cancel" class="btn btn-default">Cancel</button>
      </div>
    </form>

  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .info {
    color: green;
    font-weight: bold;
    margin: 0;
  }

  #report-form {
    textarea {
      resize: none;
      overflow-y: scroll;
      height: 100px;
    }
    .label-price {
      margin-top: 8px;
    }
    .col-form-label {
      margin-right: 20px;
    }
    label {
      font-size: 13px;
    }
    h3 {
      color: $main-text-color;
      font-size: 15px;
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
      p {
        display: inline-block;
        &.removed {
          text-decoration: line-through;
        }
        &.remove {
          color: red;
          cursor: pointer;
        }
        &.filename {
          text-overflow: ellipsis;
          white-space: nowrap;
          overflow: hidden;
        }
      }
    }
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
</style>

<script>
  import MatchAnalyzed from 'app/components/Input/MatchAnalyzed';
  import CurrencyInput from 'app/components/Input/CurrencyInput';
  import AddAttachments from 'app/components/Input/AddAttachments';

  export default {
    name: 'ClubReportForm',
    props: ['submitReport', 'reportStatus', 'report', 'cancelAction'],
    components: {
      matchanalyzed: MatchAnalyzed,
      currencyinput: CurrencyInput,
      addattachments: AddAttachments
    },
    data() {
      return {
        files: [],
        meta_data: {
          analyzed_matches: [{
            date: '',
            opponent: '',
            venue: '',
            result: ''
          }]
        },
        price: {
          value: 0,
          currency: 'USD'
        },
        headline: '',
        remove_attachment: {}
      };
    },
    methods: {
      removeAttachment(id) {
        if (this.remove_attachment[id] === true) this.remove_attachment[id] = false;
        else {
          var obj = {};
          obj[id] = true;
          this.remove_attachment = Object.assign({}, this.remove_attachment, obj);
        }
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
        this.submitReport(report, this.files);
        $('html, body').animate({
            scrollTop: 0
          },
          100
        );
      }
    },
    mounted() {
      if (this.report) {
        this.meta_data = this.report.report_data.meta_data;
        this.price = this.report.price;
        this.headline = this.report.headline;
      }
    }
  };
</script>
