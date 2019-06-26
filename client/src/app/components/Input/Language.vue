<template>
  <v-select
    :disabled="readonly"
    ref="vSelect"
    v-model="value"
    :onChange="update"
    multiple
    :options="languages"
    :placeholder="placeholder"
    :clearable="true"
    index="value"
  />
</template>

<script>
  import countrydata from 'country-data';
  import VSelect from 'vue-select';

  export default {
    name: 'Language',
    props: ['value', 'readonly', 'placeholder'],
    components: {
      VSelect
    },
    computed: {
      languages() {
        let languages = _.map(countrydata.languages.all, function (val) {
          if (_.isEmpty(val.alpha2)) return {};

          return {
            label: val.name,
            value: val.alpha2
          };
        });
        languages = _.reject(languages, function(e) { return _.isEmpty(e);})
        return _.sortBy(languages, "label");
      }
    },
    methods: {
      update(val) {
        this.$emit('update:val', val);
      }
    }
  };
</script>
