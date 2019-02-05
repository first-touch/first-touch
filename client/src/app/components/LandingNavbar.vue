<template>
  <nav id="landing-navbar" class="navbar navbar-expand-md sticky-top">
    <a class="navbar-brand" href="/">
      <img src="/images/landing-page/ft-navbar-logo.png" alt="Ft logo">
    </a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-nav" aria-controls="navbar-nav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbar-nav">
      <ul class="navbar-nav ml-auto list-unstyled">
        <li>
          <router-link to="/about">About</router-link>
        </li>
        <li>
          <router-link to="/users/sign_up">Sign Up</router-link>
        </li>
        <li>
          <router-link to="/users/sign_in">Login</router-link>
        </li>
      </ul>
    </div>
  </nav>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  // TODO: Duplicated with Mobile Navbar. Find a way to share the style
  #landing-navbar {
    ul {
      p {
        padding: 10px;
      }

      li a {
        padding: 10px;
        font-size: 1.1em;
        display: block;
        text-transform: uppercase;
      }

      li a:hover {
        background: $nav-hover-background;
        color: $secondary-text-color;
        text-decoration: none;
      }

      li a.router-link-exact-active.router-link-active, a[aria-expanded="true"] {
        color: $main-header-color;
      }
    }
  }

  @media screen and (max-width: 768px) {
    #landing-navbar {
     .navbar-brand {
      img {
        height: 40px;
        }
      }
    }
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
