<template>
  <div>
    <div class="error" v-if="isfailed">
      Errors:
      <ul v-if="result.errors">
        <li v-for="error in result.errors.errors" :key="error.id">{{error}}</li>
      </ul>
    </div>
    <div class="contentPayment" :class="loading ? 'loading' : ''">
      <loading class="loader" />
      <div class="payment">
        <div ref="card"></div>
        <div class="buttons-inner">
          <button class="ft-button-success" v-on:click="purchase">Purchase</button>
        </div>

      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  form {
    border: 1px solid $secondary-header-color;
    padding: 20px;
  }

  .buttons-inner {
    margin-top: 20px;
  }

  .contentPayment {
    padding: 50px 10px 20px 10px;
    .loader {
      display: none;
      margin-left: 40%;
    }
    &.loading {
      .loader {
        display: block;
      }
      .payment {
        display: none;
      }
    }
  }

  .error {
    color: red;
    ul {
      display: list-item;
      padding: 0 0 0 50px;
      li {
        display: list-item;
        list-style: disc;
      }
    }
  }
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
      'closeAction',
      'stripePayment',
      'StripeCardToken',
      'stripeJs',
      'paymentAction',
      'result'
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
    watch: {
      stripePayment() {
        if (this.stripePayment.status == ASYNC_SUCCESS) {
          this.paymentAction(this.token);
        }
      }
    },
    computed: {
      token() {
        return (this.stripePayment.value.token.id)
      },
      elements() {
        return this.stripeJs.elements();
      },
      loading() {
        return this.result.status === ASYNC_LOADING || this.stripePayment.status === ASYNC_LOADING;
      }
    },
    mounted: function () {
      this.card = this.elements.create('card');
      this.card.mount(this.$refs.card);
    },
    methods: {
      purchase: function () {
        this.StripeCardToken(this.card);
      }
    }
  };
</script>
