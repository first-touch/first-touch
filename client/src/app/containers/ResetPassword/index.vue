<template>
  <div>
    <landing-navbar />
    <div class="container-fluid page-container">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo"  />
      </div>
      <div v-if="requested" class="col col-lg-5">
        <div class="row justify-content-lg-center">
          <div class="header-wrapper">
            <h1> We just emailed you </h1>
            <p> Please check your email (<span class="a-highlight">{{ email }}</span>) and click the secure link.</p>
          </div>
          <div class="footnote">
            <p> If you don’t see our email, check your spam folder or <a class="a-link light" href="/contact">Contact us</a></p>
          </div>
        </div>
      </div>
      <div v-else class="col col-lg-5">
        <form @submit.prevent="requestPasswordReset">
          <fieldset class="form-group col-lg-8">
            <label>Email</label>
            <input type="email" v-model="email" class="form-control m-field-input" autocomplete="username" placeholder="Enter email..."/>
          </fieldset>
          <div class="col-lg-8">
            <button class="form-control a-bar-button center" type="submit">Reset Password</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.page-container {
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
</style>

<script>
import LandingNavbar from 'app/components/LandingNavbar';
import AccountService from 'app/services/AccountService';

export default {
  name: 'ResetPassword',
  components: {
    'landing-navbar': LandingNavbar,
  },
  data() {
    return {
      email: '',
      requested: false
    };
  },
  methods: {
    requestPasswordReset() {
      AccountService.requestPasswordReset(this.email).then(response => {
        this.requested = true;
      });
    }
  }
};
</script>
