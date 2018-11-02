<template>
<div class="ft-page timeline">
  <h4 class="header">Your Profile</h4>
  <div class="result-container">
    <button class="btn back">
    </button>
    <div class="results">
      <div class="single-result">
        <h5 class="title">Recent Result<br/>Win</h5>
        <div class="info">
          <div class="team">
            <img class="img-fluid" src="https://upload.wikimedia.org/wikipedia/en/thumb/7/7c/Toronto_FC_Logo.svg/1095px-Toronto_FC_Logo.svg.png"/>
            <h2 class="score">4</h2>
          </div>
          <h4 class="vs">vs</h4>
          <div class="team">
            <img class="img-fluid" src="https://upload.wikimedia.org/wikipedia/en/thumb/7/7c/Toronto_FC_Logo.svg/1095px-Toronto_FC_Logo.svg.png"/>
            <h2 class="score">4</h2>
          </div>
        </div>
      </div>
      <div class="single-result">
        <h5 class="title">Next Match<br/>Versus</h5>
        <div class="info">
          <div class="team">
            <img class="img-fluid" src="https://upload.wikimedia.org/wikipedia/en/thumb/7/7c/Toronto_FC_Logo.svg/1095px-Toronto_FC_Logo.svg.png"/>
            <h2 class="score">Kick Ass FC</h2>
          </div>
          <h4 class="vs">At</h4>
          <div class="team">
            <img class="img-fluid" src="https://cdn4.iconfinder.com/data/icons/houses/154/stadium-arena-sport-complex-rome-512.png"/>
            <h2 class="score">Away</h2>
          </div>
        </div>
      </div>
    </div>
    <button class="btn next">
    </button>
  </div>
</div>
</template>
<style lang="scss">
@import '~stylesheets/variables';
.ft-page {
  min-height: 0;
     
}
.result-container {
  padding: 20px auto;
  max-width: 100%;
  display: flex;
  position: relative;
  *:not(:last-child) {
    margin-right: 5px;

  }
  .btn {
    flex: 0 1 5%;
    background: #404040;
    .img-fluid {
      width: 100%;
    }
    &.back {
      background: url('/images/back.svg') no-repeat center center;
      background-size: contain;
    }
    &.next {
      background: url('/images/next.svg') no-repeat center center;
      background-size: contain;
    }
  }
  .results {
    display: flex;
    .single-result {
      padding: 20px;
      display: flex;
      flex-direction: column;
      flex: 0 0 calc(50% - 2.5px);
      background: #fff;
      border-radius: 5px;
      .title {
        color: $main-text-color;
        text-transform: uppercase;
      }
      .info {
        display: flex;
        .vs {
          padding-top: 30px;
          color: $main-text-color;
          text-transform: uppercase;
        }
        .score {
          margin-top: 20px;
          color: $main-header-color;
          text-align: center;
        }
      }
    }
  }
}
</style>
<script>
export default {
  name: 'MatchResult',
};
</script>

