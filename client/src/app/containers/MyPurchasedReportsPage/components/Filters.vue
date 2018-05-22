<template>
  <form @submit.prevent="search" class="col-lg-10">
    <div class="row">
      <fieldset class="col-lg-3 filter" v-if="!request">
        <input type="number" v-model="params.id" class="form-control col-lg-12" placeholder="Report id">
      </fieldset>
      <fieldset class="col-lg-3 filter form-control">
        <input class="col-lg-12 form-control" placeholder="Scout's Name" type="text" v-model="params.scout_name" />
      </fieldset>
      <fieldset class="col-lg-3 filter" v-if="!request">
        <vselect v-model="status_select" @input="search" :options="options.report_status" :searchable="false" />
      </fieldset>
      <ftdatepicker class="col-lg-3 filter form-control" :value="params.created_date" v-on:update:val="params.created_date = $event; search()"
        placeholder="Submitted on" />
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
          purchased: true

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
      url() {
        var params = this.params;
        params.completion_status = this.status_select.value;
        params.min_price = this.price.value;
        if (this.price.max > 0)
          params.max_price = this.price.max;
        else {
          delete(params.max_price)
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
