<template>
  <div>
    <div class="custom-modal-content">
      <form @submit.prevent :class="{isloading: 'loading'}" class="ft-form col-md-6">
        <fieldset class="form-group col-md-12 filter">
          <label class="col-sm-4">Bid price in {{ request.price.currency }}</label>
          <input class="col-sm-2 forn-control" type="number" v-model="price" />
        </fieldset>
        <div class="footer-modal buttons-inner">
          <button class="btn-primary ft-button" @click="newBid(request,price)">Bid</button>
        </div>
      </form>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
@import '~stylesheets/form';

</style>

<script>
import { ASYNC_SUCCESS, ASYNC_LOADING, ASYNC_FAIL } from 'app/constants/AsyncStatus';

export default {
  name: 'PaymentPopup',
  props: ['request', 'newBid'],
  data() {
    return({
      price: this.request.price.value
    })
  }
};
</script>
