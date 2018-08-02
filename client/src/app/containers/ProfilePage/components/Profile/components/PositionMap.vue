<template>
  <div class="field-container">
    <div class="field">
      <div class="overlay" :class="position"/>
      <img class="field-bg" src="/images/football-field.svg" alt="Football Position Map"/>
    </div>
  </div>
</template>
<style lang="scss" scoped>
.field-container {
  height: 100%;
  width: 100%;
  perspective: 500px;
  margin-top: -10%;
  .field {
    max-height: 100%;
    width: 100%;
    transform: rotateX(45deg);
    .field-bg {
      height: 100%;
      max-width: 100%;
    }
    .overlay {
      width: 78%;
      margin-left: 11%;
      height: 33.33%;
      position: absolute;
      &.A {
        top: 0;
        background-color: rgba(255, 0, 0, 0.5);
      }
      &.M {
        top: 33.33%;
        background-color: rgba(255, 255, 0, 0.5);
      }
      &.D {
        bottom: 0;
        background-color: rgba(0, 255, 255, 0.5);
      }
    }
  }
}
</style>
<script>
export default {
  name: 'PositionMap',
  props: {
    position: {
      type: String,
      validator: val => ['A', 'M', 'D'].includes(val)
    }
  }
};
</script>


