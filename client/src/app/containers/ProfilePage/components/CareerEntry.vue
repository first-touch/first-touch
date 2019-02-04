<template>
  <div class="career-entry-wrapper flex-row">
    <div class="avatar-wrapper">
      <img class="avatar" :src="careerEntry.club.club_logo" />
    </div>
    <div class="club-info-wrapper">
      <h5>{{ careerEntry.club.name }}</h5>
      <p>{{ clubInfo }}</p>
    </div>
    <div class="date-info-wrapper">
      <h5>{{ startDate }} - {{ endDate }}</h5>
      <p> Apps <span class="value">200</span> | Scored <span class="value">30</span></p>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .career-entry-wrapper {
    justify-content: space-between;

    .avatar-wrapper, .club-info-wrapper, .date-info-wrapper {
      width: 33%;
      margin-bottom: auto;
      margin-top: auto;
    }

    .avatar-wrapper {
      .avatar {
        max-width: 50%;
        margin-left: 25%;
      }
    }

    .date-info-wrapper {
      .value {
        font-weight: bold;
      }
    }
  }
</style>

<script>
import moment from 'moment';
import countrydata from 'country-data';

export default {
  name: 'CareerEntry',
  props: ['careerEntry'],
  computed: {
    startDate() {
      return moment(this.careerEntry.start_date).format("MMM YYYY");
    },
    endDate() {
      if (!this.careerEntry.end_date) { return "Present" };
      return moment(this.careerEntry.end_date).format("MMM YYYY");
    },
    clubInfo() {
      let clubCountry = countrydata.countries[this.careerEntry.club.country_code];
      let clubInfoParts = [this.careerEntry.club.city, clubCountry.name];
      return _.compact(clubInfoParts).join(', ');
    }
  }
}
</script>
