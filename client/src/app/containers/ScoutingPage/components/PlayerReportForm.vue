<template>
  <form @submit.prevent id="report-form">
    <ul class="error" v-if="reportStatus">
      <li v-for="(error) in reportStatus.errors.error" v-bind:key="error.id">
        {{ error }}
      </li>
    </ul>
    <div class="form-group row">
      <label class="col-1 col-form-label">Report Name</label>
      <div class="col-sm-10">
        <input type="text" class="col-md-6" v-model="headline">
      </div>
    </div>
    <h3> Player Summary </h3>
    <div class="form-group form-inner">
      <div class="form-group">
        <div class="row">
          <label class="col-sm-2 col-form-label">Age</label>
          <div class="col-sm-10">
            <input type="number" class="col-sm-4" v-model="age">
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Approximate Height (cm)</label>
          <div class="col-sm-10">
            <input type="number" class="col-sm-4" v-model="meta_data.userinfo.height">
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Approximate Weight (kg)</label>
          <div class="col-sm-10">
            <input type="number" class="col-sm-4" v-model="meta_data.userinfo.weight">
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Nationality</label>
          <div class="col-sm-10">
            <select class="col-sm-4" v-model="meta_data.userinfo.nationality_country_code">
                      <option v-for="(value, key, index) in countries" :key="index" :value="value[1]">
                          {{value[0]}}
                      </option>
                    </select>
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Based In</label>
          <div class="col-sm-10">
            <select class="col-sm-4" v-model="meta_data.userinfo.residence_country_code">
                      <option v-for="(value, key, index) in countries" :key="index" :value="value[1]">
                            {{value[0]}}
                        </option>
                    </select>
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Language</label>
          <div class="col-sm-10">
            <select class="col-sm-4" v-model="meta_data.userinfo.languages" multiple>
                      <option v-for="(value, key, index) in languages" :key="index" :value="value[1]">
                          {{value[0]}}
                      </option>
                    </select>
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Position</label>
          <div class="col-sm-10">
            <select class="col-sm-4" v-model="meta_data.userinfo.playing_position" multiple>
                    <option disabled value="">Positions</option>
                    <option value="keeper">GoalKeeper</option>
                    <option value="defender">Defender</option>
                    <option value="midfielder">Midfielder</option>
                    <option value="winger">Winger</option>
                    <option value="striker">Striker</option>
                  </select>
          </div>
        </div>
        <div class="row">
          <label class="col-sm-2 col-form-label">Preferred Foot</label>
          <div class="col-sm-10">
            <select v-model="meta_data.userinfo.preferred_foot" class="col-sm-4">
                      <option disabled value="">Preferred Foot</option>
                    <option value="R">Right</option>
                    <option value="L">Left</option>
                      </select>
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
            <label class="radio-inline"><input type="radio" id="one"  value="true" v-model="meta_data.transfert_sum.transfert_interested">Yes</label>
            <label class="radio-inline"><input type="radio" id="one"  value="false" v-model="meta_data.transfert_sum.transfert_interested">No</label>
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
            <label class="radio-inline"><input type="radio" id="one"  value="true" v-model="meta_data.transfert_sum.loan_interested">Yes</label>
            <label class="radio-inline"><input type="radio" id="one"  value="false" v-model="meta_data.transfert_sum.loan_interested">No</label>
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
            <label class="radio-inline"><input type="radio" id="one"  value="true" v-model="meta_data.transfert_sum.free_agent">Yes</label>
            <label class="radio-inline"><input type="radio" id="one"  value="false" v-model="meta_data.transfert_sum.free_agent">No</label>
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
        <textarea class="col-md-12" v-model="meta_data.overview" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Physical Attribute(s)</label>
      <div class="col-md-12">
        <textarea class="col-md-12" v-model="meta_data.physical_attributes" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Mental Attribute(s)</label>
      <div class="col-md-12">
        <textarea class="col-md-12" v-model="meta_data.mental_attributes" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Technical Attribute(s)</label>
      <div class="col-md-12">
        <input type="text" class="col-md-12" v-model="meta_data.technical_attributes" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Personality</label>
      <div class="col-md-12">
        <input type="text" class="col-md-12" v-model="meta_data.personality" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Potential</label>
      <div class="col-md-12">
        <input type="text" class="col-md-12" v-model="meta_data.potential" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Other Observations & Viewpoints To Note</label>
      <div class="col-md-12 ">
        <input type="text" class="col-md-12" v-model="meta_data.observations" />
      </div>
    </div>
    <div class="form-group">
      <label class="col-md-12 col-form-label">Analysis of Trainings/Matches</label>
      <table class="table analyzed_matches">
        <thead>
          <tr>
            <th scope="col" class="col-md-2">Date</th>
            <th scope="col" class="col-md-2">Opponent</th>
            <th class="col-md-2">Venue</th>
            <th class="col-md-2">Training Observed </th>
            <th class="col-md-2">Comment</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(match, index) in meta_data.analyzed_matches" v-bind:key="match.id">
            <td>
              <datepicker v-model="match.date" class="test" wrapper-class="test2" input-class="input-date"></datepicker>
            </td>
            <td> <input type="text" v-model="match.opponent" /> </td>
            <td> <input type="text" v-model="match.venue" /> </td>
            <td> <select v-model="match.training">
                              <option value="true" selected>Yes</option>
                              <option value="false">No</option>
                            </select> </td>
            <td> <input type="text" v-model="match.comment" /> </td>
            <td class="remove-items"> <a v-if="meta_data.analyzed_matches.length > 1" @click="removeRowMatches(index)">X</a> </td>
          </tr>
        </tbody>
      </table>
      <button class="button row btn-primary add-match" @click="addRowMatches">Add Match</button>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Conclusions</label>
      <div class="col-md-12">
        <input type="text" class="col-md-12" v-model="meta_data.conclusion" />
      </div>
    </div>
    <div class="form-group row">
      <label class="col-md-12 col-form-label">Attachments:</label>
      <div class="col-md-12">
        <input type="file" name="files" ref="myFiles" multiple>
      </div>
    </div>
    <div class="form-group row">
      <label class="col-1 col-price col-form-label">Price (in SGD) </label>
      <div class="col-md-10">
        <input class="col-sm-3" type="number" v-model="price" />
      </div>
    </div>
    <div class="form-group">
      <label class="col-md-4 control-label" for="submit"></label>
      <div class="col-md-8">
        <button id="submit" class="btn btn-primary" @click="handleSubmit">Publish</button>
        <a href="/link-to/whatever-address/" id="cancel" name="cancel" class="btn btn-default">Cancel</a>
      </div>
    </div>
  </form>
