<template>
  <form @submit.prevent="search" class="col-lg-10">
    <div class="row">
      <fieldset class="col-lg-3 col-md-12" v-if="!request">
        <input type="number" min="0" v-model="params.id" class="form-control col-lg-12" placeholder="Report id">
      </fieldset>
      <fieldset class="col-lg-3 col-md-12">
        <input class="col-lg-12 form-control" placeholder="Scout's Name" type="text" v-model="params.scout_name" />
      </fieldset>
      <fieldset class="col-lg-3 col-md-12" v-if="!request">
        <vselect v-model="status_select" @input="search"  class="form-control m-field-input" :class="params.completion_status == ''? 'empty': '' " :options="options.report_status" :searchable="false" />
      </fieldset>
      <fieldset class="col-lg-5 col-md-12 calendar-filter">
        <ftdatepicker class="col-lg-12 form-control" ref="createdDate" :value="params.created_date" v-on:update:val="params.created_date = $event; search()"
          placeholder="Submitted on" />
      </fieldset>
      <div class="col-lg-12 price-filter row">
        <label class="col-lg-2 col-md">Price</label>
        <currencyinput class="col-lg-10" :value="price" max="true" :currency="currency" />
      </div>
    </div>
  </form>
</template>

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
        status_select: {
          label: 'Report Status',
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
          report_status: '',
          created_date: '',
          scout_name: '',
          purchased: true,
          max_price: 0,
          min_price: 0,
          completion_status: ''

        },
        options: {
          report_status: [{
              label: 'Report Status',
              value: ''
            },
            {
              label: 'Complete',
              value: 'complete'
            },
            {
              label: 'Pending',
              value: 'pending'
            },
          ],
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
          if (['purchased', 'order_asc', 'order'].indexOf(key) < 0) {
            i = params[key] != '' ? i + 1 : i;
          }
        }
        return i;
      },
      url() {
        var params = this.params;
        params.completion_status = this.status_select.value;
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
          min_price: 0,
          completion_status: ''
        };
        this.price = {
          value: 0,
          max: 0,
          currency: 'EUR'
        };
        this.$refs.createdDate.model = null;
        this.status_select = {
          label: 'Report Status',
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
