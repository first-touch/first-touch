<template>
  <div>
    <landing-navbar />
    <div class="container-fluid">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo"  />
      </div>
      <div class="col col-lg-5">
        <form @submit.prevent="requestPasswordReset">
          <fieldset class="form-group col-md-8">
            <label>Email</label>
            <input type="email" v-model="email" class="form-control"  autocomplete="username" placeholder="Enter email..."/>
          </fieldset>
        </form>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/landingpage';
.container-fluid {
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
      console.log("hello");
    }
  }
};
</script>
