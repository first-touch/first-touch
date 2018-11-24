<template>
  <form-wizard>
    <tab-content title="Personal details" shape="tab">
      <signup-template :role="role_name"/>
    </tab-content>
    <tab-content title="Register Club" shape="tab">
      <register-club/>
    </tab-content>
  </form-wizard>
</template>

<script>
import { mapActions } from 'vuex';
import SignupTemplate from './components/SignupTemplate';
import RegisterClub from './components/RegisterClub';

export default {
  name: 'SignupPage',
  components: {
    'signup-template': SignupTemplate,
    'register-club': RegisterClub
  },
  data() {
    if (this.$route.params.role) {
      var role = this.$route.params.role.toLowerCase()
    }
    return {
      role_name: role || ''
    }
  }
}
</script>
