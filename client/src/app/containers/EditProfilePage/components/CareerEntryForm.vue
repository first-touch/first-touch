<template>
<div>
  <div class="row">
    <div class="col">
      <select
        name="country_code"
        id="country_code"
        class="form-control select-btn col"
        v-model="form.country_code"
        >
        <option disabled value selected>Country</option>
        <option
          v-for="c in countries"
          :key="c.country_code"
          :value="c.country_code"
        >{{ c.country_name }}</option>
      </select>
    </div>
    <div class="col">
      <select   name="club_name"
                id="club_name"
                class="form-control col"
                placeholder="Select Club"
                v-model="form.club_id">
        <option v-if="!isEdit" disabled>Select Club</option>
        <option v-else :value="form.initial_club_id">{{ form.club_name }}</option>
        <option v-for="club in clubs"
                :key="club.id"
                :value="club.id"
                >{{ club.name }}</option>
      </select>
    </div>
  </div>
  <div class="row add-margin">
    <div class="col">
      <select
        name="role_name"
        v-model="form.role"
        id="role_name"
        class="form-control m-field-input"
      >
        <option disabled value>Select Role</option>
        <option value="agent">Agent</option>
        <option value="director">Director of Football</option>
        <option value="player">Player</option>
        <option value="scout">Scout</option>
      </select>
    </div>
    <div class="col">
      <input
        name="start_date"
        v-model="startDate"
        placeholder="Start Date"
        class="form-control m-field-input"
        type="date"
      >
    </div>
    <div class="col">
      <input
        name="end_date"
        v-model="endDate"
        placeholder="End Date"
        class="form-control m-field-input"
        type="date"
      >
    </div>
  </div>
  <div class="row mt-3">
    <div class="col align-self-center">
      <button type="button" class="btn btn-danger btn-outline-danger" @click="deleteEntry" v-if="isEdit">Delete</button>
    </div>
    <div class="col-8 align-self-center text-right">
      <button type="button" class="btn btn-outline-secondary button-cancel" @click="cancelEntry">Cancel</button>
      <button type="button" class="btn btn-primary button-add" name="save-entry" value="add" @click="saveEntry">
        <span v-if="isEdit">Update</span>
        <span v-else>Create</span>
      </button>
    </div>
  </div>
</div>
</template>

<script>
import ClubService from "app/services/ClubService";

const emptyForm = {
        id: null,
        country_code: "",
        initial_club_id: "",
        club_id: "",
        club_name: "",
        start_date: "",
        end_date: "",
        role: "",
      };

export default {
  props: {
    countries: { type: Array },
    entry: { type: Object }
  },
  data() {
    return {
      form: Object.assign({}, emptyForm),
      startDate: '',
      endDate: '',
      clubs: [],
      isEdit: false
    }
  },
  watch: {
    entry: {
      immediate: true,
      handler: function(val){
        this.reset();

        if (val){
          this.isEdit = true;
          this.form = val;
          this.form.initial_club_id = this.form.club_id;
          this.fetchClubs(this.form.country_code);
          if (this.form.start_date != null){
            this.startDate = this.$options.filters.formatDate(this.form.start_date, 'YYYY-MM-DD');
          }
          if (this.form.end_date != null){
            this.endDate = this.$options.filters.formatDate(this.form.end_date, 'YYYY-MM-DD');
          }
        } else {
          this.isEdit = false;
        }
      }
    },
    "form.country_code": function(to, from){
      if (to == -1) return;

      this.fetchClubs(to);
    }
  },
  methods: {
    reset(){
      this.form = Object.assign({}, emptyForm);
      this.startDate = "";
      this.endDate = "";
    },
    fetchClubs(country_code){
      ClubService.searchClubByCountry(country_code)
          .then((response) => {
            if (response && "clubs" in response){
              this.clubs = response.clubs;
            } else { this.clubs = []; }
          })
          .catch(response => {
            console.log(error);
          });
    },
    saveEntry() {
      const params = this.form;
      params.end_date = this.endDate;
      params.start_date = this.startDate;
      this.$emit('save', params);
    },
    cancelEntry(){
      this.$emit('close');
    },
    deleteEntry(){
      this.$emit('delete', { id: this.form.id })
    }
  }
}
</script>
