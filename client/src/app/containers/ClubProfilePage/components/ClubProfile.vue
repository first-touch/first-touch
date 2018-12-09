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
      <hr />

      <hr />
      <div class="summary">
        <h5 class="summary-title">Summary</h5>
        <!-- <p class="summary-field name">{{ info.personal_profile.first_name }} {{ info.personal_profile.middle_name }} {{ info.personal_profile.last_name }}</p>
        <p class="summary-field">
          <span class="summary-field-title">Height</span>
          {{ info.personal_profile.height }} cm
        </p>
        <p class="summary-field">
          <span class="summary-field-title">Weight</span>
          {{ info.personal_profile.weight }} kg
        </p>
        <p class="summary-field">
          <span class="summary-field-title">Preferred Foot:</span>
          {{ info.personal_profile.preferred_foot }}
        </p>
        <p class="summary-field">
          <span class="summary-field-title">Pro Status:</span>
          {{ info.personal_profile.pro_status || "N/a"}}
        </p>
        <p class="summary-field">
          <span class="summary-field-title"># Caps:</span>
          {{ info.personal_profile.total_caps || "0" }}
        </p>
        <a href="#" class="btn btn-bright">Biography</a> -->
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
