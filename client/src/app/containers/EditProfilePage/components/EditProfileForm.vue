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
            <select v-model="country_code"  class="form-control m-field-input">
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
        <label>Career Entries</label>
        <fieldset v-for= "(career_history,index )  in career_histories" v-model="career_histories" class="form-group col-md-12">
          <div class="row">
            <div class="career-entries-fast"><h3>{{ index+1 }}</h3></div>
            <select name="country_code" id="country_code" v-model="career_history.club.country_code" class="form-control select-btn col" @change="handleChange">
              <option v-for="c in countries" :key="c.country_code" :value="c.country_code" v-bind:data-foo="c.country_code">{{ c.country_name }}</option>
            </select>
            <select name="club_name" v-model="career_history.club.name" id="club_name" class="form-control col" >
              <option v-bind:value="career_history.club.name">{{ career_history.club.name}}</option>
              <option v-for="club in searched_clubs.clubs" v-bind:value="career_history.club.name">{{ club.name}}</option>
            </select>
          </div>
          <div class="row">
            <div class="col select-btn-two">
              <select name="your_role" id="your_role" class="form-control select-btn col">
                <option value="career_history.role" selected>{{ career_history.role }}</option>
                <option v-for="role in roles" :key="role.role_name" :value="role.role_name">{{ role.role_name }}</option>
              </select>
            </div>
            <div class="col select-btn-two">
              <input v-bind:value="career_history.start_date" type="text" onfocus="(this.type='date')"  id="date" class="form-control m-field-input" >
            </div>
            <div class="col select-btn-three">
              <input v-bind:value="career_history.end_date" type="text" onfocus="(this.type='date')"  id="date" class="form-control m-field-input" >
            </div>
          </div>
          <div class="row">
            <div v-if="!isHidden" id="parent" class="col remove-space">
              <button class="button-delete" @click="deleteCareerEntry(career_history.id,index)" type="button" name="dentry" value="Delete"> Delete </button>
            </div>
          </div>
        </fieldset>
      </fieldset>
      <fieldset class="form-group">
        <button type="submit" class="form-control a-bar-button">Save</button>
      </fieldset>
    </form>
    <br>
    <div class="seperation-box">
      <h3>CAREER ENTRIES </h3>
    </div>
    <fieldset class="form-group">
      <label>Enter New Career Entries</label>
      <fieldset class="form-group col-md-12">
        <div class="row">
          <div class="col">
            <select name="country_code" id="country_code" class="form-control select-btn col" @change="searchClubByCountryCode">
              <option disabled value="" selected>Country</option>
              <option v-for="c in countries" :key="c.country_code" :value="c.country_code" v-bind:data-foo="c.country_code">{{ c.country_name }}</option>
            </select>
          </div>
          <div class="col">
            <select name="club_name" id="club_name" class="form-control col" v-model="club_id">
              <option disabled value="">Select Club</option>
              <option v-for="club in get_clubs.clubs" :key="club.id" :value="club.id">{{ club.name }}</option>
            </select>
           </div>
        </div>
        <div class="row add-margin">
          <div class="col">
            <select name="role_name" v-model="role" id="role_name" class="form-control m-field-input">
              <option disabled value="">Select Role</option>
              <option disabled value="">Role</option>
              <option value="agent">Agent</option>
              <option value="director">Director of Football</option>
              <option value="player">Player</option>
              <option value="scout">Scout</option>
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
      opacity: 0; /* invisible but it's there! */
      width: 100%;
      height: 100px;
      position: absolute;
      cursor: pointer;
      margin-top: -32px;

    }
    .seperation-box{
      border-top: 2px solid #7f8081;
      padding: 10px 0;
    }
    .seperation-box h3{
      color:#7f8081;
      margin: 10px 0px;
      font-size: large;
    }

    .select-btn {
      width: 100%;
      display: inline-block;
      margin: 0 24px 24px 0px;

    }

    .select-btn-two,.select-btn-three {
      padding: 0 0 0 24px;
      margin: 0 0 10px 0px;

    }

    .button-delete {
      color: #fff;
      padding: 5px 14px 5px 15px;
      background: grey;

    }

    .remove-space {
      padding: 0 0 0 24px;

    }

    .career-entries-fast h3 {
      color: #7f8081;
      font-size: 18px;
      padding-right: 10px;

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

   import axios from 'axios';
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
       'careerHistory',

     ],
     data() {
       return {
         isHidden: false,
         club_country_code: '',
         clubs: [],
         item: null,
         searchText: '',
         error: null,
         role_name: this.role,
         first_name: this.firstName || '',
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
         roles: [ { role_name: 'player'},{role_name: 'manager'},{role_name: 'coach'},{role_name: 'scout'},{role_name: 'director'}],
         career_histories: this.careerHistory || '',
         searched_clubs:[],
         get_clubs:[],
         club_id: '',
         start_date: '',
         end_date : '',
         role: '',

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
       handleChange(e) {
         if(e.target.options.selectedIndex > -1) {
            var country_code = e.target.options[e.target.options.selectedIndex].dataset.foo;
            ClubService.searchClubByCountry(country_code).then(response => {
              this.searched_clubs = response
            }).catch(response => {
              console.log(error);
            })
         }
       },
       updateInfo() {
         CareerEntries.returnUserInfo().then(response => {
           this.career_histories =  response.career_history;
         })
       },
       addCareerEntry() {
         var careerInfo =  { "career_entry": {"club_id": this.club_id, "start_date": this.start_date, "end_date": this.end_date, "role": this.role }};
         CareerEntries.updateCareerEntries(careerInfo).then(response => {
             this.updateInfo();
           this.flash('Added successfully', 'success', {
             timeout: 3000,
             important: true
           });
         }).catch(response => {
           this.flash('Failed to add', 'error', {
             timeout: 3000,
             important: true
           });
         })
       },
       searchClubByCountryCode(e) {
         if(e.target.options.selectedIndex > -1) {
            var country_code = e.target.options[e.target.options.selectedIndex].dataset.foo;
            ClubService.searchClubByCountry(country_code).then(response => {
            this.get_clubs = response
          }).catch(response => {
            console.log(error);
         });
        }
       },
       deleteCareerEntry(id,index) {
        this.$delete(this.career_histories, index)
         CareerEntries.deleteCareerEntries(id).then(response => {
           this.flash('Delete successfully', 'success', {
             timeout: 3000,
             important: true
           });
         }).catch(response => {
           this.flash('Failed to delete', 'error', {
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
           career_histories,
         } = this;
         const nationality_country_code = this.country_code;
         const residence_country_code = this.country_code;
         const birthday = new Date(Date.UTC(bYear, bMonth, bDay));
         this.updateUserInfo({
           career_histories,
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
             response.countries.sort((a, b) => a.country_name > b.country_name
            ))
         })
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
