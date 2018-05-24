<template>
  <div class="actions-post">
    <div class="arrow"></div>
    <div class="item-container col-md-12">
      <slot></slot>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .actions-post {
    display: flex;
    border-left: 7px solid $secondary-header-color;
    margin-top: 20px;
    .arrow {
      margin-top: 20px;
      border-left-color: $secondary-header-color;
    }
    .timeline-widget-button {
      color: $secondary-text-color;
      text-transform: uppercase;
      background-color: $navbar-background-color;
      border: none;
      margin-right: 20px;
      a {
        padding-left: 20px;
        color: $main-text-color;
        &.active {
          color: $secondary-header-color;
        }
      }
      span {
        border-radius: 50%;
        color: #fff;
        text-align: center;
        background: $timeline-widget-button-background;
        display: inline-block;
        color: $timeline-widget-button-color;
        padding: 5px 8px;
      }
      &.button-right {
        cursor: pointer;
        float: right;
        margin-left: auto;
        span.publish {
          background: $secondary-header-color;
          color: white;
        }
        span.unpublish {
          background: #ff4949;
        }
      }
    }
  }
</style>

<script>
  export default {
    name: 'ActionsItem'
  };
</script>
