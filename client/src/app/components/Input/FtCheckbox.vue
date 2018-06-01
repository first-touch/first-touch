<template>
  <div class="input_wrapper ft-input">

    <!-- <section title=".slideOne">
      <div class="slideOne">
        <input type="checkbox" v-model="model" @change="update" :false-value="falseValue != null ? falseValue : 'no'" :true-value="trueValue ? trueValue : 'yes'"
        />
        <label for="slideOne"></label>
      </div>
    </section> -->

    <section title=".roundedTwo">
      <!-- .roundedTwo -->
      <div class="roundedTwo" :class="{'checked': isTrue }" @click="updateValue">
        <input type="checkbox" ref="checkbox" v-model="model" @change="update" :false-value="falseValue != null ? falseValue : 'no'" :true-value="trueValue ? trueValue : 'yes'"
        />
        <label></label>
      </div>
      <!-- end .roundedTwo -->
    </section>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  /* .roundedTwo */

  .roundedTwo {
    width: 28px;
    height: 28px;
    margin-top: 5px;
    position: relative;
    border: 2px solid $main-text-color;
    border-radius: 50%;
    &.checked {
      border-color: $main-header-color;
    }
    label {
      width: 20px;
      height: 20px;
      position: absolute;
      top: -2px;
      left: 0px;
      cursor: pointer;
      background: linear-gradient(top, #222 0%, #45484d 100%);
      border-radius: 50px;
      &:after {
        content: '';
        width: 9px;
        height: 5px;
        position: absolute;
        top: 0px;
        left: 2px;
        border: 3px solid #fcfff4;
        border-top: none;
        border-right: none;
        background: transparent;
        opacity: 0;
        transform: rotate(-45deg);
      }
      &:hover::after {
        opacity: 0.3;
      }
    }
    input[type=checkbox] {
      visibility: hidden;
      &:checked+label:before {
        opacity: 1;
        content: '✓';
        color: $main-header-color;
        font-size: 20px;
        font-weight: bold;
        transform: rotate(360deg);
        margin-left: 3px;
      }
    }
  }
</style>

<script>
  export default {
    name: 'FtCheckbox',
    props: ['value', 'falseValue', 'trueValue'],
    watch: {
      value() {
        this.model = this.value;
      }
    },
    computed: {
      isTrue() {
        if (this.trueValue)
          return this.model == this.trueValue;
        return this.model == 'yes';
      }
    },
    data() {
      return {
        model: this.value
      };
    },
    methods: {
      update() {
        this.$emit('update:val', this.model);
      },
      updateValue() {
        this.$refs.checkbox.click()
      }
    }
  };
</script>
