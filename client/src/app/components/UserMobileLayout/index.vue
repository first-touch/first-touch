<template>
  <div class="wrapper">
    <mobile-navbar></mobile-navbar>
    <router-view></router-view>
  </div>
</template>

<style lang="scss" scoped>
  .wrapper {
    display: flex;
    width: 100%;
    align-items: stretch;
  }
</style>

<script>
  import MobileNavbar from 'app/components/UserLayout/components/MobileNavbar';

  export default {
    name: 'UserMobileLayout',
    components: {
      'mobile-navbar': MobileNavbar
    }
  };
</script>
