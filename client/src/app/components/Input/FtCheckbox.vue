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
      top: 0px;
      left: 2px;
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
  } // .slideOne {
  //   width: 50px;
  //   height: 10px;
  //   background: #333;
  //   margin: 20px auto;
  //   position: relative;
  //   border-radius: 50px;
  //   box-shadow: inset 0px 1px 1px rgba(0, 0, 0, 0.5), 0px 1px 0px rgba(255, 255, 255, 0.2);
  //   label {
  //     display: block;
  //     width: 16px;
  //     height: 16px;
  //     position: absolute;
  //     top: -3px;
  //     left: -3px;
  //     cursor: pointer;
  //     background: #fcfff4;
  //     background: linear-gradient(to bottom, #fcfff4 0%, #dfe5d7 40%, #b3bead 100%);
  //     border-radius: 50px;
  //     box-shadow: 0px 2px 5px 0px rgba(0, 0, 0, 0.3);
  //     transition: all 0.4s ease;
  //   }
  //   input[type=checkbox] {
  //     visibility: hidden;
  //     &:checked+label {
  //       left: 37px;
  //     }
  //   }
  // }
  // .ondisplay {
  //   text-align: center;
  //   padding: 20px 0;
  //   section {
  //     width: 100px;
  //     height: 100px;
  //     background: #555;
  //     display: inline-block;
  //     position: relative;
  //     text-align: center;
  //     margin-top: 5px;
  //     border: 1px solid gray;
  //     border-radius: 5px;
  //     box-shadow: 0 1px 4px rgba(0, 0, 0, 0.3),
  //     0 0 40px rgba(0, 0, 0, 0.1) inset;
  //     &:after {
  //       /*         visibility: hidden; */
  //       content: attr(title);
  //       position: absolute;
  //       width: 100%;
  //       left: 0;
  //       bottom: 3px;
  //       color: #fff;
  //       font-size: 12px;
  //       font-weight: 400;
  //       -webkit-font-smoothing: antialiased;
  //       text-shadow: 0px 1px #000;
  //     }
  //   }
  // }
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
