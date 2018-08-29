<template>
  <div>
    <navbar />
    <div class="container-fluid">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo" />
      </div>

      <h1> Confirming Account </h1>
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

export default {
  name: 'ConfirmAccount',
  components: {
    navbar: LandingNavbar
  },
  data() {
    return {
      confirmation_token: '',
    };
  },
  mounted() {
    console.log(this.$route.query);
  },
};
</script>
