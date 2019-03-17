<template>
  <div class="wrapper">
    <mobile-navbar></mobile-navbar>
    <flash-message outerClass="col-lg-4 m-feedback"></flash-message>
    <router-view class="main-content-wrapper"></router-view>
    <ft-footer />
  </div>
</template>

<script>
  import MobileNavbar from './components/MobileNavbar';
  import Footer from 'app/components/Footer';

  export default {
    name: 'UserMobileLayout',
    components: {
      'mobile-navbar': MobileNavbar,
      'ft-footer': Footer
    }
  };
</script>
