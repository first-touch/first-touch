// TODO: Deprecated
<template>
  <div class="a-side-indicator primary">
    <div class="arrow"></div>
    <div class="col-lg-12">
      <slot></slot>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .timeline-widget-button {
    color: $secondary-text-color;
    text-transform: uppercase;
    background-color: $navbar-background-color;
    border: none;
    margin-right: 20px;
    a {
      margin-bottom: auto;
      margin-top: auto;
      cursor: pointer;
      padding-left: 20px;
      color: $main-text-color;
      &.active {
        color: $secondary-header-color;
      }
      &:hover {
        color: $main-header-color;
        text-decoration: none;
      }
    }
    span {
      border-radius: 50%;
      color: #fff;
      text-align: center;
      background: $timeline-widget-button-background;
      border: solid 1px $timeline-widget-button-background;
      display: inline-block;
      color: $timeline-widget-button-color;
      padding: 7px 4px 0 0;
      width: 49px;
      height: 49px;
      .fa-icon {
        transform: scale(1.2);
        cursor: pointer;
      }
    }
    &.button-right {
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
</style>

<script>
  export default {
    name: 'ActionsItem'
  };
</script>
