<template>
  <div class="timeline-post">
    <div class="arrow"></div>
    <div class="item-container" :style="{ 'background-color': bgColor, padding: padding }">
      <slot></slot>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.timeline-post {
  display: flex;
  border-left: 7px solid $main-header-color;
  margin-top: 20px;
  .arrow {
    margin-top: 20px;
    border-left-color: $main-header-color;
  }
  .item-container {
    background: #fff;
    border-radius: 5px;
    padding: 20px;
    width: 100%;
  }
}
</style>

<script>
export default {
  name: 'TimelineItem',
  props: {
    bgColor: {
      type: String,
      default: '#fff',
    },
    padding: {
      type: String,
      default: '20px',
    }
  }
};
</script>