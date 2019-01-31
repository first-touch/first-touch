<template>
   <div class="profile-form">
          <fieldset class="form-group">
            <label>Enter New Career Entries</label>
            <fieldset class="form-group col-md-12">
               <div class="row">
                  <select name="country_code" id="country_code" class="form-control select-btn col" @change="handleChange">
                     <option disabled value="" selected>Country</option>
                     <option v-for="c in countries" :key="c.country_code" :value="c.country_code" v-bind:data-foo="c.country_code">{{ c.country_name }}</option>
                  </select>
                   <select name="club_name" id="club_name" class="form-control col" v-model="club_id">
                    <option disabled value="">Select Club</option>
                    <option v-for="club in clubs_data.clubs" :key="club.id" :value="club.id">{{ club.name }}</option>
                  </select>
               </div>
               <div class="row">
                  <div class="col remove-space-one">
                     <select name="role_name" v-model="role" id="role_name" class="form-control m-field-input">
                      <option disabled value="">Select Role</option>
                      <option value="player">player</option>
                      <option value="manager">manager</option>
                      <option value="coach">coach</option>
                      <option value="scout">scout</option>
                      <option value="director">director</option>
                     </select>
                  </div>
                  <div class="col">
                     <input name="start_date" v-model="start_date" placeholder="Start Date" class="form-control m-field-input" type="text" onfocus="(this.type='date')"  id="date">
                  </div>
                  <div class="col remove-space-two">
                      <input name="end_date" v-model="end_date"  placeholder="End Date" class="form-control m-field-input" type="text" onfocus="(this.type='date')"  id="date">
                  </div>
               </div>
                <div class="row">
                  <div class="col remove-space-three">
                  <button @click="addCareerEntry" class="button-add" type="button" name="dentry" value="add"> add </button>
                  </div>
               </div>
            </fieldset>
         </fieldset>
   </div>
</template>

<style lang="scss" scoped>
   @import '~stylesheets/variables';
   .form-group {
     label {
        color: $main-text-color;
      }
    }
    .input-file {
      opacity: 0;
      /* invisible but it's there! */
      width: 100%;
      height: 100px;
      position: absolute;
      cursor: pointer;
      margin-top: -32px;
    }

    .select-button-two {
      margin: 0 22px 22px 0px;
    }

    .remove-space-one, .remove-space-two {
      padding: 0;
    }

    .button-add {
      color: #fff;
      padding: 11px 32px;
      background: #3f8d42;
      margin: 24px 0 0 0;
    }

    .remove-space-three {
      padding: 0;
    }

</style>

<script>
   import ClubService from 'app/services/ClubService';
   import UserService from 'app/services/UserService';
   import axios from 'axios';
   import store from 'app/store';

    export default {
     name: 'NewCareerEntry',
     data() {
       return {
         countries:[],
         clubs_data:[],
         club_id: '',
         start_date: '',
         end_date : '',
         role: '',
         endpoint: '/api/v1'
       };
     },
     methods: {

       updateCareerEntry(careerInfo) {
          CareerEntries.updateCareerEntries(careerInfo).then(response => {
           this.flash('Updated successfully', 'success', {
             timeout: 3000,
             important: true
           });
         }).catch(response => {
           this.flash('Failed to update', 'error', {
             timeout: 3000,
             important: true
           });
         })
       },
       handleChange(e) {
         if(e.target.options.selectedIndex > -1) {
            var country_code = e.target.options[e.target.options.selectedIndex].dataset.foo;
            axios.get('http://localhost:3001/api/v1/clubs/search?country='+country_code+'').then(response => {
            this.clubs_data = response.data
             }).catch(error => {
              console.log(error);
             })
          }
       },
       addCareerEntry() {

        if(this.club_id=='' && this.start_date=='' && this.end_date=='' && this.role==='') {

          alert("Please Fill All the Entries");
        }else {
         const token = store.state.token.value;
           axios( {
               method: "POST", "url": "http://localhost:3001/api/v1/career_entries", "headers": {
                   "Authorization": token, "Content-Type": "application/json"
               },
                "data": {
                   "career_entry": {
                       "club_id": this.club_id, "start_date": this.start_date, "end_date": this.end_date, "role": this.role
                   }
               }
           }
           ).then(function (response) {
               alert("Added Successfully");
           }

           ).catch(function (error) {
                alert("Please Fill All the Entries");

              }
           );
        }
       },
       fetchCountries() {
         ClubService.countriesForClubs().then(response => {
           this.$set(this, 'countries',
                     response.countries.sort((a, b) => a.country_name > b.country_name))
         });
       },
     },
     mounted() {
       this.fetchCountries();
     }
   };
</script>
