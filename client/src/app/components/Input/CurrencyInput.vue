<template>
  <div class="autonumeric input-group ft-input" v-on:blur="blur()">
        <div class="input-group-addon input-group-addon-selector">

      <select :disabled="lock" v-if="!currency" class="currency-selector" v-model="model.currency">
        <option value="USD" data-placeholder="0.00">USD</option>
        <option value="EUR" data-placeholder="0.00">EUR</option>
        <option value="GBP" data-placeholder="0.00">GBP</option>
        <option value="SGD" data-placeholder="0.00">SGD</option>
      </select>
      <span class="currency" v-if="currency">{{currency}}</span>
    </div>
    <autonumeric @blur.native="blurMin()" :disabled="lock" class="form-control " :class="max ?'col-lg-5 input-1':''" v-model="model.value"
      :placeholder="placeholder" :options="{
         digitGroupSeparator: ',',
         decimalCharacter: '.',
         decimalCharacterAlternative: '.',
         roundingMethod: 'U',
         minimumValue: '0'
     }"></autonumeric>
    <slot />
    <span v-if="max && !noHyphen" class="separator col-lg-1 col-md-1">-</span>
        <span v-if="max && noHyphen" class="separator col-lg-1 col-md-1"></span>

    <autonumeric @blur.native="blurMax()" :disabled="lock" class="form-control input-2 col-lg-5" v-if="max" v-model="model.max" ref="max"
      :placeholder="placeholder1" :options="{
         digitGroupSeparator: ',',
         decimalCharacter: '.',
         decimalCharacterAlternative: '.',
         roundingMethod: 'U',
         minimumValue: '0'
     }" />
    <div class="input-group-addon currency">{{currency?currency:model.currency | currency}}</div>

  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  input {
    padding: 10px !important;
    max-height: 40px;
  }

  .autonumeric {
    height: 100%;
    min-height: 30px;
    .input-1 {
      border-bottom-right-radius: 10px !important;
      border-top-right-radius: 10px !important;
    }
    .input-2 {
      border-bottom-left-radius: 10px !important;
      border-top-left-radius: 10px !important;
    }
    .separator {
      padding: 10px;
      text-align: center;
    }
    .form-control {
      z-index: unset;
      &:focus {
        box-shadow: 0 0 0 0.2rem $input-focus-color;
        border-color: $input-focus-color;
      }
    }
    .input-group-addon {
      padding: 0;
      max-height: 40px;
      &.input-group-addon-selector,
      .currency-selector {
           border-bottom-left-radius: 10px;
      border-top-left-radius: 10px;

      }
      .currency-selector {
        border: 0;
        color: $main-text-color;
      }
    }
    .currency {
      padding: 5px 10px;
           border-bottom-right-radius: 10px;
        border-top-right-radius: 10px;
    }
    .col {
      float: left;
      height: 100%;
      input {
        height: 100%;
        z-index: 0;
      }
      color: $main-text-color;
    }
    select {
      padding: 0;
      margin: 0;
      height: 100% !important;
      background: #eceeef;
      padding-right: 0;
      width: 100%;
    }
  }
</style>

<script>
  import VueAutonumeric from 'vue-autonumeric/src/components/VueAutonumeric';

  export default {
    name: 'CurrencyInput',
    components: {
      autonumeric: VueAutonumeric
    },
    props: ['value', 'max', 'currency', 'lock', 'placeholder', 'placeholder1', 'maxValue','noHyphen'],
    data() {
      return {
        model: this.value
      };
    },
    methods: {
      blurMin() {
        if (this.model.value > this.maxValue) {
          this.model.value = parseInt(this.maxValue)
        }
        if (this.max) {
          if (this.model.value > this.model.max) this.model.max = this.model.value
          this.$emit('update');
        }
      },
      blurMax() {
        if (this.model.max > this.maxValue) {
          this.model.max = parseInt(this.maxValue)
        }
        if (this.model.max < this.model.value) this.model.value = this.model.max;
        this.$emit('update');
      }
    },
    watch: {
      model: {
        handler: function (val, oldVal) {
            this.$emit('update');
        },
        deep: true
      },
      value() {
        this.model = this.value;
      }
    }
  };
</script>
