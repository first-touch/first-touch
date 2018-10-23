<template>
  <div class="inline-form row ft-form col-lg-12">
    <p>You are currently viewing reports for </p>
    <fieldset class="inline col-lg-1">
      <vselect v-model="type_select" class="form-control m-field-input" :class="params.type_report == '' ? 'empty' : ''" @input="search" :options="options.report_type"
        :searchable="false" />
    </fieldset>
    <p>From </p>
    <fieldset class="inline col-lg-2">
      <ftdatepicker class="col-lg-12 form-control" ref="createdDate" :value="params.created_date_from" v-on:update:val="params.created_date_from = $event; search()"
        placeholder="Date" hideChooseIcon="true" />
    </fieldset>
    <p> To </p>
    <fieldset class="inline col-lg-2">
      <ftdatepicker class="col-lg-12 form-control" ref="createdDate" :value="params.created_date_to" v-on:update:val="params.created_date_to = $event; search()"
        placeholder="Date" hideChooseIcon="true" />
    </fieldset>
  </div>
</template>

<style lang="scss">
  @import '~stylesheets/search';

  .inline-form {
    .inline {
      .form-control {
        &.v-select {}
        .ftdatepicker {
          background: transparent;
          height: 35px;
          padding: 3px 8px;

          input {
            background: transparent;
            padding: 1px .25em;
          }
        }
      }
    }
  }
</style>
<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .inline-form {
    padding: 10px 30px;
    p {
      color: $secondary-text-color;
    }
    .inline {
      min-width: 90px;
      margin-top: -5px;
      height: 30px; // min-width: 150px;
      .form-control {
        padding: 0;
        height: 35px;
        border-color: #ced4da;
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
        type_select: {
          label: 'Players',
          value: 'player'
        },
        params: {
          report_type: 'player',
          created_date_from: '',
          created_date_to: '',
        },
        options: {
          report_type: [{
              label: 'Players',
              value: 'player'
            },
            {
              label: 'Teams',
              value: 'team'
            }
          ]
        }
      };
    },
    computed: {
      url() {
        var params = this.params;
        params.type_report = this.type_select.value;
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
          self.$emit('update:type', self.type_select.value );

        }, 300);
      }
    }
  }
</script>
