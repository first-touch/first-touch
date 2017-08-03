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
            <input type="email" v-model="email" class="form-control" placeholder="Enter Email..." />
          </fieldset>
          <fieldset class="form-group col-md-12">
            <label>Password</label>
            <input type="password" v-model="password" class="form-control" placeholder="Enter Password..." />
          </fieldset>
          <fieldset class="form-group col-md-12">
            <label>Password Confirmation</label>
            <input type="password" v-model="password_confirmation" class="form-control" placeholder="Confirm Password..." />
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
              <select v-model="month" class="form-control col-md-3">
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
              <select v-model="day" class="form-control col-md-3">
                <option disabled value="">Date</option>
                <option v-for="d in 31" :value="d">{{ d }}</option>
              </select>
              <input type="number" v-model="year" class="form-control col-md-6" placeholder="Year" />
            </div>
          </fieldset>
          <button class="bar-button center" type="submit">Sign Up</button>
          <fieldset class="col-md-12">
            <div v-if="error" class="alert alert-danger">
              {{ error }}
            </div>
          </fieldset>
        </form>
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
  .container-fluid {
    background: url('/images/landing-page/team-logo.jpg') no-repeat center center fixed;
    background-size: cover;
    min-height: calc(100vh - 78px);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }

  .form {
    margin-top: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    .row {
      margin: 0 1px;
    }
  }

</style>

<script>
import { mapActions } from 'vuex';
import LandingNavbar from '../shared/components/LandingNavbar.vue';

export default {
  name: 'SignupPage',
  components: {
    'navbar': LandingNavbar
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
      error: null
    }
  },
  methods: {
    ...mapActions(['attemptLogIn']),
    handleSubmit() {
      if (this.password !== this.password_confirmation) {
        return this.$set(this, 'error', 'Password Doesn\'t Match!');
      } else if (this.day.length === 0 || this.month.length === 0) {
        return this.$set(this, 'error', 'Please Enter Date of Birth!');
      } else if (this.year < 1900 || this.year > (new Date()).getUTCFullYear()) {
        return this.$set(this, 'error', 'Invalid Year of Birth!');
      }
      const data = {
        email: this.email,
        password: this.password,
        password_confirmation: this.password_confirmation,
        personal_profile_attributes: {
          first_name: this.first_name,
          last_name: this.last_name,
          date_of_birth: new Date(Date.UTC(this.year, this.month, this.day))
        }
      };

      fetch('/api/v1/users/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      }).then((res) => {
        if (res.status === 200) {
          this.attemptLogIn({ email: this.email, password: this.password });
        } else {
          res.json().then((r) => this.$set(this, 'error', r.error));
        }
      })
    }
  }
}
</script>