<template>
  <div class="autonumeric input-group ft-input" v-on:blur="blur()">
    <div class="input-group-addon currency">{{currency?currency:model.currency | currency}}</div>
    <autonumeric @blur.native="blurMin()" :disabled="lock" class="form-control" :class="max ?'col-md-5':''" v-model="model.value" :options="{
         digitGroupSeparator: '.',
         decimalCharacter: ',',
         decimalCharacterAlternative: '.',
         roundingMethod: 'U',
         minimumValue: '0'
     }"></autonumeric>
    <slot />
    <span v-if="max" class="separator">—</span>
    <autonumeric @blur.native="blurMax()"  :disabled="lock" class="form-control col-md-5" v-if="max" v-model="model.max" :options="{
         digitGroupSeparator: '.',
         decimalCharacter: ',',
         decimalCharacterAlternative: '.',
         roundingMethod: 'U',
         minimumValue: '0'
     }" />
    <div class="input-group-addon">

      <select :disabled="lock" v-if="!currency" class="currency-selector form-control" v-model="model.currency">
        <option value="USD" data-placeholder="0.00">USD</option>
        <option value="EUR" data-placeholder="0.00">EUR</option>
        <option value="GBP" data-placeholder="0.00">GBP</option>
        <option value="SGD" data-placeholder="0.00">SGD</option>
      </select>
      <span class="currency" v-if="currency">{{currency}}</span>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.autonumeric {
  height: 100%;
  min-height: 30px;

  .separator {
    float: left;
  }
  .form-control {
    z-index: unset;
  }
  .input-group-addon {
    padding: 0;
  }
  .currency {
    padding: 5px 10px;
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
    background: #eceeef;
    padding-right: 0;
    width: 100%;
  }
}
</style>

<script>
import VueAutonumeric from 'vue-autonumeric/src/components/VueAutonumeric.vue';

export default {
  name: 'CurrencyInput',
  components: {
    autonumeric: VueAutonumeric
  },
  props: ['value', 'max', 'currency', 'lock'],
  data() {
    return {
      model: this.value
    };
  },
  methods: {
    blurMin() {
      if (this.max){
        if(this.model.value > this.model.max) this.model.max = this.model.value
        this.$emit('update');
      }
    },
    blurMax() {
        if(this.model.max < this.model.value) this.model.value = this.model.max;
        this.$emit('update');
    }
  },
  watch: {
    model: {
      handler: function(val, oldVal) {
        this.$emit('update');
      },
      deep: true
    }
  }
};
</script>
