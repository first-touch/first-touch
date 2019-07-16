<template>
  <datepicker class="ft-datepicker"
    :disabled-dates="disabledDates"
    :disabled="disabled"
    ref="datepicker"
    :required="true"
    v-model="chosenDate"
    @selected="update"
    format="dd-MMM-yyyy"
    :placeholder="placeholder"
  />
</template>

<style lang="scss">
  .ft-datepicker.form-control {
    input {
      border: none !important;
      width: 100%;
    }
  }
</style>

<script>
  import Datepicker from 'vuejs-datepicker';

  export default {
    name: 'FtDatepicker',
    props: [
      'value',
      'disabled',
      'disabledDates',
      'placeholder',
      'hideicon',
      'hideChooseIcon'
    ],
    data() {
      return {
        chosenDate: this.value,
      };
    },
    components: {
      Datepicker
    },
    methods: {
      update(val) {
        this.$emit('update:val', val);
      }
    },
    watch: {
      value() {
        debugger;
      }
    }
  };
</script>
