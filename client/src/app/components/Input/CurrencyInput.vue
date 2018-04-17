<template>
  <div class="autonumeric input-group ft-input">
    <div class="input-group-addon currency">{{model.currency | currency}}</div>
    <autonumeric class="form-control" :class="max ?'col-md-5':''" v-model="model.value" :options="{
         digitGroupSeparator: '.',
         decimalCharacter: ',',
         decimalCharacterAlternative: '.',
         roundingMethod: 'U',
         minimumValue: '0'
     }"></autonumeric>
    <slot />
      <span v-if="max" class="separator">—</span>
      <autonumeric class="form-control col-md-5" v-if="max" v-model="model.max"  :options="{
         digitGroupSeparator: '.',
         decimalCharacter: ',',
         decimalCharacterAlternative: '.',
         roundingMethod: 'U',
         minimumValue: '0'
     }" />
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

    .separator {
      float: left;
    }
    .second {
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
  props: ['value', 'max'],
  data() {
    return {
      model: this.value
    };
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
