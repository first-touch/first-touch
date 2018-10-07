<template>
  <div id="legal-verticaltab">
    <div class="d-block d-lg-none menu-btn">
      <button aria-controls="#menu-contents" aria-expanded="false">MENU</button>
    </div>
    <ul class="nav flex-column">
      <div id="menu-contents" class="collapse navbar-collapse show mt-2 d-lg-block">
        <div class="contents-vertical-tab d-block" id="navbar-contents">
          <article class="card vertical-tab">
            <div class="section-separator"></div>
            <li class="nav-item">
              <router-link class="nav-link vertSideItem" to="/terms_conditions">User Agreement</router-link>
            </li>
            <div class="section-separator"></div>
            <li class="nav-item">
              <router-link class="nav-link vertSideItem" to="/community_guidelines">Community Guidelines</router-link>
            </li>
            <div class="section-separator"></div>
            <li class="nav-item">
              <router-link class="nav-link vertSideItem" to="/privacy_policy">Privacy Policy</router-link>
            </li>
            <div class="section-separator"></div>
            <li class="nav-item">
              <router-link class="nav-link vertSideItem" to="/contact_us">Contact Us</router-link>
            </li>
            <div class="section-separator"></div>
          </article>
        </div>
      </div>
    </ul>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables.scss';

  .menu-btn>.btn-secondary,
  .menu-btn>.btn-secondary:active,
  .menu-btn>.btn-secondary:focus,
  .menu-btn>.btn-secondary:not([disabled]):not(.disabled).active,
  .btn-secondary:not([disabled]):not(.disabled):active,
  .show>.btn-secondary.dropdown-toggle {
    background: $background-color;
    color: $main-text-color;
    margin: 1em;
  }

  #legal-verticaltab {
    background: $background-color;
    top: 0;
    position: sticky;
    position: -webkit-sticky;
    .card-body {
      padding: 0.7em;
    }
    .vertical-tab {
      background: $background-color;
      padding-top: 9em;
      border: 0;
      height: 100vh;
    }
    .vertSideItem {
      margin-bottom: 0.5em;
      margin-top: 0.5em;
      color: $main-text-color;
      text-transform: uppercase;
      font-weight: 100;
    }
    .contents-vertical-tab .router-link-active {
      border-left: 2px solid #A8CB5C;
      color: #A8CB5C;
    }
    .vertSideItem:hover {
      color: #A8CB5C;
    }
    .contents-vertical-tab .section-separator {
      border-bottom: 1px solid $main-text-color;
    }
  }


  @media(max-width: 992px) {
    #legal-verticaltab {
      .vertical-tab {
        padding-top: 0em;
        padding-bottom: 0.5em;
        height: auto;
      }
    }
  }
</style>

<script>
  export default {
    name: 'LegalVerticalTab',
    props: {
      sticky: {
        type: Boolean,
        default: false
      }
    }
  };
</script>
