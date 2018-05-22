<template>
  <div>
    <datepicker :disabled="disabled" ref="datepicker" class="ftdatepicker col-lg-9" :input-class="[model != '' ? 'selected': '', 'input-date'].join(' ')" :required="true"
      v-model="model" @closed="update" format="dd,MMM yyyy" :placeholder="placeholder"></datepicker>
    <span v-if="model != ''" @click="model = ''; update()" class="icon-inner">
      <icon name='times'></icon>
    </span>
    <span @click="showCalendar()" class="icon-inner">
      <icon name='calendar-alt' v-if="model == ''"></icon>
      <icon name='calendar-check' v-if="model != ''"></icon>
    </span>
  </div>
</template>
<style  lang="scss">
@import '~stylesheets/variables';

  .ftdatepicker {
    background: white;
    display: inline-block;
    padding:0;
    input.input-date {
      color: $main-text-color;
      cursor: pointer;
      width: 100%;
      border: 0px;
      height: 2.3em;
      background: white;
    }
  }

</style>

<style lang="scss" scoped>
@import '~stylesheets/variables';
  .icon-inner {
    cursor: pointer;
    &:hover {
      color: $secondary-header-color;
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
  props: ['value','disabled','placeholder'],
  data() {
    return {
      model: this.value
    };
  },
  components: {
    icon: Icon,
    datepicker: Datepicker
  },
  methods: {
    showCalendar: function() {
      this.$refs.datepicker.showCalendar();
    },
    update() {
      this.$emit('update:val', this.model);
    }
  }
};
</script>
