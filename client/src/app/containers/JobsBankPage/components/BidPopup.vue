<template>
  <div class="bid col-lg-12">

    <span class="field row">
      <p>Bid between {{request.price.value}} and {{request.price.max}} {{request.price.currency }}</p>
    </span>
    <span class="field row">
      <currencyinput :value="price" :currency="request.price.currency" />
      <input type="text" class="hide" name="price" v-model="price.value" v-validate="`required|between:${request.price.value},${request.price.max}` "
      />
      <span class="validate-errors">{{ errors.first('price') }}</span>

    </span>
    <span class="footer-modal buttons-inner col-md-12 row">
      <button class="ft-button ft-button-success ft-button-right" v-if="!this.request.bid_status" @click="submit">Send Bid</button>
      <button class="ft-button ft-button-success ft-button-right" v-if="this.request.bid_status" @click="submit">Update Bid</button>
      <button class="ft-button" @click="close(request)">Close</button>
    </span>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  @import '~stylesheets/form';
  .hide {
    display: none;
  }
  .validate-errors{
    color:red;
  }
</style>

<script>
  import CurrencyInput from 'app/components/Input/CurrencyInput';

  export default {
    name: 'PaymentPopup',
    props: ['request', 'newBid', 'close'],
    components: {
      currencyinput: CurrencyInput
    },
    data() {
      return {
        price: {
          value: 0,
          currency: 'USD'
        }
      }
    },
    mounted() {
      this.price.value = this.request.price.value;
      if (this.request.price.currency)
        this.price.currency = this.request.price.currency;
      if (this.request.bid_status)
        this.price = this.request.bid_price
    },
    methods: {
      submit() {
        this.$validator.validateAll().then(() => {
          if (this.errors.items.length == 0) {
            this.newBid(this.request, this.price)
          }
        }).catch(() => {

        });

      }
    }
  };
</script>
