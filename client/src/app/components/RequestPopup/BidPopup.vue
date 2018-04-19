<template>
  <div class="bid col-md-6">
    <span class="field row">
      <span class="col-md-12">Bid price in {{ request.price.currency }}</span>
      <input class="col-sm-12 form-control" type="number" v-model="price" />
    </span>
    <span class="footer-modal buttons-inner">
      <button class="btn-primary ft-button" @click="newBid(request,price)">Send Bid</button>
      <button class="btn-primary ft-button" @click="newBid(request,price)">Update Bid</button>
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
        price: ''
      }
    },
    mounted() {
      this.price = this.request.price.value;
      if (this.request.request_bids)
        this.price = this.request.request_bids.price
    }
  };
</script>
