<template>
  <!-- Footer -->
  <footer class="page-footer font-small">
    <div class="footer-separator">
      <div class="container">
        <!-- Grid row-->
        <div class="row py-4 d-flex align-items-center">
          <!-- Grid column -->
          <div class="col-md-6 col-lg-5 text-center text-md-left mb-4 mb-md-0">
            <h6 class="mb-0">Get connected with us on social networks!</h6>
          </div>
          <!-- Grid column -->

          <!-- Grid column -->
          <div class="col-md-6 col-lg-7 text-center text-md-right">
            <!-- Facebook -->
            <a class="fb-ic">
              <i class="fab fa-facebook-f white-text mr-4"> </i>
            </a>
            <!-- Twitter -->
            <a class="tw-ic">
              <i class="fab fa-twitter white-text mr-4"> </i>
            </a>
            <!--Linkedin -->
            <a class="li-ic">
              <i class="fab fa-linkedin-in white-text mr-4"> </i>
            </a>
            <!--Instagram-->
            <a class="ins-ic">
              <i class="fab fa-instagram white-text"> </i>
            </a>
          </div>
          <!-- Grid column -->
        </div>
        <!-- Grid row-->
      </div>
    </div>

    <!-- Footer Links -->
    <div class="container text-center text-md-left mt-5">
      <div class="row mt-3">
        <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4">
          <!-- Links -->
          <h6 class="text-uppercase font-weight-bold">First Touch</h6>
          <hr class="deep-purple accent-2 mb-4 mt-0 d-inline-block mx-auto" style="width: 60px;">
          <p>
            <i class="fas fa-home mr-3"></i> 292 Main Street, Gibraltar, GX11 1AA </p>
          <p>
            <i class="fas fa-envelope mr-3"></i> contact@firsttouch.io </p>
        </div>

        <!-- Grid column -->
        <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4">
          <!-- Links -->
          <h6 class="text-uppercase font-weight-bold">Useful Links</h6>
          <hr class="deep-purple accent-2 mb-4 mt-0 d-inline-block mx-auto" style="width: 60px;">
          <p>
            <router-link class="a-link dark" to="/contact_us">User Agreement</router-link>
          </p>
          <p>
            <router-link class="a-link dark" to="/community_guidelines">Community Guidelines</router-link>
          </p>
          <p>
            <router-link class="a-link dark" to="/privacy_policy">Privacy Policy</router-link>
          </p>
          <p>
            <router-link class="a-link dark" to="/contact_us">Contact Us</router-link>
          </p>
        </div>
        <!-- Grid column -->
      </div>
      <!-- Grid row -->
    </div>
    <!-- Footer Links -->

    <!-- Copyright -->
    <div class="footer-copyright text-center py-3">© 2019 Copyright:
      <a class="a-link dark" href="https://firsttouch.io"> FirstTouch.io</a>
    </div>
    <!-- Copyright -->
  </footer>
  <!-- Footer -->
</template>

<style lang="scss" scoped>
  .footer-separator {
    background-color: #343434;
  }
</style>


<script>
export default {
  name: 'Footer'
}
</script>
