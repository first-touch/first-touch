<template>
  <div class="radial-progress" :data-progress="percentage">
    <div class="circle">
      <div class="mask full">
        <div class="fill"></div>
      </div>
      <div class="mask half">
        <div class="fill"></div>
        <div class="fill fix"></div>
      </div>
    </div>
    <div class="inset"><p class="score">{{score}}</p></div>
  </div>
</template>
<style lang="scss" scoped>
@import '~stylesheets/variables';
$circle-background: #fff;
$circle-color: $main-header-color;
$circle-size: 80px;
$transition-length: 1s;
$inset-size: 55px;
$inset-color: #fff;
$increment: 180deg / 100;
$score-color: $main-header-color;
$score-font-size: 25px;

.radial-progress {
  background-color: $circle-background;
  width: $circle-size;
  height: $circle-size;
  border-radius: 50%;

  .circle {
    .mask,
    .fill {
      width: $circle-size;
      height: $circle-size;
      position: absolute;

      border-radius: 50%;

      transition: -webkit-transform $transition-length;
      transition: -ms-transform $transition-length;
      transition: transform $transition-length;
      -webkit-backface-visibility: hidden;
    }
    .mask {
      clip: rect(0px, $circle-size, $circle-size, $circle-size/2);
      background-color: $circle-background;
      .fill {
        clip: rect(0px, $circle-size/2, $circle-size, 0px);
        background-color: $circle-color;
      }
    }
  }

  .inset {
    width: $inset-size;
    height: $inset-size;
    position: absolute;
    margin-left: ($circle-size - $inset-size)/2;
    margin-top: ($circle-size - $inset-size)/2;
    background-color: $inset-color;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    .score {
      line-height: 1;
      color: $score-color;
      font-size: $score-font-size;
      font-weight: bold;
      margin: 0;
    }
  }

  @for $i from 1 through 100 {
    &[data-progress='#{$i}'] {
      .circle {
        .mask.full,
        .fill {
          transform: rotate($increment * $i);
        }
        .fill.fix {
          transform: rotate($increment * $i * 2);
        }
      }
    }
  }
}
</style>
<script>
export default {
  name: 'RadialProgress',
  props: {
    percentage: String,
    score: Number,
  }
}
</script>


