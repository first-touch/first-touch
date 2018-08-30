<template>
  <div class="field-container">
    <div class="field">
      <div v-for="pos in Object.keys(allPos)" :key="pos" :class="`dot ${allPos[pos]} ${positions.includes(pos) ? 'active' : ''}`" />
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
    .dot {
      height: 15px;
      width: 15px;
      border-radius: 50%;
      position: absolute;
      background-color: #0f0;
      border: 2px solid #fff;
      &.active {
        box-shadow: 0 0 10px #f00;
      }
      // center
      &.GK,
      &.CB,
      &.SW,
      &.CDM,
      &.MC,
      &.AMC {
        left: calc(50% - 7.5px);
      }
      &.GK {
        bottom: 5%;
      }
      &.CB {
        bottom: 16%;
      }
      &.SW {
        bottom: 25%;
      }
      &.CDM {
        bottom: 35%;
      }
      &.MC,
      &.ML,
      &.MR {
        bottom: 48%;
      }
      &.AMC {
        bottom: 61%;
      }
      &.LB,
      &.RB {
        bottom: 21%;
      }
      // left wing
      &.LB,
      &.WBL,
      &.ML,
      &.WL {
        left: 23%;
      }
      &.WBL,
      &.WBR {
        bottom: 34%;
      }
      // right wing
      &.RB,
      &.WBR,
      &.MR,
      &.WR {
        right: 23%;
      }
      &.WL,
      &.WR {
        top: 18%;
      }
      &.CF {
        top: 15%;
        left: 40%;
      }
      &.SS {
        top: 22%;
        right: 40%;
      }
    }
  }
}
</style>
<script>
export default {
  name: 'PositionMap',
  data:
    () => ({
      allPos: {
        "Goalkeeper": "GK",
        "Sweeper (Centre)": "SW",
        "Defender (Right)": "RB",
        "Defender (Left)": "LB",
        "Defender (Centre)": "CB",
        "Wing-back (Right)": "WBR",
        "Wing-back (Left)": "WBL",
        "Defensive Midfielder (Centre)": "CDM",
        "Midfielder (Right)": "MR",
        "Midfielder (Left)": "ML",
        "Midfielder (Centre)": "MC",
        "Attacking Midfielder (Centre)": "AMC",
        "Winger (Right)": "WR",
        "Winger (Left)": "WL",
        "Second Striker (Centre)": "SS",
        "Striker (Centre)": "CF"
      }
    }),
  props: {
    positions: {
      type: Array
    }
  }
};
</script>


