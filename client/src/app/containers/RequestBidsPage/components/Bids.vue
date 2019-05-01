<template>
  <div class="ft-search-widget widget-reports ft-form col col-lg-12">
    <div class="row">
      <form @submit.prevent="search" class="col-lg-12">
        <div class="search-count row">
          <p class="col-lg-2 col-md-5">Bids Count </p>
          <p class="number col-lg-6">{{bids ? bids.bid.length: '0'}}</p>
          <input type="text" class="form-control col-lg-3" v-model="params.scout_name" placeholder="Type a Scout’s name…" @keyup="search()"
          />
        </div>
        <div class="row line">
          <p class="col-lg-12">
            Currently Displaying:</p>
          <div class="col-lg-5">
            <p>Price from</p>
            <currencyinput :value="price" max="true" :currency="price.currency" />
          </div>
          <div class="col-lg-5 calendar-container">
            <p class="col-lg-12">Submitted from</p>
            <div class="col-lg-12 row">
              <ftdatepicker class="col-lg-6 form-control" :value="params.created_date_from" v-on:update:val="params.created_date_from = $event"
                hideChooseIcon="true" placeholder="Date" />
              <ftdatepicker class="col-lg-6 form-control" :value="params.created_date_to" v-on:update:val="params.created_date_to = $event"
                hideChooseIcon="true" placeholder="Date" /> </div>
          </div>
        </div>
        <!-- <div class="col-lg-12">
          <div class="col-lg-10 row">
            <label class="col-lg-8">Bid From</label>
            <label class="col-lg-4">To</label>
            <currencyinput :value="price" max="true" :currency="price.currency" />
          </div>
          <div class="col-lg-10 row">
            <label class="col-lg-8">Submitted From</label>
            <label class="col-lg-4">To</label>
            <ftdatepicker class="col-lg-6 form-control" :value="params.created_date" v-on:update:val="params.created_date_from = $event"
            />
            <ftdatepicker class="col-lg-6 form-control" :value="params.created_date" v-on:update:val="params.created_date_to = $event"
            />
          </div>

        </div> -->
      </form>
      <table class="table table-search table-responsive-lg">
        <thead>
          <tr>
            <th scope="col" class="sortable" @click="setOrder('scout_name')">
              <p>Scout </p>
              <span v-if="params.order == 'scout_name'">
                <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
              </span>
            </th>
            <th scope="col" class="sortable" @click="setOrder('created_at')">
              <p>Submitted on</p>
              <span v-if="params.order == 'created_at'">
                <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
              </span>
            </th>
            <th scope="col" class="sortable" @click="setOrder('price')">
              <p>Bid ({{price.currency}})</p>
              <span v-if="params.order == 'price'">
                <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
              </span>
            </th>
            <th scope="col">Actions</th>
          </tr>
        </thead>
        <tbody v-if="bids">
          <tr v-for="bid in bids.bid " :key="bid.key">
            <td>
              <router-link :to="{ name: 'userProfilePage', params: { id: bid.user.id }}" target="_blank" v-if="bid">
                {{bid.user.first_name}} {{bid.user.last_name}}</router-link>
            </td>
            <td>{{bid.created_at | moment}}</td>
            <td>{{bid.price.value}}</td>
            <td class="buttons-inner">
              <button class="ft-button-success" @click="acceptAction(bid)">Accept Bid</button>
            </td>
          </tr>
        </tbody>
      </table>
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
  .ft-search-widget {
    color: $secondary-text-color;
    .search-count {
      .number {
        color: $main-header-color;
      }
    }
    .calendar-container {
      padding: 0;
      margin-left: 30px;
    }
    .buttons-inner {
      margin: 0;
      padding: 0;
      .btn-round {
        margin: 0;
      }
    }
    .line {
      p {
        padding: 8px 0 0 0;
        margin: 0;
        margin-right: 10px;
      }
      margin: 20px 0;
    }
  }
</style>
<script>
  import CurrencyInput from 'app/components/Input/CurrencyInput';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import 'vue-awesome/icons/arrow-alt-circle-up';
  import 'vue-awesome/icons/arrow-alt-circle-down';
  import Icon from 'vue-awesome/components/Icon';

  export default {
    name: 'Bids',
    props: ['bids', 'getBids', 'acceptAction', 'request'],
    components: {
      currencyinput: CurrencyInput,
      ftdatepicker: FtDatepicker,
      icon: Icon,
    },
    data() {
      return {
        price: {
          value: 0,
          currency: 'USD',
          max: 0
        },
        params: {
          created_date_from: '',
          created_date_to: '',
          scout_name: '',
          price_min: '',
          price_max: '',
          order: '',
          order_asc: true,
        }
      };
    },
    mounted() {
      if (this.request) {
        this.price.value = this.request.price.value
        this.price.currency = this.request.price.currency
        this.price.max = this.request.price.max
      }
      this.search();
    },
    computed: {
      url() {
        var params = this.params;
        params.price_min = this.price.value;
        params.price_max = this.price.max;
        if (params.created_date_from) {
          params.created_date_from = this.$options.filters.railsdate(params.created_date_from);
        }
        if (params.created_date_to) {
          params.created_date_to = this.$options.filters.railsdate(params.created_date_to);
        }
        return Object.keys(params)
          .map(function (k) {
            return encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);
          })
          .join('&');
      }
    },
    watch: {
      url() {
        this.search();
      }
    },
    methods: {
      search() {
        this.getBids(this.url);
      },
      setOrder(order) {
        if (this.params.order == order)
          this.params.order_asc = !this.params.order_asc;
        else
          this.params.order_asc = true;
        this.params.order = order;
        this.search();
      },
    }
  };
</script>
