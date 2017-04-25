<template>
  <b-navbar toggleable class="sticky-top navbar-inverse bg-inverse" id="landing-navbar">
    <b-nav-toggle target="ft-nav-collapse" />
    <a class="navbar-brand" to="/">
      <img src="/images/landing-page/ft-navbar-logo.png" alt="Ft logo">
    </a>
    <b-collapse isNav id="ft-nav-collapse">
      <b-nav class="ml-auto">
        <li class="nav-item">
          <a href="#" class="nav-link">Change Language</a>
        </li>
        <li class="nav-item">
          <a href="/users/sign_in" class="nav-link">Sign In</a>
        </li>
        <form class="form-inline">
          <a class="btn btn-outline-secondary" href="/users/sign_up">SIGN UP</a>
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