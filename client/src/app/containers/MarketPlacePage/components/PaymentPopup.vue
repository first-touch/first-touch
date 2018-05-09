<template>
  <div>
    <div class="error" v-if="isfailed">
      Errors:
      <ul v-if="order.errors">
        <li v-for="error in order.errors.errors" :key="error.id">{{error}}</li>
      </ul>
    </div>
    <div class="custom-modal-content">
      <div ref="card"></div>
      <div class="buttons-inner">
        <button class="ft-button-success" v-on:click="purchase">Purchase</button>

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

.custom-modal-content {
  padding: 50px 10px 20px 10px;
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
  export default {
    name: 'PaymentPopup',
    props: ['report', 'closeAction', 'stripePayment', 'StripeCardToken', 'order', 'newOrder', 'stripeJs'],
    data() {
      return {
        payment_method: '',
        name: '',
        credit_card: '',
        cvv: '',
        expiry: '',
        isloading: false,
        isfailed: false,
        card: null
      };
    },
    watch: {
      order() {
        this.isloading = this.order.status === ASYNC_LOADING;
        this.isfailed = this.order.status === ASYNC_FAIL;
        if (this.order.status === ASYNC_SUCCESS) {
          this.$router.push({
            name: 'clubReport',
            params: {
              id: this.report.id
            }
          });
        }
      },
      stripePayment() {
        if (this.stripePayment.status == ASYNC_SUCCESS) {
          this.newOrder({
            token : this.stripePayment.value.token.id,
            report_id : this.report.id
          })
        }
      }
    },
    computed: {
      elements(){
        return this.stripeJs.elements();
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
