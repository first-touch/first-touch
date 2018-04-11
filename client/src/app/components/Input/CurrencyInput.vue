<template>
  <div class="autonumeric input-group">
    <div class="input-group-addon currency">{{model.currency | currency}}</div>
    <autonumeric class="form-control" v-model="model.value" :options="{
         digitGroupSeparator: '.',
         decimalCharacter: ',',
         decimalCharacterAlternative: '.',
         roundingMethod: 'U',
         minimumValue: '0'
     }"></autonumeric>

    <div class="input-group-addon">
       <select class="currency-selector form-control" v-model="model.currency">
      <option value="USD" data-placeholder="0.00">USD</option>
      <option value="EUR" data-placeholder="0.00">EUR</option>
      <option value="GBP" data-placeholder="0.00">GBP</option>
      <option value="SGD" data-placeholder="0.00">SGD</option>
      </select>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.autonumeric {
  height: 100%;
  min-height: 30px;
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
  props: ['value'],
  data() {
    return {
      model: this.value
    };
  },
  methods: {
    update() {
      this.$emit('update:val', this.$options.filters.vueSelect2Val(val));
    }
  }
};
</script>
