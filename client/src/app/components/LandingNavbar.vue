<template>
  <nav id="landing-navbar" class="navbar navbar-expand-lg bg-dark sticky-top">
    <router-link to="/" class="navbar-brand">
      <img class="img-fluid" src="/images/landing-page/ft-navbar-logo.png" alt="Ft Logo" />
    </router-link>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav navbar-right ml-auto">
        <li class="nav-item">
          <router-link class="nav-link" to="/about">About</router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link" to="/users/sign_up">Sign Up</router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link" to="/users/sign_in">Login</router-link>
        </li>
      </ul>
    </div>
  </nav>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  li a.router-link-exact-active.router-link-active, a[aria-expanded="true"] {
    color: $main-header-color;
  }
</style>

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
