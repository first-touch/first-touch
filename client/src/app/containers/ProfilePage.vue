<template>
  <div>
    <sidebar />
    <div class="ft-page container-fluid">
      <div class="profile">
        <h4 class="header">{{ mine ? 'Your profile' : 'User Profile' }}</h4>
        <profile :mine="mine"
          :following="following"
          :follow="follow"/>
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
import { mapGetters } from 'vuex';
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
  data() {
    return {
      following: false
    }
  },
  computed: {
    ...mapGetters(['token', 'user'])
  },
  methods: {
    follow() {
      fetch(`/api/v1/relationships`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          Authorization: this.token.value
        },
        body: `followed_id=${this.$route.params.id}`
      }).then((res) => {
        if (res.status === 200) this.following = true;
        else res.json().then(console.log);
      });
    }
  },
  mounted() {
    store.watch(() => this.user.status, () => {
      if (this.user.value && this.user.value.id.toString() === this.$route.params.id)
        this.$router.push({ path: '/profile' });
    });
  }
}
</script>