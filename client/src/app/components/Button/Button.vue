<template>
<button @click="onClick" class="header-button">
  <div class="icon-wrapper">
    <div :class="['ft-icon', icon]"></div>
  </div>
  <slot>
    Button
  </slot>
</button>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .icon-wrapper {
    background-color: $button-background-colour;
    display: inline-block;
    padding: 7px 10px;
    border-radius: 20px;
  }

  .header-button {
    color: $secondary-text-color;
    text-transform: uppercase;
    background-color: transparent;
    border: none;
  }
</style>


<script>
export default {
  props: {
    onClick: {
      type: Function,
      required: true
    },
    icon: {
      type: String,
      default: 'ft-notes'
    }
  }
}
</script>
