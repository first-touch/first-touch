<template>
  <div class="bid col-lg-12">
    <span class="field row">
      <p>The club is willing to pay up to {{ maxBidValue }} {{ requestCurrency }}</p>
    </span>
    <span class="field row">
      <currencyinput v-model="bidData" />
      <input type="text" class="d-none" name="price" v-model="bidData.value" v-validate="`required|max_value:${maxBidValue}`" />
      <span class="text-danger">{{ errors.first('price') }}</span>
    </span>
    <span class="footer-modal row">
      <div class="col" v-if="!this.currentBid">
        <button class="btn btn-primary float-right" @click="submit">Send Bid</button>
      </div>
      <div class="col" v-if="this.currentBid">
        <button class="btn btn-primary float-right" @click="submit">Update Bid</button>
      </div>
    </span>
  </div>
</template>

<script>
  import CurrencyInput from 'app/components/Input/CurrencyInput';

  export default {
    name: 'BidPopup',
    props: ['request', 'currentBid'],
    components: {
      currencyinput: CurrencyInput
    },
    data() {
      return {
        bidData: {
          value: 0,
          currency: 'USD'
        }
      }
    },
    watch: {
      // NOTE: Update the bidData currency to match request's currency
      request() {
        if (this.request == null) return;
        this.bidData.currency = this.request.price.currency;
      },
      // NOTE: Update the bidData value to match current bid's value
      currentBid() {
        console.log(this.currentBid);
        if (this.currentBid == null) return;
        this.bidData.value = this.currentBid.price.value;
      }
    },
    computed: {
      // NOTE: getter for request's price metadata
      // (should include: min, max and currency)
      requestPrice() {
        if (this.request == null) return;
        return this.request.price;
      },
      // NOTE: getter for request's max price metadata
      maxBidValue() {
        if (this.request == null) return 0;
        console.log(this.requestPrice.max);
        return this.requestPrice.max;
      },
      requestCurrency() {
        if (this.requestPrice == null) return 'N/A';
        return this.requestPrice.currency;
      },
    },
    methods: {
      submit() {
        this.$validator.validateAll().then(() => {
          if (this.errors.items.length == 0) {
            this.$emit('submit-bid', this.bidData);
            // this.newBid(this.request, this.price)
          }
        });
      }
    }
  };
</script>
