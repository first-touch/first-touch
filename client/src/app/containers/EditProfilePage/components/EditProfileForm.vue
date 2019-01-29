<template>
   <div class="profile-form">
      <form @submit.prevent="updateProfilePic" enctype="multipart/form-data">
         <fieldset class="form-group">
            <label>Your Profile Picture</label>
            <div class="row">
               <div class="col-2">
                  <input type="file" id="avatar" name="avatar" accept="image/*" @change="filePickerUpdated($event.target.files)" class="input-file">
                  <img data-v-8e1e5708="" :src="currentAvatar" class="rounded-circle img-fluid">
               </div>
               <div class="col-4">
                  <button type="submit" :disabled="noNewAvatar" class="form-control a-bar-button">Update my picture</button>
               </div>
            </div>
         </fieldset>
      </form>
          <fieldset class="form-group">
           <input type="text" v-model="club_id" class="form-control m-field-input" placeholder="Club ID" />
            <label>Career Entries</label>
            <fieldset class="form-group col-md-12" v-if="this.role_name != 'director'">
               <div class="row">
                  <select name="country_code" id="country_code" v-model="club_country_code" class="form-control col">
                     <option disabled value="" selected>Country</option>
                     <option v-for="c in countries" :key="c.country_code" :value="c.country_code">{{ c.country_name }}</option>
                  </select>
                   <select name="club_name" id="club_name" class="form-control col">
                    <option value="" disabled selected >Select Club </option>
                  </select>
               </div>
            </fieldset>
               <div class="row">
                  <div class="col">
                     <select name="role_name" id="role_name" class="form-control m-field-input">
                      <option disabled selected value=" ">Your Role</option>
                      <option value="player">player</option>
                      <option value="manager">manager</option>
                      <option value="coach">coach</option>
                      <option value="scout">scout</option>
                      <option value="director">director</option>
                     </select>
                  </div>
                  <div class="col">
                     <input name="start_date" placeholder="Start Date" class="form-control m-field-input" type="text" onfocus="(this.type='date')"  id="date">
                  </div>
                  <div class="col">
                      <input name="end_date" placeholder="End Date" class="form-control m-field-input" type="text" onfocus="(this.type='date')"  id="date">
                  </div>
               </div>
         </fieldset>
      </form>

      <form @submit.prevent="handleSubmit">
         <fieldset class="form-group">
            <label>Your Name</label>
            <div class="row">
               <div class="col">
                  <input type="text" v-model="first_name" class="form-control m-field-input" placeholder="First Name" />
               </div>
               <div class="col">
                  <input type="text" v-model="middle_name" class="form-control m-field-input" placeholder="Middle Name" />
               </div>
               <div class="col">
                  <input type="text" v-model="last_name" class="form-control m-field-input" placeholder="Last Name" />
               </div>
            </div>
         </fieldset>
         <fieldset class="form-group">
            <label>Date Of Birth</label>
            <div class="row">
               <div class="col">
                  <select v-model="bMonth" class="form-control m-field-input">
                     <option disabled value="">Month</option>
                     <option value="1">January</option>
                     <option value="2">February</option>
                     <option value="3">March</option>
                     <option value="4">April</option>
                     <option value="5">May</option>
                     <option value="6">June</option>
                     <option value="7">July</option>
                     <option value="8">August</option>
                     <option value="9">September</option>
                     <option value="10">October</option>
                     <option value="11">November</option>
                     <option value="12">December</option>
                  </select>
               </div>
               <div class="col">
                  <select v-model="bDay" class="form-control m-field-input">
                     <option disabled value="">Date</option>
                     <option v-for="d in 31" :value="d">{{ d }}</option>
                  </select>
               </div>
               <div class="col">
                  <input type="number" v-model="bYear" class="form-control m-field-input" placeholder="Year" />
               </div>
            </div>
         </fieldset>
         <fieldset class="form-group">
            <label>Nationality</label>
            <div class="row">
               <div class="col">
                  <select v-model="country_code" class="form-control m-field-input">
                     <option disabled value="" selected>Country of Birth</option>
                     <option v-for="c in countries" :key="c.country_code" :value="c.country_code">{{ c.country_name }}</option>
                  </select>
               </div>
               <div class="col">
                  <input type="text" v-model="place_of_birth" class="form-control m-field-input" placeholder="Place of Birth" />
               </div>
            </div>
         </fieldset>
         <fieldset class="form-group">
            <label>Physique</label>
            <div class="row">
               <div class="col">
                  <div class="input-group mb-3">
                     <input type="number" v-model="weight" class="form-control m-field-input" placeholder="Weight" />
                     <div class="input-group-append">
                        <span class="input-group-text" id="basic-addon2">Kg</span>
                     </div>
                  </div>
               </div>
               <div class="col">
                  <div class="input-group mb-3">
                     <input type="number" v-model="height" class="form-control m-field-input" placeholder="Height" />
                     <div class="input-group-append">
                        <span class="input-group-text" id="basic-addon2">cm</span>
                     </div>
                  </div>
               </div>
               <div class="col">
                  <select v-model="preferred_foot" class="form-control m-field-input">
                     <option disabled value="">Preferred Foot</option>
                     <option value="R">Right</option>
                     <option value="L">Left</option>
                     <option value="B">Both</option>
                  </select>
               </div>
            </div>
         </fieldset>

         <fieldset class="form-group">
            <button type="submit" class="form-control a-bar-button">Save</button>
         </fieldset>
      </form>
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
      opacity: 0; /* invisible but it's there! */
       width: 100%;
       height: 100px;
       position: absolute;
       cursor: pointer;
       margin-top: -32px;
   }

