<template>
  <div>
    <div ref="card"></div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
</style>

<script>
  import {
    ASYNC_SUCCESS,
    ASYNC_LOADING,
    ASYNC_FAIL
  } from 'app/constants/AsyncStatus';
  import {
    StripePublicKey
  } from 'app/constants/StripeConstant';
  import Loading from 'app/components/Loading';

  export default {
    name: 'PaymentPopup',
    props: [
      'stripeJs',
    ],
    components: {
      loading: Loading
    },
    data() {
      return {
        isfailed: false,
        card: null
      };
    },
    computed: {
      elements() {
        return this.stripeJs.elements();
      },
    },
    mounted: function () {
      this.card = this.elements.create('card');
      this.card.mount(this.$refs.card);
    }
  };
</script>
