<template>
<div>
  <fieldset
    v-for="(career_history,index )  in career_histories"
    :key="career_history.id"
    class="form-group col-md-12">
    <div class="row">
      <div class="career-entries-fast">
        <h3>{{ index+1 }}</h3>
      </div>
      <select
        name="country_code"
        class="form-control select-btn col"
        @change="handleChange"
      >
        <option
          v-for="c in countries"
          :key="c.country_code"
          :value="c.country_code"
          :selected="c.country_code == career_history.club.country_code"
          v-bind:data-foo="c.country_code"
        >{{ c.country_name }}</option>
      </select>

      <select
        name="club_name"
        class="form-control col"
      >
        <option v-bind:value="career_history.club.name">{{ career_history.club.name}}</option>
        <option
          v-for="club in searched_clubs.clubs"
          :key="club.id"
          :value="club.name"
        >{{ club.name}}</option>
      </select>
    </div>
    <div class="row">
      <div class="col select-btn-two">
        <select name="your_role" class="form-control select-btn col">
          <option value="career_history.role" selected>{{ career_history.role }}</option>
          <option
            v-for="role in roles"
            :key="role.role_name"
            :value="role.role_name"
          >{{ role.role_name }}</option>
        </select>
      </div>
      <div class="col select-btn-two">
        <input
          v-bind:value="career_history.start_date"
          type="text"
          onfocus="(this.type='date')"
          id="date"
          class="form-control m-field-input"
        >
      </div>
      <div class="col select-btn-three">
        <input
          v-bind:value="career_history.end_date"
          type="text"
          onfocus="(this.type='date')"
          id="date"
          class="form-control m-field-input"
        >
      </div>
    </div>
    <div class="row">
      <div class="col remove-space">
        <button
          class="button-delete"
          @click="deleteCareerEntry(career_history.id,index)"
          type="button"
          name="dentry"
          value="Delete"
        >Delete</button>
      </div>
    </div>
  </fieldset>
</div>
</template>

<script>
import ClubService from "app/services/ClubService";

export default {
  props: [  "career_histories", 
            "countries",
            "roles"],
  data(){ return{
    searched_clubs: {},
  }},
  methods: {
    handleChange(e) {
      if (e.target.options.selectedIndex > -1) {
        var country_code =
          e.target.options[e.target.options.selectedIndex].dataset.foo;
        ClubService.searchClubByCountry(country_code)
          .then(response => {
            this.searched_clubs = response;
          })
          .catch(response => {
            console.log(error);
          });
      }
    },
    deleteCareerEntry(id, index){
      this.$emit("delete", id, index);
    }
  }
}
</script>

<style lang="scss" scoped>


.select-btn-two,
.select-btn-three {
  padding: 0 0 0 24px;
  margin: 0 0 10px 0px;
}

.career-entries-fast h3 {
  color: #7f8081;
  font-size: 18px;
  padding-right: 10px;
}


.button-delete {
  color: #fff;
  padding: 5px 14px 5px 15px;
  background: grey;
}
</style>
