<template>
  <vselect :disabled="readonly" ref="vSelect" v-model="model" :onChange="update" :options="countries" class="ft-input form-control" :class="{'empty' : model == null}" :placeholder="placeholder"/>
</template>

<script>
import countrydata from 'country-data';
import vSelect from 'vue-select';

export default {
  name: 'Nationality',
  props: ['value','readonly','placeholder'],
  components: {
    vselect: vSelect
  },
  data() {
    return {
      model: this.value
    };
  },
  mounted: function() {
    this.$refs.vSelect.scrollTo = function(){};
    const index = this.$options.filters.searchInObj(this.countries, option => option.value === this.value);
    this.model = this.countries[index];
  },
  methods: {
    update(val) {
      this.model = val;
      if (val && val.value) {
        this.$emit('update:val', this.$options.filters.vueSelect2Val(val));
      }
      else{
        this.$emit('update:val', null);
      }
    }
  },
  computed: {
    countries() {
      var arr = [];
      var multiple = [];
      $.each(countrydata.countries, function(key, value) {
        if (value.alpha2 && !multiple[value.name]) {
          multiple[value.name] = 1;
          arr.push({
            label: value.name,
            value: value.alpha2
          });
        }
      });
      arr.sort(function(a, b) {
        if (a.label < b.label) return -1;
        if (a.label > b.label) return 1;
        return 0;
      });

      return arr;
    }
  }
};
</script>
