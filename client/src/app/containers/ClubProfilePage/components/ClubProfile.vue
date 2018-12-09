<template>
  <timeline-item>
    <div class="m-profile-card">
      <div class="avatar-wrapper">
        <img class="img-fluid avatar" :src="profile.club_logo" />
      </div>
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
    <div class="m-profile-card">
      <contact-detail contactTitle="Official Website" :contactDetail="profile.website" />
      <contact-detail contactTitle="Facebook" :contactDetail="profile.facebook_link" />
      <contact-detail contactTitle="Twitter" :contactDetail="profile.twitter_handle" />
      <contact-detail contactTitle="Email" :contactDetail="profile.email" />
    </div>
    <hr />
    <div class="m-profile-card">
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
import ContactDetail from './ContactDetail';

export default {
  name: 'ClubProfile',
  props: ['clubId'],
  components: {
    'timeline-item': TimelineItem,
    'contact-detail': ContactDetail
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
