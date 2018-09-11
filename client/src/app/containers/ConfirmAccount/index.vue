<template>
  <div>
    <div class="container-fluid">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo" />
      </div>

      <h1> Confirming Account </h1>
      <h2> Token: {{confirmationToken}}</h2>
    </div>
  </div>
</template>

<style lang="scss">
  @import '~stylesheets/variables';
  @import '~stylesheets/common_style';
</style>

<script>
import { mapActions } from 'vuex';
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
    };
  },
  mounted() {
    this.confirmationToken = this.$route.query.confirmation_token
  },
  updated() {
    let data = {
      confirmation_token: this.confirmationToken
    };
    AccountService.confirm(data).then((res) => {
      alert('Thank you for confirming your email');
    }).catch(() => {
      alert('error');
    });
  },
};
</script>
