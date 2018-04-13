<template>
  <vselect v-model="model" multiple :onChange="update" :options="languages" class="ft-input" />
</template>


<style lang="scss" scoped>
@import '~stylesheets/variables';
</style>

<script>
import countrydata from 'country-data';
import vSelect from 'vue-select';

export default {
  name: 'Language',
  props: ['value'],
  components: {
    vselect: vSelect
  },
  data() {
    return {
      model: this.value
    };
  },
  mounted() {
    this.model = [];
    for (var val in this.value) {
      const index = this.$options.filters.searchInObj(this.languages, option => option.value === this.value[val]);
      this.model.push(this.languages[index]);
    }
  },
  methods: {
    update(val) {
      if (val) this.$emit('update:val', this.$options.filters.vueSelect2Val(val));
    },
    removeValue(value) {
      var index = this.model.indexOf(value);
      if (index > -1) {
        this.model.splice(index, 1);
      }
    },
    indexWhere(array, conditionFn) {
      const item = array.find(conditionFn);
      return array.indexOf(item);
    },
    vueSelect2Array(selected) {
      if (selected.constructor === Array) {
        var arr = [];
        for (var obj in selected) {
          arr.push(selected[obj].value);
        }
        return arr;
      } else if (selected.value) return selected.value;
      return '';
    }
  },
  computed: {
    languages() {
      var languages = [];
      var multiple = [];
      $.each(countrydata.languages, function(key, value) {
        if (value.alpha2 && !multiple[value.name]) {
          multiple[value.name] = 1;
          languages.push({
            label: value.name,
            value: value.alpha2
          });
        }
      });
      languages.sort(function(a, b) {
        if (a.label < b.label) return -1;
        if (a.label > b.label) return 1;
        return 0;
      });
      return languages;
    }
  }
};
</script>
