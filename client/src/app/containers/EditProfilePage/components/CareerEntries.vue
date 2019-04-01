<template>
<div class="career-entries-list">
  <fieldset
    v-for="(entry,index )  in career_histories"
    :key="entry.id"
    class="form-group col-md-12">
    <div class="row">
      <div class="col-1 career-entries-fast">
        <h3>{{ index+1 }}</h3>
      </div>
      <div class="col">
        <div class="row capitalize">{{ getRoleName(entry.role) }}</div>
        <div class="row">From {{ formatDate(entry.start_date) }} to {{ formatDate(entry.end_date) }}</div>
        <div class="row">{{ getCountryName(entry.club.country_code) }} - {{ entry.club.name }}</div>
    </div>
    <div class="col-2">
        <button
          class="button-delete"
          @click="deleteEntry(entry.id,index)"
          type="button"
          name="dentry"
          value="Delete"
        >Delete</button>
        <button class="button-edit"
                @click="editEntry(entry.id,index)"
                type="button"
                name="edit-entry">
                Edit</button>
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
    formatDate(date_str){
      let time = Date.parse(date_str);
      return this.$options.filters.moment(time);
    },
    getRoleName(role_id){
      return role_id;
    },
    getCountryName(country_code){
      console.log(country_code);
      let country = this.countries.find((c) => c.country_code == country_code);
      return country != null ? country.country_name : "Unknown";
    },
    deleteEntry(id, index){
      this.$emit("delete", id, index);
    },
    editEntry(id, index){
      this.$emit('edit', id, index);
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
