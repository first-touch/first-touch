<template>
  <timeline-item>
    <h4 class="title">Career History</h4>
    <div class="section">
      <h5 class="section-title">Senior Career</h5>
      <div class="section-item" v-for="item in careerHistory" :key="item.id">
        <div class="team">
          <div class="logo-holder">
            <img class="logo" src="https://vignette4.wikia.nocookie.net/logopedia/images/a/a6/Real-Madrid.png/revision/20160711131706"
            />
          </div>
          <div class="team-info">
            <h5 class="name">{{ item.club.name }}</h5>
            <h6 class="location">{{ item.club.city }}, {{ item.club.country_code }}</h6>
          </div>
        </div>
        <div class="info">
          <div>
            <p class="duration">
              {{ (new Date(item.start_date)).getFullYear() }} - {{ item.end_date ? (new Date(item.end_date)).getFullYear() : "Present"
              }}
            </p>
            <p class="stats">
              App
              <span class="app">265</span>
              | Gls
              <span class="gls">285</span>
            </p>
          </div>
        </div>
      </div>
    </div>
    <!-- <div class="section">
      <h5 class="section-title">National Team</h5>
    </div> -->
    <div class="btn-holder">
      <a class="btn btn-bright">Career Statistics</a>
      <a class="btn btn-bright">Match Statistics</a>
    </div>
  </timeline-item>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .title {
    color: $secondary-text-color;
    text-transform: uppercase;
    margin-bottom: 50px;
  }

  .section {
    &:not(:last-child) {
      margin-bottom: 50px;
    }
    .section-title {
      color: $secondary-text-color;
      text-transform: uppercase;
      font-weight: 300;
    }
    .section-item {
      padding: 20px 0;
      display: flex;
      justify-content: space-between;
      &:not(:last-child) {
        border-bottom: 1px solid $secondary-text-color;
      }
      .team {
        display: flex;
        align-items: center;
        .name {
          text-transform: uppercase;
        }
        .logo-holder {
          height: 100px;
          width: 100px;
          display: flex;
          justify-content: center;
        }
        .logo {
          max-height: 100px;
          max-width: 100px;
        }
        .team-info {
          margin-left: 20px;
          color: $secondary-text-color;
        }
      }
      .info {
        display: flex;
        align-items: center;
        color: $secondary-text-color;
        .duration,
        .stats {
          margin-bottom: 0.1rem;
        }
        .duration,
        .app,
        .gls {
          font-weight: bold;
        }
      }
      &:hover {
        .team .name,
        .duration,
        .app,
        .gls {
          color: #000;
        }
      }
    }
  }

  .btn-holder {
    display: flex;
    justify-content: flex-end;
  }
</style>

<script>
  import TimelineItem from 'app/components/TimelineItem';

  export default {
    name: 'CareerHistory',
    components: {
      'timeline-item': TimelineItem,
    },
    props: ['careerHistory'],
  };
</script>
