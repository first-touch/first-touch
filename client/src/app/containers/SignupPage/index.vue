<template>
  <signup-template :role="role_name" v-if="role_name != 'director'"/>
  <form-wizard v-else-if="role_name == 'director'">
    <tab-content title="Personal details" shape="tab">
      <signup-template :role="role_name"/>
    </tab-content>
<<<<<<< HEAD
    <tab-content title="Register Club" shape="tab">
=======
    <tab-content title="Register Club">
>>>>>>> WIP - pass down userID to sibling component successfully
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
