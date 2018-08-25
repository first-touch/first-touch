<template>
  <div class="misc-container">
    <div class="arrow"></div>
    <div class="details-container">
      <h4 class="title">{{title}}</h4>
      <slot></slot>
    </div>
  </div>
</template>
<style lang="scss" scoped>
@import '~stylesheets/variables';

.misc-container {
  display: flex;
  border-left: 7px solid $main-header-color;
  margin-top: 20px;
  .arrow {
    margin-top: 20px;
    border-left-color: $main-header-color;
  }
  .details-container {
    background: #fff;
    border-radius: 5px;
    padding: 20px;
    width: 100%;
    .title {
      font-weight: 300;
      color: $main-text-color;
      text-transform: uppercase;
      letter-spacing: 0.3rem;
    }
  }
}
</style>
<script>
export default {
  name: 'MiscContainer',
  props: {
    title: String,
  }
}
</script>

