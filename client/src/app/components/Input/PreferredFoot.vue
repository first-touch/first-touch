<template>
  <v-select :disabled="readonly" ref="vSelect" v-model="value" :onChange="update" :options="options" :placeholder="placeholder" :clearable="true" />
</template>

<script>
  import VSelect from 'vue-select';

  export default {
    name: 'PreferredFoot',
    props: ['value', 'readonly', 'placeholder'],
    components: {
      VSelect
    },
    data() {
      return {
        options: ['Left', 'Right', 'Both']
      };
    },
    methods: {
      update(val) {
        this.$emit('update:val', val);
      }
    }
  };
</script>
