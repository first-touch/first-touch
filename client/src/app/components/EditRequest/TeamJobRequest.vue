<template>
  <div>
    <form @submit.prevent>
      <div class="content">
        <ul class="error" v-if="errors">
          <li v-for="(error) in errors.errors" v-bind:key="error.id">
            {{ error }}
          </li>
        </ul>
        <div class="row select-target" v-if="!edit">
          <fieldset class="form-group col-md-3 filter">
            <label class="col-sm-12">League Name</label>
            <inputsearch class="col-sm-12" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="league" v-on:update:val="meta_data.league_id = $event"
            />
          </fieldset>
          <fieldset class="form-group col-md-3 filter">
            <label class="col-sm-12">Team Name</label>
            <inputsearch class="col-sm-12" :onkeyup="getSearchResultsRole" :searchResult="searchResult" type="team" v-on:update:val="meta_data.team_id = $event"
            />
          </fieldset>
        </div>
        <fieldset class="form-group row col-md-12 filter">
          <label class="col-sm-3">Minimum number of Matches observed</label>
          <input type="number" class="col-sm-4" v-model="meta_data.min_matches">
        </fieldset>
        <fieldset class="form-group row col-md-12 filter">
          <label class="col-sm-3">Training Report Required</label>
          <div class="col-sm-10 radio-group">
            <label class="radio-inline">
              <input type="radio" id="one" value="true" v-model="meta_data.training_report" />Yes</label>
            <label class="radio-inline">
              <input type="radio" id="one" value="false" v-model="meta_data.training_report" />No</label>
          </div>
        </fieldset>
        <fieldset class="form-group row col-md-12 filter">
          <label class="col-sm-3">Deadline</label>
          <datepicker :input-class="[deadline != '' ? 'selected': '', 'input-date'].join(' ')" v-model="deadline" class="datepicker col-sm-4"
           format="dd,MMM yyyy"></datepicker>
        </fieldset>
        <fieldset class="form-group row col-md-12 filter">
          <label class="col-sm-3">Additional Comments</label>
          <textarea class="col-sm-4" v-model="meta_data.comments" />
        </fieldset>
        <fieldset class="form-group row col-md-12 filter">
          <label class="col-sm-3">Price Range</label>
          <input type="number" class="col-sm-1" v-model="min_price" />
          <span class="separator">—</span>
          <input type="number" class="col-sm-1" v-model="max_price" />
        </fieldset>
        <div class="form-group buttons">
          <button v-if="!edit" id="submit" class="btn btn-primary" @click="handleSubmit"> CREATE</button>
          <button v-if="edit" id="submit" class="btn btn-primary" @click="handleSubmit"> UPDATE</button>
          <button id="cancel" name="cancel" class="btn btn-default"  @click="cancelAction" >CANCEL</button>
        </div>
      </div>
    </form>
  </div>
</template>
<style lang="scss">
.datepicker {
  background: white;
  float: left;
  padding: 0;
  input.input-date {
    width: 100%;
    cursor: pointer;
    height: 2.5em;
    background: white;
    background: url('/images/calendar.png') no-repeat;
    background-size: 3em 2.5em;
    background-position: right;
    &.selected {
      background: url('/images/calendar-fill.png') no-repeat;
      background-size: 3em 2.5em;
      background-position: right;
    }
  }
}
</style>
<style lang="scss" scoped>
@import '~stylesheets/variables';
form {
  background: $form-background;
  color: $main-text-color;
  padding: 40px 40px 80px 40px;

  .select-target {
    margin-bottom: 30px;
    padding: 10px;
    background: #cacaca;
    color: black;
  }
  .btn {
    cursor: pointer;
  }
  .error {
    li {
      color: red;
      display: list-item;
      list-style: disc;
      &:first-letter {
        text-transform: capitalize;
      }
    }
  }
  .buttons {
    float: right;
  }
  h5 {
    margin-top: 20px;
  }
  .form-group {
    display: inline-block;
  }
  .filter {
    label {
      float: left;
    }
    input {
      float: left;
    }
    .separator {
      float: left;
      margin: 0 10px;
    }
    .radio-group {
      label {
        width: 10%;
      }
    }
  }
}
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import inputSearch from 'app/components/Input/InputSearch.vue';

import Datepicker from 'vuejs-datepicker';
export default {
  name: 'PlayerJobRequest',
  props: ['submit', 'errors', 'edit', 'cancelAction'],
  components: {
    inputsearch: inputSearch,
    datepicker: Datepicker
  },
  data () {
    return {
      meta_data: {
        team_id: '',
        league_id: '',
        player_id: ''
      },
      deadline: '',
      min_price: 0,
      max_price: ''
    };
  },
  computed: {
    ...mapGetters(['searchResult'])
  },
  created () {
    if (this.edit) {
      this.meta_data = this.edit.meta_data;
      this.deadline = this.edit.deadline;
      this.min_price = this.edit.min_price;
      this.max_price = this.edit.max_price;
    }
  },
  methods: {
    ...mapActions(['getSearchResults']),
    getSearchResultsRole (role, term) {
      this.getSearchResults({
        searchTerm: term,
        role: role
      });
    },
    handleSubmit () {
      this.submit({
        meta_data: this.meta_data,
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
