<template>
  <div>
    <landing-navbar />
    <flash-message outerClass="m-feedback"></flash-message>
    <div class="container-fluid team-background">
      <div class="row justify-content-center">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo" />
      </div>
      <div class="row justify-content-center">
        <div class="col col-lg-5">
          <div class="steps-container" v-if="this.role_name == 'director'">
            <p class="steps active"> Step 1 - Personal Details </p>
            <p class="steps inactive"> Step 2 - Register Club </p>
          </div>
          <form @submit.prevent="handleSubmit">
            <fieldset class="form-group col-lg-8 col-md-8">
              <label>Email</label>
              <input type="email" v-model="email" class="form-control m-field-input" autocomplete="username" placeholder="Enter email..."/>
            </fieldset>
            <fieldset class="form-group col-lg-8 col-md-8">
              <label>Password</label>
              <input type="password" v-model="password" class="form-control m-field-input" autocomplete="new-password" placeholder="Enter Password..." />
            </fieldset>
            <fieldset class="form-group col-lg-8 col-md-8">
              <label>Password Confirmation</label>
              <input type="password" v-model="password_confirmation" class="form-control m-field-input" autocomplete="new-password" placeholder="Confirm Password..." />
            </fieldset>
            <fieldset class="form-group col-lg-8 col-md-8">
              <label>Your Name</label>
              <div class="row">
                <div class="col">
                  <input type="text" v-model="first_name" class="form-control m-field-input" placeholder="First Name" />
                </div>
                <div class="col">
                  <input type="text" v-model="last_name" class="form-control m-field-input" placeholder="Last Name" />
                </div>
              </div>
            </fieldset>
            <fieldset class="form-group col-lg-8 col-md-8">
              <label>Date Of Birth</label>
              <div class="row">
                <div class="col">
                  <select v-model="day" class="form-control m-field-input">
                    <option disabled value="" selected>Day</option>
                    <option v-for="d in 31" :key="d" :value="d">{{ d }}</option>
                  </select>
                </div>
                <div class="col">
                  <select v-model="month" class="form-control m-field-input">
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
                </div>
                <div class="col">
                  <select v-model="year" class="form-control m-field-input">
                    <option disabled value="" selected>Year</option>
                    <option v-for="y in validYears" :key="y" :value="y">{{y}}</option>
                  </select>
                </div>
              </div>
            </fieldset>
            <fieldset class="form-group col-lg-8 col-md-8">
              <label>Your Role</label>
              <select v-model="role_name" class="form-control m-field-input">
                <option disabled value="">Role</option>
                <option value="agent">Agent</option>
                <option value="director">Director of Football</option>
                <option value="player">Player</option>
                <option value="scout">Scout</option>
              </select>
            </fieldset>
            <fieldset class="form-group col-lg-8 col-md-8" v-if="this.role_name != 'director'">
              <label>Your Club</label>
              <div class="row">
                <div class="col">
                  <select v-model="club_country_code" class="form-control m-field-input">
                    <option disabled value="" selected>Country</option>
                    <option v-for="c in countries" :key="c.country_code" :value="c.country_code">{{ c.country_name }}</option>
                  </select>
                </div>
              </div>
              <div class="row">
                <div class="col">
                  <autocomplete input-class="form-control m-field-input"
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
              </div>
            </fieldset>
            <fieldset class="form-group col-lg-8 col-md-8">
              <label class="club-note" v-if="this.role_name == 'director'">*As a Director, to register your Club, create your individual profile first.</label>
            </fieldset>
            <fieldset class="form-group col-lg-8 col-md-8 tc-container">
              <div class="row">
                <div class="col-sm-12">
                  <input type="checkbox" id="tc" name="termsandconditions" v-model="tccheck" />
                  <label for="tc">Agree to our <router-link class="tnc" to="/terms_conditions">Terms &amp; Conditions</router-link> </label>
                </div>
              </div>
            </fieldset>
            <div class="col-lg-8 col-md-8">
              <button v-if="loading"
                class="form-control a-bar-button center" type="button" disabled>Signing Up...</button>
              <button v-else
                class="form-control a-bar-button center" type="submit">Sign Up</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  form {
    margin-top: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .alert.alert-danger {
    background: transparent;
    border: none;
    text-align: center;
    font-size: 0.9rem;
    color: #fff;
  }

  p {
    display: inline-block;
  }
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
    'landing-navbar': LandingNavbar,
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
      currentYear: new Date().getUTCFullYear(),
      validYears: (() => {
        const currentYear = new Date().getUTCFullYear();
        let rtv = [];
        for (let i = currentYear - 99; i < currentYear - 15; i++) {
          rtv.push(i);
        }

        return rtv.reverse();
      })(),
      loading: false
    };
  },
  methods: {
    nextPage() {
      this.$parent.$parent.nextTab()
    },
    handleSubmit() {
      if (_.isEmpty(this.email)) {
        this.flash('An email is needed', 'error', {
          timeout: 3000,
          important: true
        });
        return;
      }
      if (this.password !== this.password_confirmation) {
        this.flash("Passwords don't Match", 'error', {
          timeout: 3000,
          important: true
        });
        return;
      } else if (this.day.length === 0 || this.month.length === 0) {
        this.flash('Please Enter Date of Birth', 'error', {
          timeout: 3000,
          important: true
        });
        return;
      } else if (!this.role_name) {
        this.flash('Please choose a role', 'error', {
          timeout: 3000,
          important: true
        });
        return;
      } else if (!this.tccheck) {
        this.flash('Please agree to our Terms and Conditions', 'error', {
          timeout: 3000,
          important: true
        });
        return;
      } else if (this.role_name !== "director" && !this.searchText) {
        this.flash('Please choose an existing club or enter the name and country of your club', 'error', {
          timeout: 3000,
          important: true
        });
        return;
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
      this.loading = true;
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
              this.loading = false;
              this.$router.push({ path: '/users/sign_in' });
            }
          }
        } else {
          this.loading = false;
          res.json().then(r => {
            this.flash(r.errors.join(", "), 'error', {
              timeout: 3000,
              important: true
            });
          });
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
      this.searchText = text;
      if (!text) return this.clubs = [];
      const params = {
        country: this.club_country_code,
        q: text
      }
      ClubService.searchClub(params).then(response => {
        this.clubs = response.clubs;
      });
    },
    getLabel(item) {
      return item ? item.name : this.searchText;
    },
    itemSelected(item) {
      this.item = item;
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
