<template>
  <div id="legal-verticaltab">
    <div class="d-block d-lg-none menu-btn">
      <b-btn v-b-toggle.menu-contents>MENU</b-btn>
    </div>
    <b-nav vertical>
      <b-collapse is-nav visible id="menu-contents" class="mt-2 d-lg-block">
        <div class="contents-vertical-tab d-block" id="navbar-contents">
          <b-card class="vertical-tab">
            <div class="section-separator"></div>
            <b-nav-item>
              <router-link class="nav-link vertSideItem" to="/terms_conditions">User Agreement</router-link>
            </b-nav-item>
            <div class="section-separator"></div>
            <b-nav-item>
              <router-link class="nav-link vertSideItem" to="/privacy_policy">Privacy Policy</router-link>
            </b-nav-item>
            <div class="section-separator"></div>
            <b-nav-item>
              <router-link class="nav-link vertSideItem" to="#">Contact Us</router-link>
            </b-nav-item>
            <div class="section-separator"></div>
          </b-card>
        </div>
      </b-collapse>
    </b-nav>
  </div>
</template>

<style lang="scss" scoped>
  .menu-btn>.btn-secondary,
  .menu-btn>.btn-secondary:active,
  .menu-btn>.btn-secondary:focus,
  .menu-btn>.btn-secondary:not([disabled]):not(.disabled).active,
  .btn-secondary:not([disabled]):not(.disabled):active,
  .show>.btn-secondary.dropdown-toggle {
    background: #343434;
    color: #7F8081;
    margin: 1em;
  }

  #legal-verticaltab {
    background: #343434;
    top: 0;
    position: sticky;
    position: -webkit-sticky;
    .card-body {
      padding: 0.7em;
    }
    .vertical-tab {
      background: #343434;
      padding-top: 9em;
      border: 0;
      height: 100vh;
    }
    .vertSideItem {
      margin-bottom: 0.5em;
      margin-top: 0.5em;
      color: #7F8081;
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
      border-bottom: 1px solid #7F8081;
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
