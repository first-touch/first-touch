<template>
  <div class="calendar-container" :class="{'opened' : show}">
    <datepicker @opened="toggle" :disabled="disabled" ref="datepicker" class="ftdatepicker col-lg-10 col-md-10 col-sm-10" :input-class="[model != '' ? 'selected': '', 'input-date'].join(' ')"
      :required="true" v-model="model" @closed="update" format="dd-MMM-yyyy" :placeholder="placeholder"></datepicker>
    <div class="icon-container">
      <span v-if="model != ''" @click="model = ''; update()" class="icon-inner">
        <icon name='times'></icon>
      </span>
      <span @click="showCalendar()" class="icon-inner">
        <icon name='calendar-alt' v-if="model == ''"></icon>
        <icon name='calendar-check' v-if="model != ''"></icon>
      </span>
    </div>
  </div>
</template>
<style lang="scss">
  @import '~stylesheets/variables';

  .ftdatepicker {
    background: white;
    display: inline-block;
    padding: 0;
    margin-top: 2px;
    input.input-date {
      color: $main-text-color;
      overflow: auto;
      cursor: pointer;
      width: 100%;
      border: 0px;
      padding: 0;
      background: white;
      &.selected {
        text-transform: uppercase;

      }
    }
  }
</style>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .calendar-container {
    display: flex;
    &.opened {
      box-shadow: 0 0 0 0.2rem $input-focus-color;
    }
    .icon-container {
      float: right;
      margin-right: 10px;
      .icon-inner {
        cursor: pointer;
        &:hover {
          color: $secondary-header-color;
        }
      }
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
    props: ['value', 'disabled', 'placeholder'],
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
