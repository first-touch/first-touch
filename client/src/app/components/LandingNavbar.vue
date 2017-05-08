<template>
  <b-navbar toggleable class="sticky-top navbar-inverse bg-inverse" id="landing-navbar">
    <b-nav-toggle target="ft-nav-collapse" />
    <router-link class="navbar-brand" to="/">
      <img src="/images/landing-page/ft-navbar-logo.png" alt="Ft logo">
    </router-link>
    <b-collapse isNav id="ft-nav-collapse">
      <b-nav class="ml-auto">
        <li class="nav-item">
          <router-link to="#" class="nav-link">Change Language</router-link>
        </li>
        <li class="nav-item">
          <router-link to="/users/sign_in" class="nav-link">Sign In</router-link>
        </li>
        <form class="form-inline">
          <router-link  to="/users/sign_up" class="btn btn-outline-secondary">SIGN UP</router-link>
        </form>
      </b-nav>
    </b-collapse>
  </b-navbar>
</template>

<script>
  export default {
    name: 'LandingNavbar',
  }
</script>