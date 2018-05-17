<template>
  <b-navbar toggleable="md" variant="dark" type="dark" :sticky="sticky" id="landing-navbar">
    <b-nav-toggle target="ft-nav-collapse" />
    <router-link class="navbar-brand" to="/">
      <img src="/images/landing-page/ft-navbar-logo.png" alt="Ft logo">
    </router-link>
    <b-collapse isNav id="ft-nav-collapse">
      <b-nav class="ml-auto">
        <!-- <b-nav-item>
          <router-link to="#" class="nav-link">Change Language</router-link>
        </b-nav-item> -->
        <b-nav-item>
          <router-link to="/users/sign_in" class="nav-link">Sign In</router-link>
        </b-nav-item>
        <form class="form-inline">
          <router-link  to="/users/sign_up" class="btn btn-outline-secondary">SIGN UP</router-link>
        </form>
      </b-nav>
    </b-collapse>
  </b-navbar>
</template>

<style lang="scss">
.form-inline {
  margin-top: 0;
}
</style>


<script>
export default {
  name: 'LandingNavbar',
  props: {
    sticky: {
      type: Boolean,
      default: false,
    },
  },
};
</script>