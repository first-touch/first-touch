<template>
  <div class="autonumeric">
    <p class="col currency-currency">{{model.currency | currency}}</p>
    <autonumeric class="col col-md-8 form-control" v-model="model.value" :options="{
         digitGroupSeparator: '.',
         decimalCharacter: ',',
         decimalCharacterAlternative: '.',
         roundingMethod: 'U',
         minimumValue: '0'
     }"></autonumeric>
    <select class="currency-selector col col-md-2 form-control" v-model="model.currency">
      <option value="USD" data-placeholder="0.00">USD</option>
      <option value="EUR" data-placeholder="0.00">EUR</option>
      <option value="GBP" data-placeholder="0.00">GBP</option>
      <option value="SGD" data-placeholder="0.00">SGD</option>
    </select>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.autonumeric {
  height: 100%;
  min-height: 30px;
  .col {
    float: left;
    height: 100% !important;
    color: $main-text-color;
  }
  .currency-currency {
    background: #eceeef;
    text-align: center;
    padding: 5px 10px;
    max-width: 50px;
  }
  select {
    background: #eceeef;
    padding-right: 0;
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
