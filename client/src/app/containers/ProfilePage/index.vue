<template>
  <div>
    <div class="ft-page">
      <component v-bind:is="userRoleProfile" :user="userProfile" class="profile"></component>
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
import NotificationSidebar from 'app/components/NotificationSidebar';
import PlayerProfile from './components/PlayerProfile';

export default {
  name: 'ProfilePage',
  props: ['mine'],
  components: {
    sidebar: NotificationSidebar,
    'player-profile': PlayerProfile
  },
  computed: {
    ...mapGetters(['user', 'profile']),
    userRoleProfile() {
      if (!this.userProfile) { return undefined; }
      return this.userProfile.role_name + '-profile';
    },
    userProfile() {
      if (!this.$route.params.id) return this.user.value;
      if (this.profile.status === ASYNC_SUCCESS) return this.profile.value;
      return undefined;
    },
  },
  methods: {
    ...mapActions([
      'fetchUserInfo'
    ]),
    setUserProfile() {
      if (this.user.status === ASYNC_SUCCESS && parseInt(this.$route.params.id) === this.user.value.id) {
        return this.$router.push({ path: '/profile' });
      }
      if (this.$route.params.id) {
        this.fetchUserInfo({ id: this.$route.params.id });
      }
    }
  },
  mounted() {
    this.setUserProfile()
  },
  watch: {
    $route: 'setUserProfile',
  }
};
</script>
