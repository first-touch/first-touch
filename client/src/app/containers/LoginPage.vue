<template>
  <div>
    <landing-navbar />
    <div class="container-fluid">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo"  />
      </div>
      <div class="col col-lg-5">
        <form @submit.prevent="handleSubmit">
          <fieldset class="form-group col-md-8">
            <label>Email</label>
            <input type="email" v-model="email" class="form-control"  placeholder="Enter email..."/>
          </fieldset>
          <fieldset class="form-group col-md-8">
            <label>Password</label>
            <input type="password" v-model="password" class="form-control" placeholder="Enter password..."/>
          </fieldset>
          <button v-if="loading"
            class="bar-button center" type="button" disabled>Logging In...</button>
          <button v-else
            class="bar-button center" type="submit">Login</button>
          <fieldset class="col-md-8">
            <div v-if="error" class="alert alert-danger">
              {{ error }}
            </div>
          </fieldset>
        </form>
      </div>
    </div>
  </div>
</template>

<style scoped>
  .container-fluid {
    background: url('/images/landing-page/team-logo.jpg') no-repeat center center fixed;
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
</style>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import store from '../store';

  import { ASYNC_LOADING, ASYNC_FAILURE } from '../constants/AsyncStatus';
  import LandingNavbar from '../components/LandingNavbar.vue';

  export default {
    name: 'LoginPage',
    components: {
      'landing-navbar': LandingNavbar
    },
    data() {
      return {
        email: '',
        password: ''
      }
    },
    computed: {
      ...mapGetters(['token']),
      loading() {
        return this.token.status === ASYNC_LOADING;
      },
      error() {
        return (this.token.status === ASYNC_FAILURE) && 'Error! Invalid Credentials!'
      }
    },
    methods: {
      ...mapActions(['attemptLogIn']),
      handleSubmit() {
        this.attemptLogIn(this);
      }
    }
  }
</script>