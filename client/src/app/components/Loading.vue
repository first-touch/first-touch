<template>
  <div class="loader" :class="classList"></div>
</template>

<style lang="scss" scoped>
.loader {
  border: 16px solid #f3f3f3; /* Light grey */
  border-top: 16px solid #3498db; /* Blue */
  border-radius: 50%;
  width: 120px;
  height: 120px;
  animation: spin 2s linear infinite;

  &.size-large {

  }

  &.size-medium {
    width: 60px;
    height: 60px;
    border-width: 2px;
    border-top-width: 2px;
  }

  &.size-small {
    width: 30px;
    height: 30px;
    border-width: 2px;
    border-top-width: 2px;
  }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>

<script>
export default {
  props: {
    size: { type: String, default: 'large' }
  },
  name: 'FTLoading',
  computed: {
    classList(){
      var classes =  {};
      classes[`size-${this.size}`] = true;
      return classes;
    }
  }
}
</script>
