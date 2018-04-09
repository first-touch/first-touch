<template>
  <vselect v-model="model" :onChange="update" multiple :options="options" />
</template>
<script>
import vSelect from 'vue-select';

export default {
  name: 'PlayerPosition',
  props: ['value'],
  components: {
    vselect: vSelect
  },
  mounted() {
    this.model = [];
    for (var val in this.value) {
      const index = this.$options.filters.searchInObj(this.options, option => option.value === this.value[val])
      this.model.push(this.options[index]);
    }
  },
  data() {
    return {
      model: this.value,
      options: [
        {
          label: 'Goalkeeper',
          value: 'goalkeeper'
        },
        {
          label: 'Defender',
          value: 'defender'
        },
        {
          label: 'Midfielder',
          value: 'midfielder'
        },
        {
          label: 'Winger',
          value: 'winger'
        },
        {
          label: 'Striker',
          value: 'striker'
        }
      ]
    };
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
    }
  }
};
</script>
