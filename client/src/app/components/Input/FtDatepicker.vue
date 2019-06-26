<template>
  <datepicker class="ft-datepicker"
      @opened="toggle"
      :disabled-dates="disabledDates"
      :disabled="disabled"
      ref="datepicker"
      :required="true"
      v-model="model"
      @closed="update"
      format="dd-MMM-yyyy"
      :placeholder="placeholder" />
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
  import 'vue-awesome/icons/calendar-alt';
  import 'vue-awesome/icons/calendar-check';
  import 'vue-awesome/icons/times';
  import Icon from 'vue-awesome/components/Icon';
  import Datepicker from 'vuejs-datepicker';

  export default {
    name: 'FtDatepicker',
    props: ['value', 'disabled', 'disabledDates', 'placeholder', 'hideicon', 'hideChooseIcon'],
    data() {
      return {
        model: this.value,
        show: false
      };
    },
    components: {
      icon: Icon,
      datepicker: Datepicker
    },
    methods: {
      showCalendar: function () {
        this.$refs.datepicker.showCalendar();
      },
      toggle() {
        this.show = true;
      },
      update() {
        this.show = false;
        this.$emit('update:val', this.model);
      }
    }
  };
</script>
