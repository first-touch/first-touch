<template>
  <div>
    <form @submit.prevent class="report-form ft-form">
      <div class="form-group row report-name">
        <div class="col-lg-12 required-before">
          <input type="text" class="col-lg-12 form-control" v-model="headline" placeholder="Report name" name="name" v-validate="'required'">
          <span class="text-danger">{{ errors.first('name') }}</span>
        </div>
      </div>
      <div class="form-group" v-if="!request && hasBankAccount">
        <div class="col-lg-12">
          <div class="price-input">
            <currencyinput :value="price" placeholder="Price" />
            <p v-if="price.value == 0" class="info">The report will be free</p>
          </div>
        </div>
      </div>
      <div class="form-group">
        <label class=" col-lg-12">Analysis of Trainings/Matches</label>
        <matchanalyzed :analyzed_matches="meta_data.analyzed_matches" type="team" />
      </div>
      <div class="form-group col-lg-12">
        <div class="row">
          <textarea v-model="meta_data.formation" class="col col-lg-12 form-control" v-autosize="meta_data.formation" placeholder="Formation(s) Used & Playing Style"
          />
        </div>
      </div>
      <div class="form-group col-lg-12">
        <div class="row">
          <textarea v-model="meta_data.attacking_organisation" class="col col-lg-12 form-control" v-autosize="meta_data.attacking_organisation"
            placeholder="Attacking organisation & Transition After Winning Possession" />
        </div>
      </div>
      <div class="form-group col-lg-12">
        <div class="row">
          <textarea v-model="meta_data.defensive_organisation" class="col col-lg-12 form-control" placeholder="Defensive Organisation & Transition After Losing Possession"
            v-autosize="meta_data.defensive_organisation" />
        </div>
      </div>
      <div class="form-group col-lg-12">
        <div class="row">
          <textarea v-model="meta_data.setplays_for" class="col col-lg-12 form-control" placeholder="Set plays - For" v-autosize="meta_data.setplays_for"
          />
        </div>
      </div>
      <div class="form-group col-lg-12">
        <div class="row">
          <textarea v-model="meta_data.setplays_against" class="col col-lg-12 form-control" placeholder="Set plays - Against" v-autosize="meta_data.setplays_against"
          />
        </div>
      </div>
      <div class="form-group col-lg-12">
        <div class="row">
          <textarea v-model="meta_data.main_threats" class="col col-lg-12 form-control" placeholder="Main threats" v-autosize="meta_data.main_threats"
          />
        </div>
      </div>
      <div class="form-group col-lg-12">
        <div class="row">
          <textarea v-model="meta_data.observations" class="col col-lg-12 form-control" placeholder="Other Observations & Viewpoints to Note"
            v-autosize="meta_data.observations" />
        </div>
      </div>
      <div class="form-group col-lg-12">
        <div class="row">
          <textarea v-model="meta_data.conclusion" class="col col-lg-12 form-control" placeholder="Conclusion" v-autosize="meta_data.conclusion"
          />
        </div>
      </div>
      <div class="form-group col-lg-12">
        <div>
          <addattachments :attachments="report ? report.attachments.attachments : null" v-on:update:remove="remove_attachment = $event"
            v-on:update:files="files = $event" />
        </div>
      </div>

      <div class="row float-right">
        <button v-if="!report && !request" id="submit" class="btn btn-primary mr-1" @click="handleSubmit('publish')">Publish</button>
        <button v-if="report" id="submit" class="btn btn-primary mr-1" @click="handleSubmit(report.status)">Update</button>
        <button v-if="!report && request" id="submit" class="btn btn-primary mr-1" @click="handleSubmit('private')">Send Report</button>
        <button @click="cancelAction" id="cancel" name="cancel" class="btn btn-danger">Cancel</button>
      </div>
    </form>
  </div>
</template>

<script>
  import MatchAnalyzed from 'app/components/Input/MatchAnalyzed';
  import CurrencyInput from 'app/components/Input/CurrencyInput';
  import AddAttachments from 'app/components/Input/AddAttachments';

  export default {
    name: 'TeamReportForm',
    props: ['submitReport', 'report', 'cancelAction', 'request', 'hasBankAccount', 'category'],
    components: {
      matchanalyzed: MatchAnalyzed,
      currencyinput: CurrencyInput,
      addattachments: AddAttachments
    },
    data() {
      return {
        files: [],
        meta_data: {
          category: this.category,
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
      handleSubmit(status) {
        this.$validator.validateAll().then(() => {
          if (this.errors.items.length == 0) {
            var report = {
              headline: this.headline,
              price: this.price,
              meta_data: this.meta_data,
              remove_attachment: this.remove_attachment,
              status,
              files: this.files
            };
            this.submitReport(report);
          }
        }).catch(() => {});
        setTimeout(function () {
          var error = $('.text-danger:not(:empty):first')
          var y = error.offset() ? error.offset().top - 200 : 0;
          $('html, body').animate({
              scrollTop: y
            },
            200
          );
        }, 200);

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
