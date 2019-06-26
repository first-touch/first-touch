<template>
  <datepicker class="ft-datepicker"
    @opened="toggle"
    :disabled-dates="disabledDates"
    :disabled="disabled"
    ref="datepicker"
    :required="true"
    v-model="value"
    @closed="update"
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
    props: ['value', 'disabled', 'disabledDates', 'placeholder', 'hideicon', 'hideChooseIcon'],
    data() {
      return {
        show: false
      };
    },
    components: {
      Datepicker
    },
    methods: {
      toggle() {
        this.show = true;
      },
      update(val) {
        this.show = false;
        this.$emit('update:val', val);
      }
    }
  };
</script>
