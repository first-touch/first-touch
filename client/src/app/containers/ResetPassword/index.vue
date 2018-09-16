<template>
  <div>
    <landing-navbar />
    <div class="container-fluid page-container">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo"  />
      </div>
      <div class="col col-lg-5">
        <form @submit.prevent="requestPasswordReset">
          <fieldset class="form-group col-md-12">
            <label>Email</label>
            <input type="email" v-model="email" class="form-control" autocomplete="username" placeholder="Enter email..."/>
          </fieldset>
          <button class="a-bar-button center" type="submit">Reset Password</button>
        </form>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.page-container {
  background: url('/images/landing-page/team-logo.jpg') no-repeat center center
    fixed;
  background-size: cover;
  min-height: calc(100vh - 78px);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
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
      email: ''
    };
  },
  methods: {
    requestPasswordReset() {
      AccountService.requestPasswordReset(this.email).then(response => {
        console.log('email has been sent. follow instructions');
      });
    }
  }
};
</script>
