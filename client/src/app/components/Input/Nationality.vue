<template>
  <select v-model="model" @change="update">
    <option v-for="(value, key, index) in countries" :key="index" :value="value[1]">
      {{value[0]}}
    </option>
  </select>
</template>

<script>
import countrydata from 'country-data';

export default {
  name: 'Nationality',
  props: ['value'],
  data () {
    return {
      model: this.value
    };
  },
  methods: {
    update () {
      this.$emit('update:val', this.model);
    }
  },
  computed: {
    countries () {
      var arr = [];
      var multiple = [];
      $.each(countrydata.countries, function (key, value) {
        if (value.alpha2 && !multiple[value.name]) {
          multiple[value.name] = 1;
          arr.push([value.name, value.alpha2]);
        }
      });
      arr.sort();
      return arr;
    }
  }
};
</script>
