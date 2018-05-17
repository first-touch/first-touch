<template>
  <div>
    <div class="error" v-if="isfailed">
      Errors:
      <ul v-if="order.errors">
        <li v-for="error in order.errors.errors" :key="error.id">{{error}}</li>
      </ul>
    </div>
    <div class="custom-modal-content">
      <h5>Choose a Payment Method {{report.price.value}} {{report.price.currency | currency}} </h5>
      <form @submit.prevent :class="{isloading: 'loading'}">
        <div class="footer-modal buttons-inner">
          <button class="btn-primary ft-button" @click="startPayment">PAY NOW</button>
        </div>
      </form>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
form {
  border: 1px solid $secondary-header-color;
  padding: 20px;
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
import { ASYNC_SUCCESS, ASYNC_LOADING, ASYNC_FAIL } from 'app/constants/AsyncStatus';

export default {
  name: 'PaymentPopup',
  props: ['report', 'closeAction', 'paymentAction', 'order'],
  data () {
    return {
      payment_method: '',
      name: '',
      credit_card: '',
      cvv: '',
      expiry: '',
      isloading: false,
      isfailed: false
    };
  },
  watch: {
    order () {
      this.isloading = this.order.status === ASYNC_LOADING;
      this.isfailed = this.order.status === ASYNC_FAIL;
      if (this.order.status === ASYNC_SUCCESS) {
        this.$router.push({ name: 'clubReport', params: { id: this.report.id }})
      }
    }
  },
  methods: {
    startPayment () {
      var payment_method = this.payment_method;
      var name = this.name;
      var credit_card = this.credit_card;
      var cvv = this.cvv;
      var expiry = this.expiry;
      var report_id = this.report.id;
      this.paymentAction({
        payment_method,
        name,
        credit_card,
        cvv,
        expiry,
        report_id
      });
    }
  }
};
</script>
