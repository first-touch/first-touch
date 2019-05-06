<template>
  <div class="input-group mb-2" v-on:blur="blur()">
    <div class="input-group-prepend">
      <select :disabled="lock" v-if="!currency" class="input-group-text" v-model="model.currency">
        <option value="USD">USD</option>
        <option value="EUR">EUR</option>
        <option value="GBP">GBP</option>
        <option value="SGD">SGD</option>
      </select>
      <span class="input-group-text" v-if="currency">{{currency}}</span>
    </div>
    <v-autonumeric @blur.native="blurMin()" :disabled="lock" class="form-control " :class="max ? 'col-lg-5 input-1 ': ''" v-model="model.value"
      :placeholder="placeholder" :options="{
         digitGroupSeparator: ',',
         decimalCharacter: '.',
         decimalCharacterAlternative: '.',
         roundingMethod: 'U',
         minimumValue: '0'
     }"></v-autonumeric>
    <slot />
    <span v-if="max && !noHyphen" class="separator col-lg-1 col-md-1">-</span>
    <span v-if="max && noHyphen" class="separator col-lg-1 col-md-1"></span>

    <v-autonumeric @blur.native="blurMax()" :disabled="lock" class="form-control input-2 col-lg-5" v-if="max" v-model="model.max" ref="max"
      :placeholder="placeholder1" :options="{
         digitGroupSeparator: ',',
         decimalCharacter: '.',
         decimalCharacterAlternative: '.',
         roundingMethod: 'U',
         minimumValue: '0'
     }" />
    <div class="input-group-append currency">
      <span class="input-group-text">{{currency?currency:model.currency | currency}}</span>
    </div>
  </div>
</template>

<script>
  import VAutonumeric from 'vue-autonumeric/src/components/VueAutonumeric';

  export default {
    name: 'CurrencyInput',
    components: {
      VAutonumeric
    },
    props: ['value', 'max', 'currency', 'lock', 'placeholder', 'placeholder1', 'maxValue', 'noHyphen'],
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
        }
        this.$emit('update');
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
