<template>
  <div class="ft-search-widget widget-reports col col-md-12">
    <div class="row">
      <div class="col-md-2">
        <h6 class="list-title">Bids</h6>
        <h1 class="list-count">{{bids ? bids.bid.length: '0'}}</h1>
      </div>
      <form @submit.prevent="search" class="col-md-10">
        <div class="row">
          <fieldset class="col-md-6">
            <currencyinput :value="price" max="true" :currency="currency" />
          </fieldset>
          <ftdatepicker class="col-md-3 form-control" :value="params.created_date" v-on:update:val="params.created_date = $event; search()"
          />
        </div>
      </form>
      <div class="ft-form-result ft-bids-result col-md-12" v-if="bids">
        <div v-for="bid in bids.bid " :key="bid.key" class="result col-md-5 ft-bid ft-item">
          <div class="content-wrapper">
            <div class="content col-md-12">
              <div class="img-container col-md-4">
                <img class="img-fluid avatar" src="https://unsplash.it/100/100" />
              </div>
              <div class="info col-md-8">
                <h2 class="title">
                  <span class="target">
                    <router-link :to="{ name: 'userProfilePage', params: { id: bid.user.id }}" target="_blank">{{bid.user.first_name}} {{bid.user.last_name}}</router-link>
                  </span>
                </h2>
                <h5 class="price">
                  {{bid.price.value}} {{bid.price.currency}}
                </h5>
              </div>
            </div>
          </div>
          <div class="buttons-inner">
            <button class="ft-button" @click="acceptAction(bid)">Accept Bid</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<style lang="scss">
@import '~stylesheets/variables';
@import '~stylesheets/form';
</style>

<style lang="scss" scoped>
@import '~stylesheets/variables';
@import '~stylesheets/search';
.ft-bids-result {
  display: flex;
  flex-wrap: wrap;
  .ft-bid {
    padding: 20px;
    border: 2px solid $main-text-color;
    border-radius: 10px;
    margin: 20px;
    display: inline-block;
    margin: 10px 0 0 2%;
    flex-grow: 1;
    .content {
      display: flex;
    }
    .avatar {
      height: 100px;
      border-radius: 50%;
    }
    .info {
      display: flex;
      flex-direction: column;
      .title {
        a {
          color: $main-header-color;
          font-size: 1.5rem;
          letter-spacing: 2px;
        }
      }
      .price {
        margin-top: auto;
      }
    }
    .buttons-inner {
      display: flex;
      flex-direction: column-reverse;
      button {
        margin-left: auto;
      }
    }
  }
}
</style>
<script>
import CurrencyInput from 'app/components/Input/CurrencyInput';
import FtDatepicker from 'app/components/Input/FtDatepicker';

export default {
  name: 'Bids',
  props: ['bids', 'currency', 'getBids', 'acceptAction'],
  components: {
    currencyinput: CurrencyInput,
    ftdatepicker: FtDatepicker
  },
  data() {
    return {
      price: {
        value: 0,
        currency: 'USD',
        max: 0
      },
      params: {
        created_date: '',
        price_min: '',
        price_max: ''
      }
    };
  },
  computed: {
    url() {
      var params = this.params;
      params.price_min = this.price.value;
      params.price_max = this.price.max;
      return Object.keys(params)
        .map(function(k) {
          return encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);
        })
        .join('&');
    }
  },
  methods: {
    search() {
      this.getBids(this.url);
    }
  }
};
</script>
