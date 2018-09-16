<template>
  <div>
    <navbar />
    <div class="container h-100">
      <div class="row justify-content-center align-items-center row-top-margin">
        <div class="logo">
          <img src="/images/landing-page/ft-logo.png" alt="Ft Logo" />
        </div>
      </div>
      <div class="row justify-content-center align-items-center row-top-margin">
        <div v-if="accountConfirmed">
          <h1> Thank you for registering your account.</h1>
          <h2>
            <router-link class="m-main-navigation-link" to="/users/sign_in">You can now login</router-link>
          </h2>
        </div>
        <h1 v-else> Confirming your account. Please wait </h1>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
  @import '~stylesheets/molecules/m-navigation';
  @import '~stylesheets/common_style';
</style>

<script>
import LandingNavbar from 'app/components/LandingNavbar';
import AccountService from 'app/services/AccountService';

export default {
  name: 'ConfirmAccount',
  components: {
    navbar: LandingNavbar
  },
  data() {
    return {
      confirmationToken: '',
      accountConfirmed: false
    };
  },
  mounted() {
    this.confirmationToken = this.$route.query.confirmation_token

    let confirmationTokenData = {
      confirmation_token: this.confirmationToken
    };
    AccountService.confirm(confirmationTokenData).then((res) => {
      this.accountConfirmed = true;
      // alert('Thank you for confirming your email');
    }).catch(() => {
      // alert('error');
    });
  },
};
</script>
