<template>
  <v-select ref="vSelect"
            :disabled="readonly"
            v-model="value"
            :onChange="update"
            multiple
            :options="options"
            :placeholder="placeholder"
            :clearable="true"
  />
</template>

<script>
  import VSelect from 'vue-select';

  export default {
    name: 'PlayerPosition',
    props: ['value', 'readonly', 'placeholder'],
    components: {
      VSelect
    },
    data() {
      return {
        options: [
          'Goalkeeper',
          'Sweeper (Centre)',
          'Defender (Right)',
          'Defender (Left)',
          'Wing-back (Right)',
          'Wing-back (Left)',
          'Defensive Midfielder (Centre)',
          'Midfielder (Right)',
          'Midfielder (Left)',
          'Midfielder (Centre)',
          'Attacking Midfielder (Centre)',
          'Winger (Right)',
          'Winger (Left)',
          'Second Striker (Centre)',
          'Striker (Centre)'
        ]
      };
    },

    methods: {
      update(val) {
        this.$emit('update:val', val);
      }
    },
  };
</script>
