<template>
  <div>
    <landing-navbar />
    <div class="container-fluid team-background">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo"  />
      </div>
      <div class="col col-lg-5">
        <form @submit.prevent="handleSubmit">
          <fieldset class="form-group col-lg-8 col-md-8">
            <label>Email</label>
            <input type="email" v-model="email" class="form-control m-field-input"  autocomplete="username" placeholder="Enter email..."/>
          </fieldset>
          <fieldset class="form-group col-lg-8 col-md-8">
            <label>Password</label>
            <input type="password" v-model="password" class="form-control m-field-input" autocomplete="current-password" placeholder="Enter password..."/>
          </fieldset>
          <div class="col-lg-8 col-md-8">
            <button v-if="loading"
              class="form-control a-bar-button center" type="button" disabled>Logging In...</button>
            <button v-else
              class="form-control a-bar-button center" type="submit">Login</button>
          </div>
          <fieldset class="col-md-8">
            <div v-if="errorMessage" class="alert alert-danger">
              <em>{{ errorMessage }}</em>
            </div>
          </fieldset>
          <div class="col-md-10 suggestions-container">
            <div class="row d-flex justify-content-center">
              <div class="not-registered">
                <p>Not registered?</p>
                <span>
                  <router-link class="m-main-navigation-link" to="/users/sign_up"> Create your account </router-link>
                </span>
              </div>
            </div>
            <div class="row d-flex justify-content-center">
              <div class="forgot-password">
                <p>Forgot your password?</p>
                <span>
                  <router-link class="m-main-navigation-link" to="/users/reset_password"> Reset your password </router-link>
                </span>
              </div>
            </div>
          </div>
        </form>
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
import { mapGetters, mapActions } from 'vuex';

import { ASYNC_LOADING, ASYNC_FAIL } from 'app/constants/AsyncStatus';
import LandingNavbar from 'app/components/LandingNavbar';

export default {
  name: 'LoginPage',
  components: {
    'landing-navbar': LandingNavbar,
  },
  data() {
    return {
      email: '',
      password: '',
      errorMessage: ''
    };
  },
  computed: {
    // ...mapGetters(['authenticating']),
    ...mapGetters(['token']),
    loading() {
      // return this.authenticating;
      return this.token && (this.token.status === ASYNC_LOADING);
    },
    error() {
      if (this.token && this.token.status != ASYNC_FAIL) {
        return false;
      }
      return JSON.parse(this.token.err)['errors'];
    },
  },
  methods: {
    ...mapActions(['attemptLogIn']),
    handleSubmit() {
      let email = this.email;
      let password = this.password;

      this.attemptLogIn({ email, password }).then(() => {
        this.$router.push('/');
      }).catch((err) => {
        this.errorMessage = err.errors;
      });
    },
  },
};
</script>
