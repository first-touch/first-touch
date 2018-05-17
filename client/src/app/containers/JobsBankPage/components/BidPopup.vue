<template>
  <div class="bid col-md-6">
    <span class="field row">
      <currencyinput :value="price" :currency="request.price.currency"/>
    </span>
    <span class="footer-modal buttons-inner">
      <button class="btn-primary ft-button" v-if="!this.request.request_bids" @click="newBid(request,price)">Send Bid</button>
      <button class="btn-primary ft-button" v-if="this.request.request_bids" @click="newBid(request,price)">Update Bid</button>
    </span>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  @import '~stylesheets/form';
</style>

<script>
  import CurrencyInput from 'app/components/Input/CurrencyInput';

  export default {
    name: 'PaymentPopup',
    props: ['request', 'newBid'],
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
      if (this.request.request_bids)
        this.price = this.request.request_bids.price
    }
  };
</script>
