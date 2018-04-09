<template>
  <div class="report col-md-12">
    <div v-if="report.id">
      <div class="row">
        <p class="col-sm-4">Purchassed Price (IN SGD) {{report.price}} </p>
      </div>
      <div class="row">
        <span class="col-sm-12">Player Name :
                <router-link :to="'/users/' + report.player.id + '/profile'">{{report.player.first_name}} {{report.player.last_name}}</router-link>
                       </span>
      </div>
      <div class="row">
        <span class="col-sm-12">Report Name : {{report.headline}} </span>
      </div>
      <div class="reportDate">
        <div class="row">
          <span class="col-sm-12">Create on {{report.report_data.created_at | moment}} </span>
        </div>
        <div class="row">
          <span class="col-sm-12">Updated on {{report.report_data.updated_at | moment}} </span>
        </div>
      </div>
      <div class="metas">
        <div class="row">
          <label class="col-sm-4">Age </label>
          <span class="col-sm-4"> {{report.report_data.meta_data.userinfo.age}} </span>
        </div>
        <div class="row">
          <label class="col-sm-4">Approximate Height </label>
          <span class="col-sm-4">{{report.report_data.meta_data.userinfo.weight}}</span>
        </div>
        <div class="row">
          <label class="col-sm-4">Approximate Weight </label>
          <span class="col-sm-4"> {{report.report_data.meta_data.userinfo.height}}</span>
        </div>

        <div class="row">
          <label class="col-sm-4">Nationality </label>
          <span class="col-sm-4">{{getNationality(report.report_data.meta_data.userinfo.nationality_country_code)}} </span>
        </div>

        <div class="row">
          <label class="col-sm-4">Based In</label>
          <span class="col-sm-4"> {{report.report_data.meta_data.userinfo.residence_country_code}}</span>
        </div>
        <div class="row">
          <label class="col-sm-4">Language(s) </label>
          <span class="col-sm-8"> <span v-for="language in report.report_data.meta_data.userinfo.languages" class="list" :key="language.id"> {{getLanguage(language)}} </span> </span>
        </div>
        <div class="row">
          <label class="col-sm-4">Position(s) </label>
          <span class="col-sm-8"> <span v-for="position in report.report_data.meta_data.userinfo.playing_position" class="list" :key="position.id">{{position}}</span> </span>
        </div>
        <div class="row">
          <label class="col-sm-4">Preferred Foot </label>
          <span class="col-sm-2"> {{report.report_data.meta_data.userinfo.preferred_foot == "R" ? "Right" : "Left"}} </span>
        </div>
        <div class="row">
          <label class="col-sm-4">Interested in Transfer </label>
          <span class="col-sm-4"> {{report.report_data.meta_data.transfer_sum.transfer_interested}} </span>
        </div>
        <div class="row">
          <label class="col-sm-4">Availability for transfer</label>
          <span class="col-sm-4"> {{report.report_data.meta_data.transfer_sum.transfer_availability }} </span>
        </div>
        <div class="row">
          <label class="col-sm-4">Transfer Budget </label>
          <span class="col-sm-4"> {{report.report_data.meta_data.transfer_sum.transfer_budget}} </span>
        </div>
        <div class="row">
          <label class="col-sm-4">Interested in Loan</label>
          <span class="col-sm-4"> {{report.report_data.meta_data.transfer_sum.loan_interested}} </span>
        </div>
        <div class="row">
          <label class="col-sm-4">Availability for Loan</label>
          <span class="col-sm-4"> {{report.report_data.meta_data.transfer_sum.loan_availability}} </span>
        </div>
        <div class="row">
          <label class="col-sm-4">End of Contract</label>
          <span class="col-sm-4"> {{report.report_data.meta_data.transfer_sum.contract_end}} </span>
        </div>
        <div class="row">
          <label class="col-sm-4">Free agent</label>
          <span class="col-sm-4"> {{report.report_data.meta_data.transfer_sum.free_agent}} </span>
        </div>
        <div class="row">
          <label class="col-sm-4">Agent Commission</label>
          <span class="col-sm-4"> {{report.report_data.meta_data.transfer_sum.agent_commission}} </span>
        </div>
        <div class="row">
          <label class="col-sm-4">Wage (SGD per year) </label>
          <span class="col-sm-4"> {{report.report_data.meta_data.transfer_sum.wage}} </span>
        </div>
        <div>
          <label class="row col-sm-12">Analyzed Matches</label>
          <table class="analyzed_matches">
            <thead>
              <tr>
                <th scope="col" class=" index"></th>
                <th scope="col" class="col-md-2">Date</th>
                <th scope="col" class="col-md-2">Opponent</th>
                <th class="col-md-2">Venue</th>
                <th class="col-md-2">Training Observed </th>
                <th class="col-md-2">Comment</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(match, index) in report.report_data.meta_data.analyzed_matches" v-bind:key="match.id">
                <td class="index">
                  {{index}}
                </td>
                <td>
                  <p> {{match.date | moment }} </p>
                </td>
                <td>
                  <p> {{match.opponent}} </p>
                </td>
                <td>
                  <p> {{match.venue}} </p>
                </td>
                <td>
                  <p>{{match.training}} </p>
                </td>
                <td>
                  <p> {{match.comment}} </p>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div class="meta">
          <label class="row col-sm-12">Current Ability Overview</label>
          <p class="row col-sm-12">{{report.report_data.meta_data.overview}} </p>
        </div>
        <div class="meta">
          <label class="row col-sm-12">Physical Attribute(s)</label>
          <p class="row col-sm-12"> {{report.report_data.meta_data.physical_attributes}} </p>
        </div>
        <div class="meta">
          <label class="row col-sm-12">Mental Attribute(s)</label>
          <p class="row col-sm-12"> {{report.report_data.meta_data.mental_attributes}} </p>
        </div>
        <div class="meta">
          <label class="row col-sm-12">Technical Attribute(s)</label>
          <p class="row col-sm-12"> {{report.report_data.meta_data.technical_attributes}} </p>
        </div>
        <div class="meta">
          <label class="row col-sm-12">Personality</label>
          <p class="row col-sm-12"> {{report.report_data.meta_data.personality}}</p>
        </div>
        <div class="meta">
          <label class="row col-sm-12">Potential</label>
          <p class="row col-sm-12"> {{report.report_data.meta_data.potential}} </p>
        </div>
        <div class="meta">
          <label class="row col-sm-12">Other Observations & Viewpoints To Note</label>
          <p class="row col-sm-12"> {{report.report_data.meta_data.observations}} </p>
        </div>
        <div class="meta">
          <label class="row col-sm-12">Conclusion</label>
          <p class="row col-sm-12"> {{report.report_data.meta_data.conclusion}} </p>
        </div>
        <div>
          <label class="row col-sm-12">Attachments</label>
          <div class="row col-sm-12">
            <button v-for="attachment in report.report_data.attachments.attachments" :key="attachment.id" class="btn-info btn-attachments" @click="downloadFile(attachment.id, attachment.filename)"> {{attachment.filename}}</button>

          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.report {
  .reportDate {
    margin-left: 30px;
    margin-bottom: 20px;
  }
  .btn-attachments {
    cursor: pointer;
    padding: 20px;
    margin-right: 20px;
  }
  .list {
    text-transform: capitalize;
  }
  .meta {
    margin: 20px 0;
    p {
      margin-left: 20px;
    }
  }
}

.analyzed_matches {
  margin: 0;
  td,
  th {
    border: 0;
    width: 10%;
    text-align: center;
  }
  tr {
    border-bottom: 2px dashed black;
  }
  td {
    padding: 0;
    margin: 0;
  }
  .index {
    width: 1%;
    max-width: 10px;
  }
  p {
    border: none;
    padding: 0;
    margin: 0;
    text-align: center;
    width: 100%;
    height: 100%;
  }
}
</style>

<script>
import countrydata from 'country-data';
export default {
  name: 'PlayerReport',
  props: ['report', 'downloadFile'],
  data () {
    return {};
  },
  methods: {
    getLanguage (key) {
      return countrydata.languages[key] ? countrydata.languages[key].name : 'key';
    },
    getNationality (key) {
      return countrydata.countries[key] ? countrydata.countries[key].name : 'key';
    }
  }
};
</script>
