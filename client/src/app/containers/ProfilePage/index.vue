<template>
  <div>
    <sidebar />
    <div class="ft-page">
      <div class="profile">
        <h4 class="header">{{ mine ? 'Your profile' : 'User Profile' }}</h4>
        <profile :mine="mine"
          :info="info"
          :follow="followUser"
          :connect="connectUser"/>
        <career-history v-if="info" :careerHistory="info.career_history"/>
      </div>
      <misc-container :title="'Language'">
        <ul class="items">
          <li>
            <p class="name">Portugese</p>
            <p class="details">Native or bilingual proficiency</p>
          </li>
          <li>
            <p class="name">English</p>
            <p class="details">Professional working proficiency</p>
          </li>
          <li>
            <p class="name">Spanish</p>
            <p class="details">Professional working proficiency</p>
          </li>
        </ul>
      </misc-container>
      <misc-container :title="'Attributes'">
        <ul class="items">
          <li>
            <div class="score">
              <radial-progress :percentage="'90'" :score="9"/>
              <p class="name">Passing</p>
            </div>
            <p class="details">Lorem ipsum dolor sit amet.</p>
          </li>
          <li>
            <div class="score">
              <radial-progress :percentage="'70'" :score="7"/>
              <p class="name">Shooting</p>
            </div>
            <p class="details">Lorem ipsum dolor sit amet.</p>
          </li>
        </ul>
      </misc-container>
      <misc-container :title="'Certificates and qualifications'">
        <ul class="items">
          <li>
            <p class="name">Lorem Ipsum</p>
            <p class="details">Lorem ipsum dolor sit amet.</p>
          </li>
          <li>
            <p class="name">Lorem Ipsum</p>
            <p class="details">Lorem ipsum dolor sit amet.</p>
          </li>
          <li>
            <p class="name">Lorem Ipsum</p>
            <p class="details">Lorem ipsum dolor sit amet.</p>
          </li>
        </ul>
      </misc-container>
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

.btn {
  font-size: 0.9em;
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

.items {
  li {
    display: flex;
    justify-content: space-between;
    padding-top: 15px;

    &:not(:last-of-type) {
      border-bottom: 1px solid #ddd;
      padding-bottom: 15px;
    }
    .name,
    .details {
      color: $main-text-color;
      margin-bottom: 0;
    }
    .name {
      text-transform: uppercase;
    }
    .score {
      display: flex;
      align-items: center;

      & + .details {
        display: flex;
        align-items: center;
      }

      .radial-progress {
        margin-right: 20px;
      }
    }
  }
}
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import store from 'app/store';
import { ASYNC_LOADING, ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import NotificationSidebar from 'app/components/NotificationSidebar';
import Profile from './components/Profile';
import CareerHistory from './components/CareerHistory';
import MiscContainer from './components/MiscContainer';
import RadialProgress from 'app/components/RadialProgress';

export default {
  name: 'ProfilePage',
  props: ['mine'],
  components: {
    sidebar: NotificationSidebar,
    profile: Profile,
    'career-history': CareerHistory,
    'misc-container': MiscContainer,
    'radial-progress': RadialProgress,
  },
  computed: {
    ...mapGetters(['token', 'user', 'profile']),
    info() {
      if (!this.$route.params.id) return this.user.value;
      if (this.profile.status === ASYNC_SUCCESS) return this.profile.value;
      return null;
    },
  },
  methods: {
    ...mapActions([
      'follow',
      'unfollow',
      'fetchUserInfo',
      'clearToken',
      'connect',
    ]),
    followUser() {},
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