<template>
  <div>
    <form @submit.prevent id="report-form ft-form">
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
  </div>
</template>
<style lang="scss">
@import '~stylesheets/form';
</style>


<script>
import MatchAnalyzed from 'app/components/Input/MatchAnalyzed';
import CurrencyInput from 'app/components/Input/CurrencyInput';
import AddAttachments from 'app/components/Input/AddAttachments';

export default {
  name: 'ClubReportForm',
  props: ['submitReport', 'reportStatus', 'report', 'cancelAction', 'request','team_id'],
  components: {
    matchanalyzed: MatchAnalyzed,
    currencyinput: CurrencyInput,
    addattachments: AddAttachments
  },
  data() {
    return {
      files: [],
      meta_data: {
        analyzed_matches: [
          {
            date: '',
            opponent: '',
            venue: '',
            result: ''
          }
        ]
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
    handleSubmit(status) {
      var report = {
        headline: this.headline,
        price: this.price,
        meta_data: this.meta_data,
        remove_attachment: this.remove_attachment,
        status
      };
      this.submitReport(report, this.files,status);
      $('html, body').animate(
        {
          scrollTop: 0
        },
        100
      );
    }
  },
  mounted() {
    if (this.report) {
      this.meta_data = this.report.meta_data;
      this.price = this.report.price;
      this.headline = this.report.headline;
    }
  }
};
</script>
