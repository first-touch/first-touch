<template>
  <div>
    <navbar />
    <div class="container-fluid">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo" />
      </div>
      <div class="col col-lg-5">
        <form class="form" @submit.prevent="handleSubmit">
          <fieldset class="form-group col-md-12">
            <label>Email</label>
            <input type="email" v-model="email" class="form-control" autocomplete="username" placeholder="Enter Email..." />
          </fieldset>
          <fieldset class="form-group col-md-12">
            <label>Password</label>
            <input type="password" v-model="password" class="form-control" autocomplete="new-password" placeholder="Enter Password..." />
          </fieldset>
          <fieldset class="form-group col-md-12">
            <label>Password Confirmation</label>
            <input type="password" v-model="password_confirmation" class="form-control" autocomplete="new-password" placeholder="Confirm Password..." />
          </fieldset>
          <fieldset class="form-group col-md-12">
            <label>Your Name</label>
            <div class="row">
              <input type="text" v-model="first_name" class="form-control col-md-6" placeholder="First Name" />
              <input type="text" v-model="last_name" class="form-control col-md-6" placeholder="Last Name" />
            </div>
          </fieldset>
          <fieldset class="form-group col-md-12">
            <label>Date Of Birth</label>
            <div class="row">
              <select v-model="day" class="form-control col-md-3">
                <option disabled value="" selected>Day</option>
                <option v-for="d in 31" :key="d" :value="d">{{ d }}</option>
              </select>
              <select v-model="month" class="form-control col-md-6">
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
              <select v-model="year" class="form-control col-md-3">
                <option disabled value="" selected>Year</option>
                <option v-for="y in validYears" :key="y" :value="y">{{y}}</option>
              </select>
            </div>
          </fieldset>
          <fieldset class="form-group col-md-12">
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
          <fieldset class="form-group col-md-12">
            <label>Your Club*</label>
            <div class="row">
              <select v-model="club_country_code" class="form-control col-md-4">
                <option disabled value="" selected>Country</option>
                <option v-for="c in countries" :key="c.country_code" :value="c.country_code">{{ c.country_name }}</option>
              </select>
              <autocomplete class="col-md-8" input-class="form-control"
                placeholder="Search For Club"
                v-model="item"
                :get-label="getLabel"
                :items="clubs"
                :component-item="template"
                @update-items="updateItems"
                :min-len="0"
                :auto-select-one-item="false"
                :input-attrs="{disabled: countries.length === 0 || club_country_code === ''}"
                />
            </div>
          </fieldset>
          <fieldset class="form-group col-md-12">
            <label class="club-note">*To register your Club, create your individual profile first.</label>
          </fieldset>
          <fieldset class="form-group col-md-12 tc-container">
            <input type="checkbox" id="tc" name="termsandconditions" v-model="tccheck" />
            <label for="tc">By checking this box, you agree to our <router-link to="/terms_conditions">Terms &amp; Conditions</router-link> </label>
          </fieldset>
          <button class="bar-button center" type="submit">Sign Up</button>
          <fieldset class="col-md-12">
            <div v-if="error" class="alert alert-danger">
              <em>{{ error }}</em>
            </div>
          </fieldset>
        </form>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
.v-autocomplete {
  padding-right: 0;
  .v-autocomplete-input-group {
    .v-autocomplete-input {
      font-size: 1.5em;
      padding: 10px 15px;
      box-shadow: none;
      border: 1px solid #157977;
      width: calc(100% - 32px);
      outline: none;
      background-color: #eee;
    }
    &.v-autocomplete-selected {
      .v-autocomplete-input {
        color: green;
        background: #f2fff2;
      }
    }
  }
  .v-autocomplete-list {
    position: absolute;
    z-index: 2;
    width: calc(100% - 15px);
    text-align: left;
    border: none;
    max-height: 400px;
    overflow-y: auto;
    border-bottom: 1px solid #157977;
    .v-autocomplete-list-item {
      cursor: pointer;
      background-color: #fff;
      color: #000;
      padding: 5px 10px;
      border-bottom: 1px solid #157977;
      border-left: 1px solid #157977;
      border-right: 1px solid #157977;
      &:last-child {
        border-bottom: none;
      }
      &:hover {
        background-color: #eee;
      }
      abbr {
        opacity: 0.8;
        font-size: 0.8em;
        display: block;
        font-family: sans-serif;
      }
    }
  }
}
</style>

<style lang="scss" scoped>
@import '~stylesheets/variables.scss';
.container-fluid {
  background: url('/images/landing-page/team-logo.jpg') no-repeat center center
    fixed;
  background-size: cover;
  min-height: calc(100vh - 78px);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 50px 0;
}

.form {
  margin-top: 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  .row {
    margin: 0 1px;
    justify-content: space-between;
    .col-md-6 {
      flex-basis: calc(50% - 5px);
    }
    .col-md-3 {
      flex-basis: calc(25% - 5px);
    }
  }
  .tc-container {
    #tc {
      height: 16px;
    }
    label {
      margin-bottom: 0;
      a {
        color: $secondary-text-color;
      }
      a:hover {
        color: $main-text-color;
      }
    }
  }
}

.alert.alert-danger {
  background: transparent;
  border: none;
  text-align: center;
  font-size: 0.9rem;
  color: #fff;
}
</style>

<script>
import { mapActions } from 'vuex';
import LandingNavbar from 'app/components/LandingNavbar';
import AutoComplete from 'v-autocomplete';
import ItemTemplate from './components/ItemTemplate';
import _ from 'lodash';
import ClubService from 'app/services/ClubService';

export default {
  name: 'SignupPage',
  components: {
    navbar: LandingNavbar,
    autocomplete: AutoComplete,
  },
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
      role_name: '',
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
    handleSubmit() {
      if (this.password !== this.password_confirmation) {
        return this.$set(this, 'error', "Passwords don't Match!");
      } else if (this.day.length === 0 || this.month.length === 0) {
        return this.$set(this, 'error', 'Please enter Date of Birth!');
      } else if (!this.role_name) {
        return this.$set(this, 'error', 'Please choose a role!');
      } else if (!this.tccheck) {
        return this.$set(
          this,
          'error',
          'Please agree to our Terms and Conditions',
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
        personal_profile: {
          first_name: this.first_name,
          last_name: this.last_name,
          birthday: new Date(Date.UTC(this.year, this.month, this.day)),
          club_id: clubId
        },
        role_name: this.role_name,
      };

      fetch('/api/v1/users/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
      }).then(res => {
        if (res.status === 201) {
          this.$router.push({ path: '/users/sign_in' });
        } else {
          res.json().then(r => this.$set(this, 'error', r.errors.join(", ")));
        }
      });
    },
    fetchCountries() {
      ClubService.firstTouchCountries().then( data => {
        let sortedCountries = _.sortBy(data.countries, "country_name");
        this.countries = sortedCountries;
      })
    },
    updateItems(text) {
      this.$set(this, 'searchText', text);
      if (!text) return this.$set(this, 'clubs', []);
      fetch(`/api/v1/clubs/search?country=${this.club_country_code}&q=${text}`)
        .then(res => res.status === 200 && res.json())
        .then(({ clubs }) => {
          this.$set(this, 'clubs', clubs.slice(0, 3));
        });
    },
    getLabel(item) {
      return item ? item.name : this.searchText;
    },
    itemSelected(item) {
      this.$set(this, 'item', item);
    },
  },
  mounted() {
    this.fetchCountries();
  },
};
</script>
