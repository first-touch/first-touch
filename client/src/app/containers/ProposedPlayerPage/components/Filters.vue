<template>
  <form @submit.prevent="search" class="col-lg-10">
    <div class="row">
      <fieldset class="col-lg-3 col-md-12">
        <input type="number" min="0" v-model="params.id" class="form-control col-lg-12" placeholder="Report id">
      </fieldset>
      <fieldset class="col-lg-3 col-md-12">
        <input class="col-lg-12 form-control" placeholder="Scout's Name" type="text" v-model="params.scout_name" />
      </fieldset>
      <fieldset class="col-lg-3 col-md-12 calendar-filter">

        <ftdatepicker class="col-lg-12 form-control" ref="createdDate" :value="params.created_date" v-on:update:val="params.created_date = $event; search()"
          placeholder="Submitted on" />
      </fieldset>

      <div class="col-lg-12 price-filter row">
        <label class="col-lg-1">Price</label>
        <currencyinput class="col-lg-11" :value="price" max="true" :currency="currency" />
      </div>
    </div>
  </form>
</template>

<style lang="scss" scoped>
  // form {
  //   margin-bottom: 20px;
  //   .price-filter {
  //     margin-top: 10px;
  //     .autonumeric {
  //       height: inherit;
  //       max-height: 40px;
  //     }
  //   }
  // }
</style>

<script>
  import vSelect from 'vue-select';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import CurrencyInput from 'app/components/Input/CurrencyInput';

  export default {
    name: 'MarketPlaceFilters',
    props: ['request'],
    components: {
      vselect: vSelect,
      ftdatepicker: FtDatepicker,
      currencyinput: CurrencyInput,
    },
    data() {
      return {
        timer: null,
        sort_select: {
          label: 'Sort by',
          value: ''
        },
        type_select: {
          label: 'Report Type',
          value: ''
        },
        price: {
          value: 0,
          max: 0,
          currency: 'EUR'
        },
        currency: null,
        params: {
          id: '',
          request_id: '',
          headline: '',
          report_type: '',
          created_date_from: '',
          created_date_to: '',
          created_date: '',
          sort: '',
          scout_name: '',
          min_price: 0,
          max_price: 0
        },
        options: {
          report_type: [{
              label: 'Report Type',
              value: ''
            },
            {
              label: 'Player',
              value: 'player'
            },
            {
              label: 'Team',
              value: 'team'
            }
          ],
          order: [{
              label: 'Sort by',
              value: ''
            },
            {
              label: 'Updated date',
              value: 'updated_at'
            },
            {
              label: 'Type',
              value: 'Type'
            },
            {
              label: 'Price',
              value: 'price'
            }
          ]
        }
      };
    },
    mounted() {
      this.currency = this.request ? this.request.price.currency : null;
      this.price.value = this.getMinPrice;
      this.price.max = this.getMaxPrice;
    },
    computed: {
      nbFilters() {
        var i = 0;
        var params = this.params;
        for (var key in params) {
          if (['sort', 'min_price', 'max_price', 'request_id'].indexOf(key) < 0) {
            i = params[key] != '' ? i + 1 : i;
          }
        }
        i = this.params.min_price != this.getMinPrice ? i + 1 : i;
        i = this.params.max_price != this.getMaxPrice ? i + 1 : i;

        return i;
      },
      getMinPrice() {
        if (this.request)
          return this.request.price.value
        return 0;
      },
      getMaxPrice() {
        if (this.request)
          return this.request.price.max
        return 0;
      },
      url() {
        var params = this.params;
        if (params.created_date_from) {
          params.created_date_from = this.$options.filters.railsdate(params.created_date_from);
        }
        if (params.created_date_to) {
          params.created_date_to = this.$options.filters.railsdate(params.created_date_to);
        }
        params.sort = this.sort_select.value;
        params.type_report = this.type_select.value;
        params.min_price = this.price.value;
        if (this.price.max > 0)
          params.max_price = this.price.max;
        else {
          params.max_price = '';
        }
        if (this.request)
          params.request_id = this.request.id;
          var url = Object.keys(params)
          .map(function (k) {
            return encodeURIComponent(k) + '=' + encodeURIComponent(params[k]);
          })
          .join('&');
        return url;
      }
    },
    watch: {
      url() {
        this.search();
      },
      request() {
        this.currency = this.request ? this.request.price.currency : null;
        this.price.value = this.getMinPrice;
        this.price.max = this.getMaxPrice;
      }
    },
    methods: {
      clearsFilter() {
        this.params = {
          id: '',
          headline: '',
          request_id: '',
          report_type: '',
          created_date_from: '',
          created_date_to: '',
          created_date: '',
          sort: '',
          scout_name: '',
          min_price: 0,
          max_price: 0
        };
        this.price.value = this.getMinPrice;
        this.price.max = this.getMaxPrice;
        this.$refs.createdDate.model = null;
      },
      search() {
        clearTimeout(this.timer);
        var self = this;
        this.timer = setTimeout(function () {
          self.$emit('update:search');
        }, 300);
      }
    }
  }
</script>
