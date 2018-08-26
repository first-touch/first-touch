<template>
  <b-navbar toggleable="md" variant="" type="" :sticky="sticky" id="landing-navbar">
    <b-nav-toggle target="ft-nav-collapse" />
      <a href="/welcome" class="navbar-brand">
        <img src="/images/landing-page/ft-logo-content-slide.png" alt="Ft logo">
      </a>
    <b-collapse isNav id="ft-nav-collapse">
      <b-nav class="ml-auto navOptions">
        <b-nav-item>
          <router-link to="/">ABOUT</router-link>
        </b-nav-item>
        <form class="form-inline nav-link">
          <router-link  to="/users/sign_up" class="btn btn-outline-secondary">SIGN UP</router-link>
        </form>
         <b-nav-item>
          <router-link to="/users/sign_in">LOG IN</router-link>
        </b-nav-item>
      </b-nav>
    </b-collapse>
  </b-navbar>
</template>

<script>
export default {
  name: 'LandingNavbar',
  props: {
    sticky: {
      type: Boolean,
      default: false
    }
  }
};
</script>
