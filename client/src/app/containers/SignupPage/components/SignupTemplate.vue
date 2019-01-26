<template>
  <div>
    <navbar />
    <div class="container-fluid team-background">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo" />
      </div>
      <div class="col col-lg-5">
        <div class="steps-container" v-if="this.role_name == 'director'">
          <p class="steps active"> Step 1 - Personal Details </p>
          <p class="steps inactive"> Step 2 - Register Club </p>
        </div>

        <form class="form" @submit.prevent="handleSubmit">
          <fieldset class="form-group col-lg-12 col-md-8">
            <label>Email</label>
            <input type="email" v-model="email" class="form-control" autocomplete="username" placeholder="Enter Email..." />
          </fieldset>
          <fieldset class="form-group col-lg-12 col-md-8">
            <label>Password</label>
            <input type="password" v-model="password" class="form-control" autocomplete="new-password" placeholder="Enter Password..." />
          </fieldset>
          <fieldset class="form-group col-lg-12 col-md-8">
            <label>Password Confirmation</label>
            <input type="password" v-model="password_confirmation" class="form-control" autocomplete="new-password" placeholder="Confirm Password..." />
          </fieldset>
          <fieldset class="form-group col-lg-12 col-md-8">
            <label>Your Name</label>
            <div class="row">
              <input type="text" v-model="first_name" class="form-control col-lg-10 col-md-6" placeholder="First Name" />
              <input type="text" v-model="last_name" class="form-control col-lg-10 col-md-6" placeholder="Last Name" />
            </div>
          </fieldset>
          <fieldset class="form-group col-lg-12 col-md-8">
            <label>Date Of Birth</label>
            <div class="row">
              <select v-model="day" class="form-control col-lg-3 col-md-3">
                <option disabled value="" selected>Day</option>
                <option v-for="d in 31" :key="d" :value="d">{{ d }}</option>
              </select>
              <select v-model="month" class="form-control col-lg-6 col-md-6">
                <option disabled value="" selected>Month</option>
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
              <select v-model="year" class="form-control col-lg-3 col-md-3">
                <option disabled value="" selected>Year</option>
                <option v-for="y in validYears" :key="y" :value="y">{{y}}</option>
              </select>
            </div>
          </fieldset>
          <fieldset class="form-group col-lg-12 col-md-8">
            <label>Your Role</label>
            <div class="row">
              <select v-model="role_name" class="form-control">
                <option disabled value="">Role</option>
                <option value="player">Player</option>
                <option value="scout">Scout</option>
                <option value="director">Director</option>
                <option value="manager">Manager</option>
                <option value="coach">Coach</option>
              </select>
            </div>
          </fieldset>
          <fieldset class="form-group col-lg-12 col-md-8" v-if="this.role_name != 'director'">
            <label>Your Club*</label>
            <div class="row">
              <select v-model="club_country_code" class="form-control col-lg-4 col-md-4">
                <option disabled value="" selected>Country</option>
                <option v-for="c in countries" :key="c.country_code" :value="c.country_code">{{ c.country_name }}</option>
              </select>
              <autocomplete class="col-lg-8 col-md-8" input-class="form-control"
                placeholder="Search for OR Add Club"
                v-model="item"
                :get-label="getLabel"
                :items="clubs"
                :component-item="template"
                @update-items="updateItems"
                :min-len="3"
                :auto-select-one-item="false"
                :input-attrs="{disabled: countries.length === 0 || club_country_code === ''}"
                />
            </div>
          </fieldset>
          <fieldset class="form-group col-lg-12 col-md-8">
            <label class="club-note" v-if="this.role_name == 'director'">*As a Director, to register your Club, create your individual profile first.</label>
          </fieldset>
          <fieldset class="form-group col-lg-12 col-md-8 tc-container">
            <input type="checkbox" id="tc" name="termsandconditions" v-model="tccheck" />
            <label for="tc">By checking this box, you agree to our <router-link to="/terms_conditions">Terms &amp; Conditions</router-link> </label>
          </fieldset>
          <button class="form-control a-bar-button center col-md-8" type="submit">Sign Up</button>
          <fieldset class="col-lg-12 col-md-8">
            <div v-if="error" class="alert alert-danger">
              <em>{{ error }}</em>
            </div>
          </fieldset>
        </form>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/template/sign-in-page.scss';
