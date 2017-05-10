<template>
  <div>
    <sidebar />
    <div class="ft-page container-fluid">
      <div class="profile">
        <h4 class="header">{{ mine ? 'Your profile' : 'User Profile' }}</h4>
        <profile :mine="mine"
          :info="info"
          :follow="followUser"/>
      </div>
    </div>
  </div>
</template>

<style lang="sass">
@import "~stylesheets/variables";
.profile {
  .arrow {
    width: 0;
    height: 0;
    margin-right: 20px;
    border-top: 7px solid transparent;
    border-bottom: 7px solid transparent;
    border-left: 7px solid;
    margin-top: 20px;
    border-left-color: $main-header-color;
  }
}

.btn {
  font-size: .9em;
  padding: 5px 20px;
  text-transform: uppercase;
  border: 1px solid $main-text-color;
  &.btn-bright {
    color: $main-text-color;
  }
  &.btn-dark {
    color: #fff;
    background-color: $main-text-color;
  }
 }
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import store from '../store';
import { ASYNC_LOADING, ASYNC_SUCCESS } from '../constants/AsyncStatus';
import NotificationSidebar from '../components/NotificationSidebar.vue';
import Profile from '../components/Profile.vue';

export default {
  name: 'ProfilePage',
  props: ['mine'],
  components: {
    'sidebar': NotificationSidebar,
    'profile': Profile
  },
  computed: {
    ...mapGetters(['token', 'user', 'profile']),
    info() {
      if (!this.$route.params.id) return this.user.value;
      if (this.profile.status === ASYNC_SUCCESS) return this.profile.value;
      return null;
    }
  },
  methods: {
    ...mapActions(['follow', 'unfollow', 'fetchUserInfo', 'clearToken']),
    onRouteChange() {
      if (this.user.status === ASYNC_SUCCESS && parseInt(this.$route.params.id) === this.user.value.id) {
        return this.$router.push({ path: '/profile' });
      }
      if (this.$route.params.id) {
        this.fetchUserInfo({ id: this.$route.params.id });
        this.followUser = this.follow.bind(this, { id: this.$route.params.id });
      }
    }
  },
  watch: {
    '$route': 'onRouteChange'
  },
  mounted() {
    store.watch(() => this.user.status, () => {
      if (this.user.value && this.user.value.id.toString() === this.$route.params.id)
        this.$router.push({ path: '/profile' });
    });
    this.onRouteChange();
  }
}
</script>