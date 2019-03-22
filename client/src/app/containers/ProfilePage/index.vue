<template>
  <div>
    <div class="ft-page">
      <div class="profile">
        <profile :mine="mine"
          :info="info"
          :connect="connectUser"/>
      </div>
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
import Profile from './components/Profile';

export default {
  name: 'ProfilePage',
  props: ['mine'],
  components: {
    sidebar: NotificationSidebar,
    profile: Profile
  },
  computed: {
    ...mapGetters(['user', 'profile']),
    info() {
      if (!this.$route.params.id) return this.user.value;
      if (this.profile.status === ASYNC_SUCCESS) return this.profile.value;
      return null;
    }
  },
  methods: {
    ...mapActions([
      'fetchUserInfo',
      'connect',
    ]),
    connectUser() {},
    onRouteChange() {
      if (
        this.user.status === ASYNC_SUCCESS &&
        parseInt(this.$route.params.id) === this.user.value.id
      ) {
        return this.$router.push({ path: '/profile' });
      }
      if (this.$route.params.id) {
        this.fetchUserInfo({ id: this.$route.params.id });
        this.followUser = this.follow.bind(this, { id: this.$route.params.id });
        this.connectUser = this.connect.bind(this, {
          id: this.$route.params.id,
        });
      }
    },
  },
  watch: {
    $route: 'onRouteChange',
  },
  mounted() {
    store.watch(
      () => this.user.status,
      () => {
        if (
          this.user.value &&
          this.user.value.id.toString() === this.$route.params.id
        )
          this.$router.push({ path: '/profile' });
      },
    );
    this.onRouteChange();
  },
};
</script>