@import '~stylesheets/atoms/mobile-text';

@media (max-width: $max-mobile-width) {
  a {
    font-size: 1em
  }
}
</style>

<style lang="scss">
@import '~stylesheets/molecules/auto-complete.scss';
@import '~stylesheets/molecules/steps.scss';
@import '~stylesheets/variables';
</style>

<script>
import { mapActions } from 'vuex';
import LandingNavbar from 'app/components/LandingNavbar';
import AutoComplete from 'v-autocomplete';
import ItemTemplate from './ItemTemplate';
import ClubService from 'app/services/ClubService'
import UserService from 'app/services/UserService'

export default {
  name: 'SignupTemplate',
  components: {
    navbar: LandingNavbar,
    autocomplete: AutoComplete,
  },
  props: ['role'],
  data() {
    return {
      email: '',
      password: '',
      password_confirmation: '',
      first_name: '',
      last_name: '',
      month: '',
      day: '',
      year: '',
      role_name: this.role,
      tccheck: false,
      club_country_code: '',
      countries: [],
      clubs: [],
      template: ItemTemplate,
      item: null,
      searchText: '',
      error: null,
      currentYear: new Date().getUTCFullYear(),
      validYears: (() => {
        const currentYear = new Date().getUTCFullYear();
        let rtv = [];
        for (let i = currentYear - 99; i < currentYear - 15; i++) {
          rtv.push(i);
        }

        return rtv.reverse();
      })(),
    };
  },
  methods: {
    ...mapActions(['attemptLogIn']),
    nextPage() {
      this.$parent.$parent.nextTab()
    },
    handleSubmit() {
      if (this.password !== this.password_confirmation) {
        return this.$set(this, 'error', "Passwords don't Match!");
      } else if (this.day.length === 0 || this.month.length === 0) {
        return this.$set(this, 'error', 'Please Enter Date of Birth!');
      } else if (!this.role_name) {
        return this.$set(this, 'error', 'Please choose a role!');
      } else if (!this.tccheck) {
        return this.$set(
          this,
          'error',
          'Please agree to our Terms and Conditions',
        );
      } else if (this.role_name !== "director" && !this.searchText) {
        return this.$set(
          this,
          'error',
          'Please choose an existing club or enter the name and country of your club!'
        );
      }
      var clubId = undefined;
      if (this.item) {
        clubId = this.item.id;
      }
      const data = {
        email: this.email,
        password: this.password,
        password_confirmation: this.password_confirmation,
        club_id: clubId,
        personal_profile: {
          first_name: this.first_name,
          last_name: this.last_name,
          birthday: new Date(Date.UTC(this.year, this.month, this.day))
        },
        role_name: this.role_name,
      };

      UserService.register(data).then(res => {
        if (res.status === 201) {
          if (this.role_name == "director") {
            res.json().then((data) => {
              this.$store.state.userID = data.id
              this.nextPage()
            })
          } else {
            if (this.shouldCreateClub(this.item)) {
              res.json().then((data) => {
                const clubData = {
                  account_owner_id: data.id,
                  country_code: this.club_country_code,
                  name: this.searchText
                };
                ClubService.create(clubData).then(res => {
                  if (res.status === 201) {
                    this.$router.push({ path: '/users/sign_in' });
                  }
                })
              })
            } else {
              this.$router.push({ path: '/users/sign_in' });
            }
          }
        } else {
          res.json().then(r => this.$set(this, 'error', r.errors.join(", ")));
        }
      });
    },
    fetchCountries() {
      ClubService.countriesForClubs().then(response => {
        this.$set(
          this,
          'countries',
          response.countries.sort((a, b) => a.country_name > b.country_name),
        )
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
    itemSelected(item) {
      this.$set(this, 'item', item);
    },
    shouldCreateClub(clubId) {
      return Boolean(!clubId && this.searchText && this.club_country_code)
    }
  },
  mounted() {
    this.fetchCountries();
  },
};
</script>
