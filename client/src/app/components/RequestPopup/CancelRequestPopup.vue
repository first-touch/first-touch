<template>
  <div class="wrapper ft-item">
    <div class="header-wrapper col-md-12">
      <div class="header col-md-12 row">
        <div class="col-md-4 header-title">
          <h5 class="title">Cancel Report Request</h5>
          <p class="id">{{request.id | requestId(request.type_request) }}</p>
        </div>
        <div class="col-md-8 buttons-inner">
          <button class="ft-button" @click="closeAction(request)">Close <span v-if="success">✓</span></button>
        </div>
      </div>
    </div>
    <div class="content-wrapper">
      <div class="content col-md-12">
        <div class="img-container">
          <img class="img-fluid avatar" src="/images/landing-page/ft-icons-player.png" />
          <p class="price">
            <span>Bid Price {{request.bid_price.value}} {{request.bid_price.currency | currency}}</span>
          </p>
        </div>
        <div class="info col-md-8" v-if="!success">
          <div v-if="errors">
            <ul class="error">
              <li v-for="error in errors.errors" :key="error.id">
                {{error}}
              </li>
            </ul>
          </div>
          <div class="row col-md-12">
            <label class="col-md-12">Cancelation Reason</label>
            <textarea class="col-md-12"  v-model="reason"></textarea>
          </div>
            <div class="row col-md-12">
            <label class="col-md-12">Attachments</label>
            <input type="file" multiple>
          </div>
          <hr/>
          <div class="col-md-8 buttons-inner">
            <button class="ft-button" @click="cancelReport({reason})">Cancel Report</button>
          </div>
        </div>
        <div v-if="success">
          <h3>
            Bid Canceled
          </h3>
        </div>
      </div>
    </div>
  </div>
</template>
<style lang="scss">
@import '~stylesheets/variables';
</style>

<style lang="scss" scoped>
@import '~stylesheets/item';
</style>
<script>
import countrydata from 'country-data';

export default {
  name: 'CancelRequestPopup',
  props: ['request', 'closeAction', 'cancelReport', 'bid'],
  data() {
    return {
      reason: ''
    };
  },
  computed: {
    errors() {
      if (this.bid.errors) return this.bid.errors;
      return null;
    },
    success() {
      if (this.bid.value) if (this.bid.value.status == 'canceled') return true;
      return false;
    }
  }
};
</script>
