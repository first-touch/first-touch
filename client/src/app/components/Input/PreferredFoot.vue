<template>
  <vselect :disabled="readonly" ref="vSelect" v-model="model" :onChange="update" :options="options" :placeholder="placeholder" :clearable="true" />
</template>

<script>
  import vSelect from 'vue-select';

  export default {
    name: 'PreferredFoot',
    props: ['value','readonly','placeholder'],
    components: {
      vselect: vSelect
    },
    mounted: function () {
        const index = this.$options.filters.searchInObj(this.options, option => option.value === this.value)
        this.model = this.options[index];
    },
    data() {
      return {
        model: null,
        options: [{
            label: 'Left',
            value: 'L'
          },
          {
            label: 'Right',
            value: 'R'
          },
          {
            label: 'Both',
            value: 'B'
          }
        ]
      };
    },
    methods: {
      update(val) {
        if (val) this.$emit('update:val', this.$options.filters.vueSelect2Val(val));
      }
    }
  };
</script>
