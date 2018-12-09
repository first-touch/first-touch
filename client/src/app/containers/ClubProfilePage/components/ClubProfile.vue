<template>
  <timeline-item>
    <div class="m-full-profile">
      <img class="img-fluid avatar" :src="profile.club_logo" />
      <div class="info">
        <h4 class="name"> {{ profile.name }} </h4>
        <p class="detail">
          <span class="detail-title">Founded</span>
          {{ profile.date_founded }}
        </p>

        <p class="detail">
          <span class="detail-title">Location</span>
          {{ profile.city }}, {{ profile.country_code }}
        </p>

        <p class="detail">
          <span class="detail-title">Address</span>
          {{ profile.address }}
        </p>
      </div>
    </div>
    <hr />
    <div class="m-full-profile">
      <div class="info">
        <p class="detail">
          <span class="detail-title">Founded</span>
          {{ profile.date_founded }}
        </p>
        <p class="detail">
          <span class="detail-title">Founded</span>
          {{ profile.date_founded }}
        </p>
        <p class="detail">
          <span class="detail-title">Founded</span>
          {{ profile.date_founded }}
        </p>
        <p class="detail">
          <span class="detail-title">Founded</span>
          {{ profile.date_founded }}
        </p>
        <p class="detail">
          <span class="detail-title">Founded</span>
          {{ profile.date_founded }}
        </p>
      </div>
    </div>
    <hr />
    <div class="m-full-profile">
      <div class="summary info">
        <h5 class="summary-title">Summary</h5>
        <p class="detail">
          <span class="detail-title">Founded</span>
          {{ profile.date_founded }}
        </p>
        <p class="detail">
          <span class="detail-title">Founded</span>
          {{ profile.date_founded }}
        </p>
        <p class="detail">
          <span class="detail-title">Founded</span>
          {{ profile.date_founded }}
        </p>
        <p class="detail">
          <span class="detail-title">Founded</span>
          {{ profile.date_founded }}
        </p>
        <p class="detail">
          <span class="detail-title">Founded</span>
          {{ profile.date_founded }}
        </p>
        <p class="detail">
          <span class="detail-title">Founded</span>
          {{ profile.date_founded }}
        </p>
      </div>
    </div>
  </timeline-item>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import TimelineItem from 'app/components/TimelineItem';

export default {
  name: 'ClubProfile',
  props: ['clubId'],
  components: {
    'timeline-item': TimelineItem,
  },
  methods: {
    ...mapActions(['getClubProfile']),
  },
  computed: {
    ...mapGetters(['clubProfile']),
    profile() {
      return this.clubProfile.value;
    }
  },
  mounted() {
    this.getClubProfile(this.clubId);
  }
};
</script>
