<template>
<div id="legal-verticaltab">
    <div class="contents-vertical-tab">
        <b-nav vertical>
            <div class="section-separator"></div>
            <b-nav-item>
                <router-link to="/welcome" class="nav-link vertSideItem">About</router-link>
            </b-nav-item>
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
                <router-link class="nav-link vertSideItem" to="#">Help (Report a Problem)</router-link>
            </b-nav-item>
            <div class="section-separator"></div>
        </b-nav>
    </div>
</div>

</template>

<style>
    #legal-verticaltab {
        background: #343434;
        height: 100vh;
        top:0;
        position: sticky;
        padding-right: 1em;
        padding-top: 8em;
        padding-left: 1em;
    }
     .vertSideItem{
        margin-bottom: 0.5em;
        margin-top: 0.5em;
        color: #7F8081;
        text-transform: uppercase;
    }
    .contents-vertical-tab .router-link-active {
        /*code does not work*/
        border-left: 2px solid #A8CB5C;
        color: #A8CB5C;
    }
    .vertSideItem:hover {
        color: #A8CB5C;
    }
    .contents-vertical-tab .section-separator {
        border-bottom: 1px solid #7F8081;
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
