<template>
<div class="career-entries-list">
  <fieldset
    v-for="(entry,index )  in career_histories"
    :key="entry.id"
    class="form-group col-md-12 career-entry">
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
        
        <button class="button-edit"
                @click="editEntry(entry.id,index)"
                type="button"
                name="edit-entry">
                <v-icon name="pencil-alt" scale="0.9"/>

        <button class="button-delete"
                @click="deleteEntry(entry.id,index)"
                type="button" >
                <v-icon name="trash-alt" scale="1" class="icon"/>
          </button>
      </div>
    </div>
  </fieldset>
</div>
</template>

<script>
import ClubService from "app/services/ClubService";
import 'vue-awesome/icons/pencil-alt';
import 'vue-awesome/icons/trash-alt';
import VIcon from 'vue-awesome/components/Icon'

export default {
  components: {
    VIcon
  },
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
      let country = this.countries.find((c) => c.country_code == country_code);
      return country != null ? country.country_name : "Unknown";
    },
    deleteEntry(id, index){
      if (confirm("Are you sure you want to delete this entry?")){
        this.$emit("delete", { id });
      }
    },
    editEntry(id, index){
      this.$emit('edit', id, index);
    }
  }
}
</script>

<style lang="scss" scoped>
@import '~bootstrap/scss/bootstrap';

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


.button-edit {
  display: block;
  cursor: pointer;
  background: transparent;
  border: 0;
}

.career-entry:hover .button-edit {
    display: block;
}

@include media-breakpoint-up(md) {
  .career-entry {
    .button-edit {
      display: none;  
    }
  }
}
</style>
