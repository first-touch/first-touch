<template>
  <div class="wrapper ft-item">
    <div class="header-wrapper col-md-12">
      <div class="header col-md-12 row">
        <div class="col-md-4 header-title">
          <h5 class="title">Cancel Report Request</h5>
          <p class="id">{{request.id | requestId(request.type_request) }}</p>
        </div>
        <div class="col-md-8 buttons-inner">
          <button class="ft-button ft-button-right" @click="closeAction(request)">Close
            <span v-if="success">✓</span>
          </button>
        </div>
      </div>
    </div>
    <div class="content-wrapper">
      <div class="content col-md-12">
        <div class="img-container">
          <img class="img-fluid avatar" src="/images/landing-page/ft-icons-player.png" />
          <p class="price" v-if="!position">
            <span>Bid Price {{request.bid_price.value}} {{request.bid_price.currency | currency}}</span>
          </p>
        </div>
        <div class="info col-md-8" v-if="!success">
          <div v-if="errors">
            <ul class="error">
              <li v-for="error in errors.errors" :key="error.id" v-if="errors.errors.isArray">
                {{error}}
              </li>
              <li v-if="!errors.errors.isArray">
                {{errors.errors}}
              </li>
            </ul>
          </div>
          <div class="row col-md-12">
            <label class="col-md-12">Cancelation Reason</label>
            <textarea class="col-md-12" v-model="reason"></textarea>
          </div>
          <div class="row col-md-12" v-if="!position">
            <label class="col-md-12">Attachments</label>
            <input type="file" multiple>
          </div>
          <hr/>
          <div class="col-md-12 buttons-inner">
            <button class="ft-button ft-button-right" @click="cancel">Cancel Report</button>
          </div>
        </div>
        <div v-if="success">
          <h3 v-if="!position">
            Bid Canceled
          </h3>
          <h3 v-if="position">
            Removed from job list
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
        reason: '',
        start: false
      };
    },
    computed: {
      position() {
        if (this.request.type_request == 'position')
          return true;
        return false;
      },
      errors() {
        if (this.bid.errors) return this.bid.errors;
        return null;
      },
      success() {
        if (this.bid.value && this.start)
          return true;
        return false;
      }
    },
    methods: {
      cancel() {
        this.start = true;
        this.cancelReport({
          reason: this.reason
        })
      }
    }
  };
</script>
