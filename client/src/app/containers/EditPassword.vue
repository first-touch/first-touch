<template>
  <div>
    <landing-navbar />
    <div class="container-fluid page-container">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo"  />
      </div>

      <div v-if="submitted" class="col col-lg-5">
        <div class="header-wrapper">
          <h1> {{ feedbackTitle }} </h1>
          <p> {{ feedbackMessage }} </p>
        </div>
        <div class="footnote">
          <a v-if="success" class="a-link-button light" href="/users/sign_in">Login</a>
          <a v-else class="a-link-button light center" href="/users/reset_password">Request new Reset Password Email</a>
        </div>
      </div>
      <div v-else class="col col-lg-5">
        <form @submit.prevent="submitNewPassword">
          <fieldset class="form-group col-md-12">
            <label>Password</label>
            <input type="password" v-model="password" class="form-control m-field-input" autocomplete="password" placeholder="Enter password..."/>
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

.header-wrapper {
  margin-top: 50px;
}
</style>

<script>
import LandingNavbar from 'app/components/LandingNavbar';
import AccountService from 'app/services/AccountService';

export default {
  name: 'EditPassword',
  components: {
    'landing-navbar': LandingNavbar,
  },
  data() {
    return {
      password: '',
      token: '',
      submitted: false,
      feedbackMessage: '',
      success: false
    };
  },
  computed: {
    feedbackTitle() {
      if (this.success) {
        return "Password successfully updated";
      } else {
        return "An error occured when resetting the password";
      }
    }
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
      AccountService.updatePassword(passwordContent, this.token).then(response => {
        this.submitted = true;
        this.feedbackMessage = response.data;
        this.success = true;
      }).catch(response => {
        this.submitted = true;
        this.feedbackMessage = response.errors;
        this.success = false;
      });
    }
  }
};
</script>
