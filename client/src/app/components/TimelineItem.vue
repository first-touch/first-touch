<template>
  <div class="a-side-indicator secondary">
    <div class="arrow"></div>
    <div class="item-container">
      <slot></slot>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.item-container {
  background: $first-touch-white;
  color: $main-text-color;
  border-radius: 5px;
  padding: 20px;
  width: 100%;
}
</style>

<script>
export default {
  name: 'TimelineItem',
};
</script>
