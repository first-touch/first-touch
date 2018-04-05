<template>
  <select v-model="model"  @change="update">
    <option disabled value="">Preferred Foot</option>
    <option value="R">Right</option>
    <option value="L">Left</option>
  </select>
</template>

<script>
export default {
  name: 'PreferredFoot',
  props: ['value'],
  data () {
    return {
      model: this.value
    };
  },
  methods: {
    update () {
      this.$emit('update:val', this.model);
    }
  }
};
</script>
