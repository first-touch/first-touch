<template>
  <div>
    <div class="ft-page container">
      <h4 class="spaced-title upper-cased main-color page-title mb-5">
        <span v-if="mine">Your Profile</span>
        <span v-else>Profile</span>
      </h4>
      <timeline-item>
        <component
          :is="userRoleProfile"
          :user="userProfile"
          :mine="mine"
          :connectionStatus="connectionStatus"
          class="profile" />
      </timeline-item>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.profile {
  .arrow {
    width: 0;
    height: 0;
    margin-right: 20px;
    border-top: 7px solid transparent;
    border-bottom: 7px solid transparent;
    border-left: 7px slid;
    margin-top: 20px;
    border-left-color: $main-header-color;
  }
}
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import store from 'app/store';
import { ASYNC_LOADING, ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import TimelineItem from 'app/components/TimelineItem';
import PlayerProfile from './components/profiles/Player';
import DirectorProfile from './components/profiles/Director';
import ScoutProfile from './components/profiles/Scout';
import AgentProfile from './components/profiles/Agent';

export default {
  name: 'ProfilePage',
  props: ['mine', 'accept_invitation', 'id'],
  components: {
    PlayerProfile,
    ScoutProfile,
    DirectorProfile,
    AgentProfile,
    TimelineItem
  },
  computed: {
    ...mapGetters(['user', 'profile']),
    userRoleProfile() {
      if (!this.userProfile) { return undefined; }
      return this.userProfile.role_name + '-profile';
    },
    userProfile() {
      if (!this.id) return this.user.value;
      if (this.profile.status === ASYNC_SUCCESS) return this.profile.value;
      return undefined;
    },
    connectionStatus() {
      if (!this.userProfile) { return undefined; }
      return this.userProfile.connection_status;
    }
  },
  methods: {
    ...mapActions([
      'fetchUserInfo',
      'acceptInvitation'
    ]),
    setUserProfile() {
      if (this.user.status === ASYNC_SUCCESS && parseInt(this.id) === this.user.value.id) {
        return this.$router.push({ path: '/profile' });
      }
      if (this.id) {
        this.fetchUserInfo({ id: this.id });
      }
    }
  },
  mounted() {
    this.setUserProfile()
    if(this.accept_invitation) {
      this.acceptInvitation({ id: this.accept_invitation });
    }
  },
  watch: {
    $route: 'setUserProfile',
  }
};
</script>
