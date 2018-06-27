<template>
  <vselect :disabled="readonly" v-model="model" :on-change="update" :options="options" class="ft-input form-control"
   :class="[ {'empty' : model == null} , {'form-control-read-only' : readonly }]" :placeholder="placeholder"
  />
</template>
<script>
  import vSelect from 'vue-select';

  export default {
    name: 'TeamSelect',
    props: ['value', 'readonly', 'placeholder'],
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
            label: 'Senior',
            value: 'senior'
          },
          {
            label: 'Team b',
            value: 'team_b'
          },
          {
            label: 'Team c',
            value: 'team_c'
          },
          {
            label: 'Reserves',
            value: 'reserves'
          },
          {
            label: 'U 21',
            value: 'u21'
          },
          {
            label: 'U 20',
            value: 'u20'
          },
          {
            label: 'U 19',
            value: 'u19'
          },
          {
            label: 'U 18',
            value: 'u18'
          },
          {
            label: 'U 17',
            value: 'u17'
          },
          {
            label: 'U 16',
            value: 'u16'
          }
        ]
      };
    },
    methods: {
      update(val) {
       if (val.value) {
        this.model = val.value
        this.$emit('update:val', this.$options.filters.vueSelect2Val(val));
      }
      }
    }
  };
</script>
