<template>
<div class="career-entries-list no-gutters">
  <fieldset
    v-for="(entry,index )  in career_histories"
    :key="entry.id"
    class="form-group col-md-12 career-entry no-gutters">
    <div class="row">
      <div class="col-1 career-entries-fast">
        <h3>{{ index+1 }}</h3>
      </div>
      <div class="col">
        <div class="row capitalize font-weight-bold">{{ getRoleName(entry.role) }}</div>
        <div  class="row" >
          {{ formatDate(entry.start_date) }} &minus; {{ formatDate(entry.end_date, 'Present') }}
          &middot; {{ dateDiff(entry.start_date, entry.end_date )}}
        </div>
        <div class="row font-weight-light">{{ getCountryName(entry.club.country_code) }} &middot; {{ entry.club.name }}</div>
    </div>
    <div class="col-2 text-right">
        
        <button class="button-edit"
                @click="editEntry(entry.id,index)"
                type="button">
                <v-icon name="pencil-alt" scale="1" class="icon"/>
        </button>

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
    dateDiff(from,to){
      return this.$options.filters.timeDiff(from, to);
    },
    formatDate(date_str, default_value){
      if (date_str == null){
        return default_value;
      }
      return this.$options.filters.formatDate(date_str, 'MMM YYYY');
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

.career-entries-fast h3 {
  color: #7f8081;
  font-size: 18px;
  padding-right: 10px;
}

.button-delete,
.button-edit {
  display: inline-block;
  cursor: pointer;
  background: transparent;
  border: 0;
}

.button-edit {
  .icon {
    fill: lighten(#000, 50%)
  }
  
  &:hover {
    .icon {
      fill: #000;
    }
  }
}

.button-delete {
  .icon {
    fill: #F7D1D5;
  }

  &:hover {
    .icon {
      fill: #ff96a2;
    }
  }
}

</style>
