<template>
  <div>
    <h4 v-if="!edit" class="header">New Team Job</h4>
    <h4 v-if="edit" class="header">Edit Team Job</h4>
    <timeline-item>
      <form @submit.prevent class="team-request ft-form">
        <div class="content">
          <ul class="error" v-if="errors">
            <li v-for="(error) in errors.errors" v-bind:key="error.id">
              {{ error }}
            </li>
          </ul>
          <div class="row">
            <div class="col-sm-4 form-group">
              <label class="col-md-12">League Name</label>
              <inputsearch class="col-md-12" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="league" v-on:update:val="report_data.league_id = $event"
              /> </div>
            <div class="col-sm-4 form-group">
              <label class="col-md-12 required">Team Name</label>
              <inputsearch class="col-md-12" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="team" v-on:update:val="report_data.team_id = $event" :required="true"
              /> </div>
          </div>

          <div class="row">
            <div class="col-sm-6 form-group">
              <label class="col-md-12">Minimum number of Matches observed</label>
              <input type="number" class="col-md-12 form-control" v-model="report_data.min_matches">
            </div>
            <div class="col-md-6 form-group">
              <label class="col-md-12">Training Report Required</label>
              <vselect v-model="report_data.training_report" :options="options.required" :searchable="false" />
            </div>
          </div>
          <div class="row col-md-12 form-group">
            <label class="col-md-12">Additional Comments</label>
            <textarea class="col-md-12 form-control" v-model="report_data.comments" />
          </div>
          <div class="row col-md-12 form-group">
            <label class="col-md-12 required">Deadline</label>
            <ftdatepicker class="col-md-6 form-control" :disabled="disabled" :value="deadline" v-on:update:val="deadline = $event" />
          </div>
          <div class="row col-md-12 form-group">
            <label class="col-md-12">Price Range</label>
            <currencyinput :value="price" max="true" />


          </div>
          <div class="form-group buttons-inner">
            <button v-if="!edit" id="submit" class="btn btn-primary ft-button" @click="handleSubmit"> CREATE</button>
            <button v-if="edit" id="submit" class="btn btn-primary ft-button" @click="handleSubmit"> UPDATE</button>
            <button id="cancel" name="cancel" class="btn btn-default ft-button" @click="cancelAction">CANCEL</button>
          </div>
        </div>
      </form>
    </timeline-item>
  </div>
</template>

<style lang="scss">
@import '~stylesheets/variables';
@import '~stylesheets/form';

</style>

<style lang="scss">
//   @import '~stylesheets/variables';
//   .team-request {
//     .ft-input {
//       padding: 0;
//     }
//     .datepicker {
//       background: white;
//       display: inline-block;
//       input.input-date {
//         color: $main-text-color;
//         cursor: pointer;
//         width: 100%;
//         border: 0px;
//         height: 2.3em;
//         background: white;
//       }
//     }
//   }
// </style>
// <style lang="scss" scoped>
//   @import '~stylesheets/variables';
//   @import '~stylesheets/form';

//   form {
//     background: $form-background;
//     color: $main-text-color;
//     padding: 40px 40px 80px 40px;

//     .btn {
//       cursor: pointer;
//     }
//     .error {
//       li {
//         color: red;
//         display: list-item;
//         list-style: disc;
//         &:first-letter {
//           text-transform: capitalize;
//         }
//       }
//     }
//     .buttons {
//       float: right;
//     }
//     .form-group {
//       padding: 0;
//     }
//   }
//
</style>


<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import inputSearch from 'app/components/Input/InputSearch.vue';
  import vSelect from 'vue-select';
  import CurrencyInput from 'app/components/Input/CurrencyInput';
  import TimelineItem from 'app/components/TimelineItem';
  import FtDatepicker from 'app/components/Input/FtDatepicker';

  export default {
    name: 'PlayerJobRequest',
    props: ['submit', 'errors', 'edit', 'cancelAction'],
    components: {
      inputsearch: inputSearch,
      vselect: vSelect,
      currencyinput: CurrencyInput,
      'timeline-item': TimelineItem,
      ftdatepicker: FtDatepicker

    },
    data() {
      return {
        disabled:{
        to: new Date()
      },
        report_data: {
          team_id: '',
          league_id: '',
          player_id: ''
        },
        options: {
          required: [{
              label: 'No',
              value: 'no'
            },
            {
              label: 'Yes',
              value: 'yes'
            }
          ]
        },
        deadline: '',
        price: {
          value: 0,
          currency: 'USD',
          max: 0
        }
      };
    },
    computed: {
      ...mapGetters(['searchResult'])
    },
    created() {
      if (this.edit) {
        this.report_data = this.edit.report_data;
        this.deadline = this.edit.deadline;
        this.min_price = this.edit.min_price;
        this.max_price = this.edit.max_price;
      }
    },
    methods: {
      ...mapActions(['getSearchResults']),
      getSearchResultsRole(role, term) {
        this.getSearchResults({
          searchTerm: term,
          role: role
        });
      },
      showCalendar: function (index) {
        this.$refs.datepicker.showCalendar();
      },
      handleSubmit() {
        this.submit({
          report_data: this.report_data,
          deadline: this.deadline,
          min_price: this.min_price,
          max_price: this.max_price,
          type_request: 'team',
          status: 'publish'
        });
      }
    }
  };
</script>
