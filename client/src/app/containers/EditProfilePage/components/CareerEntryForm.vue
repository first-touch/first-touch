<template>
<div>
    <div class="row">
      <div class="col">
        <select
          name="country_code"
          id="country_code"
          class="form-control select-btn col"
          v-model="country_code"
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
        <select name="club_name" id="club_name" class="form-control col" v-model="club_id">
          <option disabled value>Select Club</option>
          <option
            v-for="club in clubs"
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
          v-model="role"
          id="role_name"
          class="form-control m-field-input"
        >
          <option disabled value>Select Role</option>
          <option disabled value>Role</option>
          <option value="agent">Agent</option>
          <option value="director">Director of Football</option>
          <option value="player">Player</option>
          <option value="scout">Scout</option>
        </select>
      </div>
      <div class="col">
        <input
          name="start_date"
          v-model="start_date"
          placeholder="Start Date"
          class="form-control m-field-input"
          type="text"
          onfocus="(this.type='date')"
          id="date"
        >
      </div>
      <div class="col remove-space-two">
        <input
          name="end_date"
          v-model="end_date"
          placeholder="End Date"
          class="form-control m-field-input"
          type="text"
          onfocus="(this.type='date')"
          id="date"
        >
      </div>
    </div>
    <div class="row">
      <div class="col remove-space-three">
        <button
          @click="saveEntry"
          class="button-add"
          type="button"
          name="dentry"
          value="add"
        >add</button>
      </div>
    </div>
</div> 
</template>

<script>
import ClubService from "app/services/ClubService";

export default {
  props: ['countries'],
  data() { return {
    country_code: "",
    clubs: [],
    club_id: "",
    start_date: "",
    end_date: "",
    role: ""
  }},
  watch: {
    country_code: function(to, from){
      if (to == -1) return;

      ClubService.searchClubByCountry(to)
          .then((response) => {
            if (response && "clubs" in response){
              this.clubs = response.clubs;
            } else { this.clubs = []; }
          })
          .catch(response => {
            console.log(error);
          });
    }
  },
  methods: {
    saveEntry() {
      const params = {
        club_id: this.club_id,
        start_date: this.start_date,
        end_date: this.end_date,
        role: this.role
      };
      this.$emit('save', params);
    }
  }
}
</script>

<style lang="scss" scoped>
.button-add {
  color: #fff;
  padding: 11px 32px;
  background: #3f8d42;
  margin: 24px 0 0 0;
}
</style>
