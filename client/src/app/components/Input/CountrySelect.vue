<template>
  <v-select
    :disabled="readonly"
    ref="vSelect"
    v-model="value"
    :onChange="update"
    :options="countries"
    :placeholder="placeholder"
    :clearable="true"
    index="value"
  />
</template>

<script>
import countrydata from 'country-data';
import VSelect from 'vue-select';

export default {
  name: 'CountrySelect',
  props: ['value', 'readonly', 'placeholder'],
  components: {
    VSelect
  },
  methods: {
    update(chosenOption) {
      this.$emit('update:val', chosenOption);
    }
  },
  computed: {
    countries() {
      let arr = _.map(countrydata.countries.all, function(val) {
        return {
          label: val.name,
          value: val.alpha2
        };
      });
      return _.sortBy(arr, "label");
    }
  }
};
</script>
