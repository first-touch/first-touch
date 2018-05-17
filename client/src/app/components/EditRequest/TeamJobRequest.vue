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
              <inputsearch class="col-md-12" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="league" v-on:update:val="meta_data.league_id = $event"
              /> </div>
            <div class="col-sm-4 form-group">
              <label class="col-md-12 required">Team Name</label>
              <inputsearch class="col-md-12" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="team" v-on:update:val="meta_data.team_id = $event"
                :required="true" /> </div>
          </div>

          <div class="row">
            <div class="col-sm-6 form-group">
              <label class="col-md-12">Minimum number of Matches observed</label>
              <input type="number" class="col-md-12 form-control" v-model="meta_data.min_matches">
            </div>
            <div class="col-md-6 form-group">
              <label class="col-md-12">Training Report Required</label>
              <vselect v-model="training_report_select" @input="meta_data.training_report = training_report_select.value" :options="options.required" :searchable="false" />
            </div>
          </div>
          <div class="row col-md-12 form-group">
            <label class="col-md-12">Additional Comments</label>
            <textarea class="col-md-12 form-control" v-model="meta_data.comments" />
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

<script>
import { mapGetters, mapActions } from 'vuex';
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
      disabled: {
        to: new Date()
      },
      training_report_select: {
        label: 'No',
        value: 'no'
      },
      meta_data: {
        team_id: '',
        league_id: '',
        player_id: '',
        training_report: 'no'
      },
      options: {
        required: [
          {
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
      this.meta_data = this.edit.meta_data;
      this.deadline = this.edit.deadline;
      this.price = this.edit.price;
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
    showCalendar: function(index) {
      this.$refs.datepicker.showCalendar();
    },
    handleSubmit() {
      this.submit({
        meta_data: this.meta_data,
        deadline: this.deadline,
        price: this.price,
        type_request: 'team',
        status: 'publish'
      });
    }
  }
};
</script>
