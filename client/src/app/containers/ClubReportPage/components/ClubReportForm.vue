<template>
  <div>
    <form @submit.prevent="handleSubmit" id="report-form" v-if="clubId">
      <ul class="error" v-if="reportStatus">
        <li v-for="(error) in reportStatus.errors.error" v-bind:key="error.id">
          {{ error }}
        </li>
      </ul>
      <fieldset class="form-group col-md-12">
        <label>HeadLine</label>
        <div class="row">
          <input type="text" v-model="headline" class="form-control col-md-12" placeholder="ibrouf Kambra the new star of tomorrow"
          />
        </div>
      </fieldset>
      <fieldset class="form-group col-md-12">
        <label>Price</label>
        <div class="row">
          <input type="number" v-model="price" class="form-control col-md-12" min="0" max="999999" />
        </div>
        <p v-if="price == 0" class="info">The report will be free</p>
      </fieldset>
      <fieldset class="form-group col-md-12">
        <label class="form-group row col-md-2">Matches Analysed</label>
        <div class="row row_match_analyzed" v-for="(match, index) in report_data.analyzed_matches" v-bind:key="match.id">
          <input type="text" v-model="match.date" class="col col-md-2" placeholder="Date" />
          <input type="text" v-model="match.opponent" class="col col-md-2" placeholder="opponent" />
          <input type="text" v-model="match.venue" class="col col-md-2" placeholder="venue" />
          <input type="text" v-model="match.result" class="col col-md-2" placeholder="Result (Win,Draw,Lose) and score" />
          <a v-if="report_data.analyzed_matches.length > 1" @click="removeRowMatches(index)">X</a>
        </div>
        <button class="button row btn-primary" @click="addRowMatches">Add Match</button>
      </fieldset>
      <fieldset class="form-group col-md-12">
        <label>Formation Used</label>
        <div class="row">
          <textarea v-model="report_data.formaton" class="col col-md-12" />
        </div>
      </fieldset>
      <fieldset class="form-group col-md-12">
        <label>Attacking organisation</label>
        <div class="row">
          <textarea v-model="report_data.attacking_organisation" class="col col-md-12" />
        </div>
      </fieldset>
      <fieldset class="form-group col-md-12">
        <label>Defensive Organisation</label>
        <div class="row">
          <textarea v-model="report_data.defensive_organisation" class="col col-md-12" />
        </div>
      </fieldset>
      <fieldset class="form-group col-md-12">
        <label>Set plays - For</label>
        <div class="row">
          <textarea v-model="report_data.setplays_for" class="col col-md-12" />
        </div>
      </fieldset>
      <fieldset class="form-group col-md-12">
        <label>Set plays - Against</label>
        <div class="row">
          <textarea v-model="report_data.setplays_against" class="col col-md-12" />
        </div>
      </fieldset>
      <fieldset class="form-group col-md-12">
        <label>Main threats</label>
        <div class="row">
          <textarea v-model="report_data.main_threats" class="col col-md-12" />
        </div>
      </fieldset>
      <fieldset class="form-group col-md-12">
        <label>Observations</label>
        <div class="row">
          <textarea v-model="report_data.observations" class="col col-md-12" />
        </div>
      </fieldset>
      <fieldset class="form-group col-md-12">
        <label>Conclusions</label>
        <div class="row">
          <textarea v-model="report_data.conclusions" class="col col-md-12" />
        </div>
      </fieldset>
      <fieldset class="form-group col-md-12">
        <button type="submit" class="bar-button center">Save</button>
      </fieldset>
    </form>
    <div v-if="!clubId" class="error">
      Create new club is not available right now
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .error {
    color: red;
  }

  .info {
    color: green;
    font-weight: bold;
    margin: 0;
  }

  .row_match_analyzed {
    margin-top: 20px;
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
</style>

<script>
  export default {
    name: 'ClubReportForm',
    props: [
      'clubId',
      'createReport',
      'reportStatus'
    ],
    data() {
      return {
        report_data: {
          analyzed_matches: [{
            date: '',
            opponent: '',
            venue: '',
            result: ''
          }],
        },
        price: 0,
        headline: ''
      };
    },
    methods: {
      handleSubmit() {
        var report = {
          headline: this.headline,
          price: this.price,
          type_report: "club",
          club_id: this.club_id,
          report: this.report_data,
        }
        this.createReport(report)
        var container = this.$el.querySelector("#report-form");
        $('html, body').animate({
          scrollTop: 0
        }, 100);
      },
      addRowMatches: function () {
        this.report_data.analyzed_matches.push({
          date: '',
          opponent: '',
          venue: '',
          result: ''
        })
      },
      removeRowMatches: function (index) {
        this.report_data.analyzed_matches.length > 1 ? this.report_data.analyzed_matches.splice(index, 1) : ''
      }
    }
  };
</script>
