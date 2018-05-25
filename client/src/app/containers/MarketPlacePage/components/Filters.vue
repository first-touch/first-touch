<template>
  <form @submit.prevent="search" class="col-lg-10">
    <div class="row">
      <fieldset class="col-lg-3 col-md-8" v-if="!request">
        <vselect v-model="type_select" class="form-control" :class="params.type_report == '' ? 'empty' : ''" @input="search" :options="options.report_type" :searchable="false" />
      </fieldset>
      <fieldset class="col-lg-3 col-md-8">
        <input class="col-lg-12 form-control" placeholder="Scout's Name" type="text" v-model="params.scout_name" />
      </fieldset>
      <fieldset class="col-lg-3 col-md-8">
        <vselect v-model="sort_select" class="form-control" :class="params.sort == '' ? 'empty' : ''"  @input="search" :options="options.order" :searchable="false" />
      </fieldset>
      <fieldset class="col-lg-5 col-md-8 calendar-filter">
        <ftdatepicker class="col-lg-12 form-control" ref="createdDate" :value="params.created_date" v-on:update:val="params.created_date = $event; search()"
          placeholder="Created date" />
      </fieldset>
      <div class="col-lg-12 price-filter row">
        <label class="col-lg-1">Price</label>
        <currencyinput class="col-lg-11" :value="price" max="true" :currency="currency" />
      </div>
    </div>
  </form>
</template>

<style lang="scss" scoped>
  form {
    margin-bottom: 20px;
    .price-filter {
      margin-top: 10px;
      .autonumeric {
        height: inherit;
        max-height: 40px;
      }
    }
  }
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
          headline: '',
          report_type: '',
          created_date: '',
          sort: '',
          scout_name: '',
          max_price: 0,
          min_price: 0
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
      if (this.request) {
        this.currency = this.request.price.currency
        this.price.value = this.request.price.value
        this.price.max = this.request.price.max
      } else {
        this.currency = null;
      }
    },
    computed: {
      nbFilters() {
        var i = 0;
        var params = this.params;
        for (var key in params) {
          if (['bids_status', 'order_asc', 'order'].indexOf(key) < 0) {
            i = params[key] != '' ? i + 1 : i;
          }
        }
        return i;
      },
      url() {
        var params = this.params;
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
        else if (params.request_id)
          delete(params.request_id)
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
      }
    },
    methods: {
      clearsFilter() {
        this.params = {
          id: '',
          headline: '',
          report_type: '',
          created_date: '',
          sort: '',
          scout_name: '',
          max_price: 0,
          min_price: 0
        };
        this.price = {
          value: 0,
          max: 0,
          currency: 'EUR'
        };
        this.$refs.createdDate.model = null;
        this.sort_select = {
          label: 'Sort by',
          value: ''
        };
        this.type_select = {
          label: 'Report Type',
          value: ''
        };
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