</template>

<style lang="scss">
  .test {
    background: white;
    input.input-date {
      width: 100%;
      border: 0px;
      background: white;
      background: url('/images/calendar.png') no-repeat;
      background-size: 35px 25px;
      background-position: center;
      text-indent: 100%;
      white-space: nowrap;
      overflow: hidden;
    }
  }
</style>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .add-match {
    margin: 0;
    padding: 4px;
    font-size: 10px;
  }

  .analyzed_matches {
    margin: 0;
    td,
    th {
      border: 1px solid grey;
      width: 10%;
      text-align: center;
    }
    .remove-items {
      border: none;
      a {
        color: red;
        cursor: pointer;
      }
    }
    td {
      padding: 0;
      margin: 0;
    }
    input,
    select {
      border: none;
      text-align: center;
      width: 100%;
      height: 100%;
    }
    color: #7f8081;
    background: white
  }

  label.col-1 {
    padding-right: 0px;
  }

  .radio-group {
    label {
      width: 10%;
    }
  }

  .form-inner {
    input {
      max-width: 37%;
    }
    select {
      max-width: 37%;
    }
    padding-left: 3%;
  }

  .error {
    color: red;
  }

  .report-form {
    label {
      font-size: 10px;
    }
    h3 {
      color: #7f8081;
      font-size: 15px;
    }
  }

  .user-info {
    border: 1px solid black;
    padding: 10px;
    border-radius: 4px;
    h3 {
      color: #A8CB5C
    }
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
  import countrydata from 'country-data';
  import Datepicker from 'vuejs-datepicker';

  export default {
    name: 'PlayerReportForm',
    components: {
      datepicker: Datepicker
    },
    props: [
      'userinfo',
      'createReport',
      'reportStatus'
    ],
    data() {
      return {
        meta_data: {
          userinfo: {
            languages: [],
            playing_position: []
          },
          transfert_sum: {},
          analyzed_matches: [{
            date: new Date(),
            opponent: '',
            venue: '',
            comment: ''
          }],
        },
        price: 0,
        age: null,
        headline: '',
        files: []
      };
    },
    watch: {
      userinfo() {
        if (this.userinfo.birthday) {
          var birthday = new Date(this.userinfo.birthday);
          var ageDifMs = Date.now() - birthday.getTime();
          var ageDate = new Date(ageDifMs); // miliseconds from epoch
          this.age = Math.abs(ageDate.getUTCFullYear() - 1970);
          this.meta_data.userinfo.weight = this.userinfo.weight;
          this.meta_data.userinfo.height = this.userinfo.height;
          this.meta_data.userinfo.preferred_foot = this.userinfo.preferred_foot;
this.meta_data.userinfo.playing_position = [];
          if (this.userinfo.playing_position)
            this.meta_data.userinfo.playing_position = JSON.parse(this.userinfo.playing_position)
        }
      }
    },
    computed: {
      languages() {
        var arr = [];
        var multiple = []
        $.each(countrydata.languages, function(key, value) {
          if (value.alpha2 && !multiple[value.name]) {
            multiple[value.name] = 1
            arr.push([value.name, value.alpha2]);
          }
        })
        arr.sort();
        return arr;
      },
      countries() {
        var arr = [];
        var multiple = []
        $.each(countrydata.countries, function(key, value) {
          if (value.alpha2 && !multiple[value.name]) {
            multiple[value.name] = 1
            arr.push([value.name, value.alpha2]);
          }
        })
        arr.sort();
        return arr;
      }
    },
    methods: {
      handleSubmit() {
        var report = {
          headline: this.headline,
          price: this.price,
          report: this.meta_data,
        }
        this.createReport(report, this.$refs.myFiles.files)
        var container = this.$el.querySelector("#report-form");
        $('html, body').animate({
          scrollTop: 0
        }, 100);
      },
      addRowMatches: function() {
        this.meta_data.analyzed_matches.push({
          date: '',
          opponent: '',
          venue: '',
          comment: ''
        })
      },
      removeRowMatches: function(index) {
        this.meta_data.analyzed_matches.length > 1 ? this.meta_data.analyzed_matches.splice(index, 1) : ''
      }
    }
  };
</script>