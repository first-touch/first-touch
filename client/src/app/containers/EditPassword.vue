<template>
  <div>
    <landing-navbar />
    <div class="container-fluid page-container">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo"  />
      </div>
      <div class="col col-lg-5">
        <form @submit.prevent="submitNewPassword">
          <fieldset class="form-group col-md-12">
            <label>Password</label>
            <input type="password" v-model="password" class="form-control" autocomplete="password" placeholder="Enter password..."/>
          </fieldset>
          <button class="a-bar-button center" type="submit">Set new password</button>
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
import UserService from 'app/services/UserService';

export default {
  name: 'EditPassword',
  components: {
    'landing-navbar': LandingNavbar,
  },
  data() {
    return {
      password: '',
      token: '',
    };
  },
  mounted() {
    this.token = this.$route.query.reset_token;
  },
  methods: {
    submitNewPassword() {
      let passwordContent = {
        password: this.password,
        password_confirmation: this.password
      }
      UserService.update(passwordContent, this.token).then(response => {
        console.log('success');
      }).catch(response => {
        console.log('error')
      });
    }
  }
};
</script>
