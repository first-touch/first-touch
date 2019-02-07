<template>
  <div>
    <!-- <sidebar /> -->
    <div class="ft-page">
      <div class="profile">
        <h4 class="spaced-title upper-cased main-color">Club Profile</h4>
        <club-profile :clubId="currentClubId" />
      </div>
    </div>
  </div>
</template>
<script>

import { mapGetters } from 'vuex';
import NotificationSidebar from 'app/components/NotificationSidebar';
import Profile from './components/ClubProfile';

export default {
  name: 'ClubProfile',
  components: {
    sidebar: NotificationSidebar,
    "club-profile": Profile
  },
  computed: {
    ...mapGetters(['userClubId']),
    currentClubId() {
      return this.$route.params.id || this.userClubId;
    }
  }
};
</script>
