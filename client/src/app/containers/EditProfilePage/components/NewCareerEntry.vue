<template>
   <div class="profile-form">
          <fieldset class="form-group">
            <label>Enter New Career Entries</label>
            <fieldset v-for= "career_history of career_histories" class="form-group col-md-12">
               <div class="row">
                  <select name="country_code" id="country_code" v-model="career_history.club_country" class="form-control select-button-two col">
                     <option disabled value="" selected>Country</option>
                     <option v-for="c in countries" :key="c.country_code" :value="c.country_code">{{ c.country_name }}</option>
                  </select>
                   <select name="club_name" id="club_name" class="form-control col">
                    <option value="" disabled selected >Select Club </option>
                  </select>
               </div>
               <div class="row">
                  <div class="col remove-space-one">
                     <select name="role_name" v-model="career_history.your_role"  id="role_name" class="form-control m-field-input">
                      <option disabled selected value=" ">Your Role</option>
                      <option value="player">player</option>
                      <option value="manager">manager</option>
                      <option value="coach">coach</option>
                      <option value="scout">scout</option>
                      <option value="director">director</option>
                     </select>
                  </div>
                  <div class="col">
                     <input name="start_date" v-model="career_history.start_date" placeholder="Start Date" class="form-control m-field-input" type="text" onfocus="(this.type='date')"  id="date">
                  </div>
                  <div class="col remove-space-two">
                      <input name="end_date" v-model="career_history.end_date"  placeholder="End Date" class="form-control m-field-input" type="text" onfocus="(this.type='date')"  id="date">
                  </div>
               </div>
                <div class="row">
                  <div class="col remove-space-three">
                  <button class="button-add" type="button" name="dentry" value="add"> add </button>
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
   import CareerEntries from 'app/services/CareerEntries';
    export default {
     name: 'EditProfileForm',
     data() {
       return {
         career_histories: [{ club_country: 'USA', club_name: 'My Club', your_role: 'Player', start_date: '1998-01-20',end_date: '1999-01-20' }],
         countries:[],
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
