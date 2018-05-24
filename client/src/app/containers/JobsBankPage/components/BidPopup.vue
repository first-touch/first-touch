<template>
  <div class="bid col-md-6">
    <span class="field row">
      <span class="col-md-12">Bid price in {{ request.price.currency }}</span>
      <input class="col-sm-12 form-control" type="number" v-model="price.value" />
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
  import {
    ASYNC_SUCCESS,
    ASYNC_LOADING,
    ASYNC_FAIL
  } from 'app/constants/AsyncStatus';

  export default {
    name: 'PaymentPopup',
    props: ['request', 'newBid'],
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
