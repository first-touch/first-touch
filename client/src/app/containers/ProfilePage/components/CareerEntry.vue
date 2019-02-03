<template>
  <div class="career-entry-wrapper">
    <div class="career-events-left-logo">
      <img class="logo" :src="careerEntry.club.club_logo" />
    </div>
    <div class="career-events-center">
      <h5 class="career-events-one">{{ careerEntry.club.name }}</h5>
      <h5 class="career-events-two">{{ careerEntry.club.country_code }}</h5>
    </div>
    <div class="career-events-right">
      <h5 class="career-events-one">{{ startDate }} - {{ endDate }}</h5>
      <h5 class="career-events-two">Apps 200 | Scored 30</h5>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .career-events-left-logo {
    display: inline-block;
    width: 15%;
    vertical-align: top;
    img {
      width: 60%;
    }
  }

  .career-events-center {
    display: inline-block;
    width: 34%;
    vertical-align: top;
  }

  .career-events-right {
    display: inline-block;
    width: 48%;
    vertical-align: top;
    text-align: right;
  }
</style>

<script>
import moment from 'moment';

export default {
  name: 'CareerEntry',
  props: ['careerEntry'],
  computed: {
    startDate() {
      return moment(this.careerEntry.start_date).format("YYYY-MM-DD");
    },
    endDate() {
      if (!this.careerEntry.end_date) { return "Present" };
      return moment(this.careerEntry.end_date).format("YYYY-MM-DD");
    }
  }
}
</script>
