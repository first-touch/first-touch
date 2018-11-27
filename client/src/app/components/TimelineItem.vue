<template>
  <div class="a-side-indicator secondary">
    <div class="arrow"></div>
    <div class="item-container">
      <slot></slot>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.item-container {
  background: #fff;
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
