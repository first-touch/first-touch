<template>
  <div>
    <landing-navbar />
    <div class="container-fluid">
      <div class="logo">
        <img src="/images/landing-page/ft-logo.png" alt="Ft Logo" />
      </div>
      <div class="col-lg-5">
        <div v-if="submitted">
          <br /><br />
          <h4>Thank you for your interest! First Touch will see you soon!</h4>
        </div>
        <div v-else>
          <p>
            <br />
            <strong>We’re glad you’re so excited.</strong> The build up so far
            had been thrilling and now we're waiting for that killer ball to ...
            what we're trying to say is, there's not much longer to wait. We're
            putting those finishing touches to the platform that will make it all
            worth your while.
            <br /><br />
            So for now, please be patient with us, sign up and we'll keep you
            posted, get you involved and invite you for early access.
            <br /><br />
          </p>
          <form @submit.prevent="preregisterUser">
            <fieldset class="form-group">
              <div class="row">
              <div class="col-lg-8">
                <input type="text" v-model="email" @keydown="hideAlerts" class="form-control" placeholder="Enter your email..." required />
              </div>
              <div class="col-lg-4">
                <button class="a-bar-button center" type="submit">Submit</button>
              </div>
              </div>
            </fieldset>

          </form>
          <div v-if="invalidEmail" class="alert alert-danger">
            <strong>Invalid Email!</strong> Please check and try again.
          </div>
          <div v-if="ajaxErr" class="alert alert-danger">
            <strong>Error!</strong> {{ ajaxErr }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
p {
  font-size: 1.2em;
}

.container-fluid {
  background: url('/images/landing-page/team-logo.jpg') no-repeat center center
    fixed;
  background-size: cover;
  min-height: calc(100vh - 78px);
  display: flex;
  align-items: center;
  justify-content: center;
}

.logo {
  display: flex;
  justify-content: center;
}

.a-bar-button {
  max-width: 150px;
  margin: 0;
}

.col-lg-5 {
  margin-left: 100px;
}

@media (max-width: 986px) {
  p {
    text-align: center;
  }

  .col-lg-5 {
    margin-left: 0;
  }

  .container-fluid {
    flex-direction: column;
  }

  .a-bar-button {
    margin-top: 20px;
    max-width: none;
    width: 100%;
  }
}
</style>

<script>
import LandingNavbar from 'app/components/LandingNavbar.vue';

export default {
  name: 'PreRegistration',
  components: {
    'landing-navbar': LandingNavbar,
  },
  data() {
    return {
      email: '',
      invalidEmail: false,
      submitted: false,
      ajaxErr: '',
    };
  },
  methods: {
    preregisterUser() {
      if (!validateEmail(this.email)) {
        this.invalidEmail = true;
        return;
      } else {
        $.ajax({
          url: '/api/v1/pre_register',
          method: 'POST',
          data: {
            emai: this.email,
          },
        })
          .done(() => (this.submitted = true))
          .fail(e => (this.ajaxErr = e.responseText));
      }
    },
    hideAlerts() {
      this.invalidEmail = false;
      this.ajaxErr = false;
    },
  },
};

// helper functions
function validateEmail(email) {
  var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(email);
}
</script>
