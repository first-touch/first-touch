<template>
  <nav class="navbar sticky-top navbar-expand-lg navbar-dark bg-dark" id="landing-navbar">
    <div class="d-flex flex-grow-1">
      <span class="w-100 d-lg-none d-block"><!-- hidden spacer to center brand on mobile --></span>
        <a class="navbar-brand d-none d-lg-inline-block" href="/">
          <img src="/images/landing-page/ft-navbar-logo.png" height="50" alt="Ft logo">
        </a>
        <a class="navbar-brand-two mx-auto d-lg-none d-inline-block" href="/">
          <img src="/images/landing-page/ft-navbar-logo.png" height="50" alt="Ft logo">
        </a>
        <div class="w-100 text-right">
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#myNavbar">
            <span class="navbar-toggler-icon"></span>
          </button>
        </div>
    </div>
    <div class="collapse navbar-collapse flex-grow-1 text-right" id="myNavbar">
      <ul class="navbar-nav ml-auto flex-nowrap">
        <li class="nav-item">
          <a href="/about" class="nav-link m-2 menu-item nav-active">About</a>
        </li>
        <li class="nav-item">
          <a href="/users/sign_up" class="nav-link m-2 menu-item btn btn-outline-secondary">Sign Up</a>
        </li>
        <li class="nav-item">
          <a href="/users/sign_in" class="nav-link m-2 menu-item">Log In</a>
        </li>
      </ul>
    </div>
  </nav>
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
