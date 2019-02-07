<template>
  <div class="wrapper">
    <mobile-navbar></mobile-navbar>
    <flash-message outerClass="col-lg-4 m-feedback"></flash-message>
    <router-view class="main-content-wrapper"></router-view>
  </div>
</template>

<script>
  import MobileNavbar from 'app/components/UserLayout/components/MobileNavbar';
  import SearchBar from '../SearchBar';

  export default {
    name: 'UserMobileLayout',
    components: {
      'mobile-navbar': MobileNavbar,
      'search-bar': SearchBar
    }
  };
</script>
