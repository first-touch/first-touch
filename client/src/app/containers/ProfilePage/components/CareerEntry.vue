<template>
  <div class="career-entry-wrapper row">
    <div class="col-2 avatar-wrapper">
      <div class="avatar img-responsive img-circle" v-bind:style="{ 'background-image': 'url('+careerEntry.club.club_logo+')' }"></div>
    </div>
    <div class="club-info-wrapper col-5">
      <p class="text-left text-truncate">
        {{ careerEntry.club.name }} <br>
        {{ clubInfo }}
      </p>
    </div>
    <div class="date-info-wrapper col-5">
      <p>
        {{ startDate }} - {{ endDate }} <br>
        A: <span class="value">200</span> | G: <span class="value">30</span>
      </p>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .date-info-wrapper {
    .value {
      font-weight: bold;
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
      return moment(this.careerEntry.start_date).format("MMM YY");
    },
    endDate() {
      if (!this.careerEntry.end_date) { return "Present" };
      return moment(this.careerEntry.end_date).format("MMM YY");
    },
    clubInfo() {
      let clubCountry = countrydata.countries[this.careerEntry.club.country_code];
      let clubInfoParts = [this.careerEntry.club.city, clubCountry.name];
      return _.compact(clubInfoParts).join(', ');
    }
  }
}
</script>
