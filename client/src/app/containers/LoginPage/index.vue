<template>
  <div>
    <landing-navbar />
    <div class="container-fluid">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo"  />
      </div>
      <div class="col col-lg-5">
        <form @submit.prevent="handleSubmit">
          <fieldset class="form-group col-lg-8">
            <label>Email</label>
            <input type="email" v-model="email" class="form-control m-field-input"  autocomplete="username" placeholder="Enter email..."/>
          </fieldset>
          <fieldset class="form-group col-lg-8">
            <label>Password</label>
            <input type="password" v-model="password" class="form-control m-field-input" autocomplete="current-password" placeholder="Enter password..."/>
          </fieldset>
          <button v-if="loading"
            class="a-bar-button center" type="button" disabled>Logging In...</button>
          <button v-else
            class="a-bar-button center" type="submit">Login</button>
          <fieldset class="col-md-8">
            <div v-if="error" class="alert alert-danger">
              <em>{{ error }}</em>
            </div>
          </fieldset>
          <div class="col-md-8">
            <div class="row d-flex justify-content-center">
              <div class="not-registered">
                Not registered?
                <span>
                  <router-link class="m-main-navigation-link" to="/users/sign_up"> Create your account </router-link>
                </span>
              </div>
            </div>
            <div class="row d-flex justify-content-center">
              <div class="forgot-password">
                Forgot your password?
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
  .container-fluid {
    background: url('/images/landing-page/bg-teams.png') no-repeat center center
      fixed;
    background-size: cover;
    min-height: calc(100vh - 78px);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }

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
    };
  },
  computed: {
    ...mapGetters(['token']),
    loading() {
      return this.token.status === ASYNC_LOADING;
    },
    error() {
      if (this.token.status != ASYNC_FAIL) {
        return false;
      }
      return JSON.parse(this.token.err)['errors'];
    },
  },
  methods: {
    ...mapActions(['attemptLogIn']),
    handleSubmit() {
      this.attemptLogIn(this);
    },
  },
};
</script>
