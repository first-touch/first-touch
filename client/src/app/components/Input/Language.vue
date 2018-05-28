<template>
  <vselect ref="vSelect" :disabled="readonly" v-model="model" multiple :onChange="update" :options="languages" class="ft-input form-control" :placeholder="placeholder"
  />
</template>


<style lang="scss" scoped>
  @import '~stylesheets/variables';
</style>

<script>
  import countrydata from 'country-data';
  import vSelect from 'vue-select';

  export default {
    name: 'Language',
    props: ['value', 'readonly', 'placeholder'],
    components: {
      vselect: vSelect
    },
    data() {
      return {
        model: ''
      };
    },
    mounted() {
      var model = [];
      if (this.value.constructor == Array) {
        for (var val in this.value) {
          const index = this.$options.filters.searchInObj(
            this.languages,
            option => option.value === this.value[val]
          );
          if (index >= 0) model.push(this.languages[index]);
        }
      }
      this.model = model;
      this.$refs.vSelect.scrollTo = function () {};
    },
    methods: {
      update(val) {
        if (val) this.$emit('update:val', this.$options.filters.vueSelect2Val(val));
      }
    },
    computed: {
      languages() {
        var languages = [];
        var multiple = [];
        $.each(countrydata.languages, function (key, value) {
          if (value.alpha2 && !multiple[value.name]) {
            multiple[value.name] = 1;
            languages.push({
              label: value.name,
              value: value.alpha2
            });
          }
        });
        languages.sort(function (a, b) {
          if (a.label < b.label) return -1;
          if (a.label > b.label) return 1;
          return 0;
        });
        return languages;
      }
    }
  };
</script>
