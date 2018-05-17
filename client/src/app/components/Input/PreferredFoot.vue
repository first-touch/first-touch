<template>
  <vselect :disabled="readonly" v-model="model" :on-change="update" :options="options" class="ft-input"/>
</template>

<script>
  import vSelect from 'vue-select';

  export default {
    name: 'PreferredFoot',
    props: ['value','readonly'],
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
        options: ['foo', 'bar', 'baz'],
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
