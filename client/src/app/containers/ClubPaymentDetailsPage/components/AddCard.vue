<template>
  <div>
    <div class="error" v-if="failed">
      Errors:
      <ul v-if="serverErrors">
        <li>{{serverErrors}}</li>
      </ul>
    </div>
    <div class="contentPayment" :class="loading ? 'loading' : ''">
      <loading class="loader" />
      <div class="payment" v-if="!success">
        <cardinput ref="cardInput" :stripeJs="stripeJs" />
        <div class="buttons-inner">
          <button class="ft-button ft-button-success" v-on:click="getStripeToken">Add Card</button>
          <button class="ft-button ft-button-right" @click="closeAction()">Close</button>
        </div>
      </div>
      <div v-if="success">
        <p>Success !</p>
        <div class="col-lg-12 buttons-inner">
          <button class="ft-button-success ft-button-right" @click="closeAction()">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>
<style lang="scss">
  @import '~stylesheets/modal';
  @import '~stylesheets/form';


</style>
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
  import CardInput from 'app/components/Stripe/CardInput.vue';
  import Loading from 'app/components/Loading';
  import {
    ASYNC_SUCCESS,
    ASYNC_LOADING,
    ASYNC_FAIL
  } from 'app/constants/AsyncStatus';
  export default {
    name: 'AddCard',
    props: ['saveCard', 'closeAction', 'result', 'StripeCardToken', 'stripePayment', 'stripeJs'],
    components: {
      loading: Loading,
      cardinput: CardInput
    },
    watch: {
      stripePayment() {
        if (this.stripePayment.status == ASYNC_SUCCESS) {
          this.saveCard(this.token);
        }
      }
    },
    computed: {
      loading() {
        return this.result.status === ASYNC_LOADING || this.stripePayment.status === ASYNC_LOADING;
      },
      success() {
        return this.result.status === ASYNC_SUCCESS && this.stripePayment.status === ASYNC_SUCCESS;
      },
      failed() {
        return this.result.status === ASYNC_FAIL || this.stripePayment.status === ASYNC_FAIL;
      },
      token() {
        return (this.stripePayment.value.token.id)
      },
      serverErrors() {
        if (this.result.status === ASYNC_FAIL)
          return this.result.errors.errors;
        return (this.stripePayment.status === ASYNC_FAIL ? this.stripePayment.errors : null);
      }
    },
    methods: {
      getStripeToken() {
        this.StripeCardToken(this.$refs.cardInput.card);
      }
    }
  }
</script>
