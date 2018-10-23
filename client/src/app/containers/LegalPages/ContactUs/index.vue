<template>
  <div>
    <landing-navbar sticky />
    <div class="container-fluid">
      <div class="row">
        <div class="col-12 col-lg-2 no-padding">
          <legal-verticaltab sticky/>
        </div>
        <div class="col-12 col-lg-8 legal-content">
          <div class="row no-padding">
            <div class="js-toc-content col-12 px-lg-5">
              <h1 class="title">Contact Us</h1>

              <div class="legal-content-body">
                <h2 class="section-title" id="4">Got a question about FirstTouch?</h2>
                <hr class="section-separator" />
                <p class="subsection-title">
                  The FirstTouch support team is available 24/7 by email
                </p>
                <p class="section-text">
                  <button class="a-bar-button contact-us-button"> <a class="contact-us-link" href="mailTo:contact@firsttouch.io">Talk to us!</a> </button>
                </p>
              </div>


            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
  @import '~stylesheets/toc_overrides';
</style>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  @import '~stylesheets/common_style';
  @import '/tocbot/dist/tocbot.css';
  @import '/tocbot/dist/styles.css';
  @import '~stylesheets/tcpage';
</style>

<script>
  import tocbot from 'tocbot/dist/tocbot'
  import LandingNavbar from 'app/components/LandingNavbar';
  import LegalVerticalTab from 'app/containers/LegalPages/components/LegalVerticalTab';
  export default {
    name: 'ContactUs',
    components: {
      'landing-navbar': LandingNavbar,
      'legal-verticaltab': LegalVerticalTab,
    },
    mounted() {
      tocbot.init({
        // Where to render the table of contents.
        tocSelector: '.js-toc',
        // Where to grab the headings to build the table of contents.
        contentSelector: '.js-toc-content',
        // Which headings to grab inside of the contentSelector element.
        headingSelector: 'h2, h3',
      });
    }
  };
</script>
