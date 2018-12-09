<template>
  <timeline-item>
    <div class="m-profile-card">
      <div class="avatar-wrapper">
        <img class="img-fluid avatar" :src="profile.club_logo" />
      </div>
      <div class="info">
        <h4 class="name"> {{ profile.name }} </h4>
        <info-detail detailTitle="Founded" :detailContent="profile.date_founded" />
        <info-detail detailTitle="Location" :detailContent="profile.city" />
        <info-detail detailTitle="Founded" :detailContent="profile.address" />
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
    <h4 class="upper-cased main-color spaced-title">Summary</h4>
    <div class="m-profile-card vertical">
      <info-detail detailTitle="League Competition" detailContent="TBA" />
      <info-detail detailTitle="Cup Competition" detailContent="TBA" />
      <info-detail detailTitle="Stadium" :detailContent="profile.stadium_name" />
      <info-detail detailTitle="Home Kit Color" :detailContent="profile.home_kit_color" />
      <info-detail detailTitle="Away Kit Color" :detailContent="profile.away_kit_color" />
      <info-detail detailTitle="Third Kit Color" :detailContent="profile.third_kit_color" />
    </div>
  </timeline-item>
</template>

<script>
import { mapActions, mapGetters } from 'vuex';
import TimelineItem from 'app/components/TimelineItem';
import ContactDetail from './ContactDetail';
import InfoDetail from './InfoDetail';

export default {
  name: 'ClubProfile',
  props: ['clubId'],
  components: {
    'timeline-item': TimelineItem,
    'contact-detail': ContactDetail,
    'info-detail': InfoDetail
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
