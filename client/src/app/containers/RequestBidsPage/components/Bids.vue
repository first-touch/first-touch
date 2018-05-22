<template>
  <div class="ft-search-widget widget-reports col col-lg-12">
    <div class="row">
      <div class="col-lg-2">
        <h6 class="list-title">Bids</h6>
        <h1 class="list-count">{{bids ? bids.bid.length: '0'}}</h1>
      </div>
      <form @submit.prevent="search" class="col-lg-10">
        <div class="row">
          <fieldset class="col-lg-6">
            <currencyinput :value="price" max="true" :currency="currency" />
          </fieldset>
          <ftdatepicker class="col-lg-3 form-control" :value="params.created_date" v-on:update:val="params.created_date = $event; search()"
          placeholder="Bid date"
          />
        </div>
      </form>
      <table class="table table-search">
        <thead>
          <tr>
            <th scope="col" class="shortable" @click="setOrder('created_at')">
              <p>Bid Date</p>
              <span v-if="params.order == 'created_at'">
                <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
              </span>
            </th>
            <th scope="col" class="shortable" @click="setOrder('scout_name')">
              <p>Scout's Name </p>
              <span v-if="params.order == 'scout_name'">
                <icon name='arrow-alt-circle-up' v-if="!params.order_asc"></icon>
                <icon name='arrow-alt-circle-down' v-if="params.order_asc"></icon>
              </span>
            </th>
            <th scope="col" class="shortable" @click="setOrder('price')">
              <p>Bid Price (in {{currency}})</p>
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
            <td>{{bid.created_at | moment}}</td>
            <td>
              <router-link :to="{ name: 'userProfilePage', params: { id: bid.user.id }}" target="_blank" v-if="bid">
                {{bid.user.first_name}} {{bid.user.last_name}}</router-link>
            </td>
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
  .buttons-inner {
    margin: 0;
    padding: 0;
    .btn-round {
      margin: 0;
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
    props: ['bids', 'currency', 'getBids', 'acceptAction'],
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
          created_date: '',
          price_min: '',
          price_max: '',
          order: '',
          order_asc: true,
        }
      };
    },
    computed: {
      url() {
        var params = this.params;
        params.price_min = this.price.value;
        params.price_max = this.price.max;
        return Object.keys(params)
          .map(function (k) {
            return encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);
          })
          .join('&');
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
