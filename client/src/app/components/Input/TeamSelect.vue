<template>
  <vselect v-model="value" :options="options" :disabled="disabled" :on-change="updateValue" :placeholder="placeholder" />
</template>
<script>
  import vSelect from 'vue-select';

  export default {
    name: 'TeamSelect',
    props: ['value', 'placeholder', 'disabled'],
    components: {
      vselect: vSelect
    },
    data() {
      return {
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
      updateValue(value) {
        this.$emit('input', value);
      }
    }
  };
</script>
