<template>
  <div class="bid col-md-12">
    <span class="field row">
      <currencyinput :value="price" :currency="request.price.currency"/>
    </span>
    <span class="footer-modal buttons-inner clo-md-12">
      <button class="ft-button ft-button-success ft-button-right" v-if="!this.request.bid_status" @click="newBid(request,price)">Send Bid</button>
      <button class="ft-button ft-button-success ft-button-right" v-if="this.request.bid_status" @click="newBid(request,price)">Update Bid</button>
      <button class="ft-button" @click="close(request)">Close</button>

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
    props: ['request', 'newBid','close'],
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
    }
  };
</script>
