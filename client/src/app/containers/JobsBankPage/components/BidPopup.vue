<template>
  <div class="bid col-lg-12">
    <span class="field row">
      <p>The club is willing to pay up to {{ maxBidValue }} {{ bidCurrency }}</p>
    </span>
    <span class="field row">
      <currencyinput v-model="price" :currency="price.currency" />
      <input type="text" class="d-none" name="price" v-model="price.value" v-validate="`required|max_value:${maxBidValue}` "/>
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
        price: {
          value: 0,
          currency: 'USD'
        }
      }
    },
    mounted() {
      this.prepare();
    },
    watch: {
      request() {
        this.prepare();
      }
    },
    computed: {
      requestPrice() {
        if (this.request != null) {
          return this.request.price;
        } else {
          return null;
        }
      },
      minBidValue() {
        if(this.requestPrice != null) {
          return this.requestPrice.value;
        } else {
          return 0;
        }
      },
      maxBidValue() {
        if(this.requestPrice != null) {
          return this.requestPrice.max;
        } else {
          return 0;
        }
      },
      bidCurrency() {
        if(this.requestPrice != null) {
          return this.requestPrice.currency;
        } else {
          return 'N/A';
        }
      },
    },
    methods: {
      submit() {
        this.$validator.validateAll().then(() => {
          if (this.errors.items.length == 0) {
            this.$emit('submit-bid', this.price);
            // this.newBid(this.request, this.price)
          }
        });
      },
      prepare() {
        if (this.request) {
          this.price.value = this.request.price.value;
          if (this.request.price.currency)
            this.price.currency = this.request.price.currency;
          if (this.currentBid)
            this.price = this.currentBid.price;
        }
      }
    }
  };
</script>
