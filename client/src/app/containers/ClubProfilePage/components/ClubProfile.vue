<template>
  <timeline-item>
    <!-- <div class="profile-item-container" v-if="info">
      <div class="top">
        <img class="img-fluid avatar" :src="info.personal_profile.avatar_url" />
        <div class="info">
          <h4 class="name">{{ info.personal_profile.first_name }} {{ info.personal_profile.last_name }}</h4>
          <p class="role">Football Player</p>
          <p class="club">Real Madrid FC, Spain</p>
          <p class="detail">
            <span class="detail-title">Date of birth</span>
            {{ info.personal_profile.birthday }}
          </p>
          <p class="detail">
            <span class="detail-title">Nationality</span>
            {{ info.personal_profile.nationality_country_code }}
          </p>
          <p class="detail">
            <span class="detail-title">Place of birth</span>
            {{ info.personal_profile.place_of_birth }}
          </p>
          <div class="widget">
            <div class="widget-row">
              <router-link v-if="mine" to="/profile/edit" class="btn btn-bright">Edit Profile</router-link>
              <a v-else-if="!info.following" @click.prevent="follow" href="#" class="btn btn-bright">+ Follow</a>
              <a v-else-if="info.following" class="btn btn-dark">&#10003; Following</a>
              <a v-if="!mine && info.connection_status === 'not_connected'"
                @click.prevent="connect" class="btn btn-bright">
                Connect
              </a>
              <a v-else-if="!mine && info.connection_status === 'pending'"
                class="btn btn-dark">&sim; Pending
              </a>
              <a v-else-if="!mine && info.connection_status === 'connected'"
                class="btn btn-dark">&#10003; Connected
              </a>
              <router-link v-if="!mine" :to="`/messages/${info.id}`" class="btn btn-bright">Message</router-link>
            </div>
            <div class="widget-row">
              <p class="connection"><span class="number">467</span> Connections</p>
            </div>
          </div>
        </div>
      </div>
      <hr />
      <div class="bottom">
        <div class="summary">
          <h5 class="summary-title">Summary</h5>
          <p class="summary-field name">{{ info.personal_profile.first_name }} {{ info.personal_profile.middle_name }} {{ info.personal_profile.last_name }}</p>
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
          <a href="#" class="btn btn-bright">Biography</a>
        </div>
      </div>
    </div> -->
  </timeline-item>
</template>

<script>
import TimelineItem from 'app/components/TimelineItem';

export default {
  name: 'ClubProfile',
  components: {
    'timeline-item': TimelineItem,
  },
};
</script>