</style>

<script>
   import ClubService from 'app/services/ClubService';
   import UserService from 'app/services/UserService';
   import CareerEntries from 'app/services/CareerEntries';
    export default {
     name: 'EditProfileForm',
     props: [
       'firstName',
       'middleName',
       'lastName',
       'month',
       'day',
       'year',
       'countryCode',
       'placeOfBirth',
       'pWeight',
       'pHeight',
       'preferredFoot',
       'avatarUrl',
       'updateUserInfo',
       'clubId',
     ],
     data() {
       return {
         careerInfo: {'career_entry':{'club_id':'1','start_date':'1990-08-01','end_date':'1999-10-02','role':'player'}},
         club_country_code: '',
         clubs: [],
         item: null,
         searchText: '',
         error: null,
         role_name: this.role,
         first_name: this.firstName || '',
         club_id: this.clubId || '',
         middle_name: this.middleName || '',
         last_name: this.lastName || '',
         bMonth: this.month || '',
         bDay: this.day || '',
         bYear: this.year || '',
         country_code: this.countryCode || '',
         place_of_birth: this.placeOfBirth || '',
         weight: this.pWeight || '',
         height: this.pHeight || '',
         preferred_foot: this.preferredFoot || '',
         countries: [],
         avatar_url: this.avatarUrl,
         avatar: undefined,
         formData: {},
       };
     },
     computed: {
       currentAvatar() {
         if (this.avatar) {
           return this.avatar.url;
         } else {
           return this.avatar_url;
         }
       },
       noNewAvatar() {
         return !this.avatar;
       }
     },
     methods: {
       filePickerUpdated(newFiles) {
         this.avatar = newFiles[0];
         this.avatar.url = '';
         let URL = window.URL || window.webkitURL;
         if (URL && URL.createObjectURL) {
           this.avatar.url = URL.createObjectURL(this.avatar);
         }
       },
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
       updateProfilePic() {
         if (this.avatar == undefined) {
           return;
         }
         this.formData = new FormData();
         this.formData.append('avatar', this.avatar);
         UserService.updateProfilePicture(this.formData).then(response => {
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

      handleSubmit() {
         const {
           first_name,
           last_name,
           middle_name,
           bMonth,
           bDay,
           bYear,
           place_of_birth,
           weight,
           height,
           preferred_foot,
         } = this;
         const nationality_country_code = this.country_code;
         const residence_country_code = this.country_code;
         const birthday = new Date(Date.UTC(bYear, bMonth, bDay));
         this.updateUserInfo({
           first_name,
           middle_name,
           last_name,
           birthday,
           nationality_country_code,
           residence_country_code,
           place_of_birth,
           weight,
           height,
           preferred_foot,
         }).then(response => {
           this.flash('Updated successfully', 'success', {
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
       updateItems(text) {
         this.$set(this, 'searchText', text);
         if (!text) return this.$set(this, 'clubs', []);
         const params = {
           country: this.club_country_code,
           q: text
         }
         ClubService.searchClub(params).then(response => {
           this.$set(this, 'clubs', response.clubs);
         });
       },
       getLabel(item) {
         return item ? item.name : this.searchText;
       },
     },
     mounted() {
       this.fetchCountries();
     }
   };
</script>
