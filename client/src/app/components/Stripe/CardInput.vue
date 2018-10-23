<template>
  <div>
    <div ref="card" class="form-control m-field-input"></div>
    <div class="img-container col-lg-4">
      <img class="img-fluid" src="/images/stripe/secure-stripe-payment-logo.png" alt="Stripe secure" />
    </div>
    <p>All payments are governed by the FirstTouch Terms & Conditions and Payment Policy.
          <a href="https://stripe.com/mx/connect-account/legal">By Adding a card, you agree to the stripe agreements </a>
    </p>

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
