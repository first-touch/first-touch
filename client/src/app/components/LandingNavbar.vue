<template>
  <b-navbar toggleable="md" variant="" type="" :sticky="sticky" id="landing-navbar">
    <b-nav-toggle target="ft-nav-collapse" />
    <router-link class="navbar-brand" to="/">
      <img src="/images/landing-page/ft_logo_navbar.png" alt="Ft logo">
    </router-link>
    <b-collapse isNav id="ft-nav-collapse">
      <b-nav class="ml-auto navOptions">
        <b-nav-item>
          <a href="/about" class="nav-link">ABOUT</a>
        </b-nav-item>
        <form class="form-inline">
          <router-link  to="/users/sign_up" class="btn btn-outline-secondary">SIGN UP</router-link>
        </form>
         <b-nav-item>
          <router-link to="/users/sign_in" class="nav-link">LOG IN</router-link>
        </b-nav-item>
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
