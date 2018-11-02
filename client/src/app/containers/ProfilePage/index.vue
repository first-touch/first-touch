<template>
  <div>
    <div class="ft-page">
      <div class="profile">
        <h4 class="header">{{ mine ? 'Your profile' : 'User Profile' }}</h4>
        <profile :mine="mine"
          :info="info"
          :follow="followUser"
          :connect="connectUser"/>
<football-player v-if="info" :footballPlayer="info.football_player"/>
<div class="timeline_div">
          <hr class="slider_hr">
          <h3>CAREER STATISTICS </h3>

      <b-row>


           <b-col md="1" id="mobile_none-sec">
             <img src="http://demourls.xyz/first-touch/left_img.png">
            </b-col>

      <b-col md="4">
         <div class="left_arrow_line2">
           <img src="http://demourls.xyz/first-touch/newpost.png">
           <p>PUBLISHA NEW POST</p>
         </div>
       </b-col>

      <b-col md="4">
         <div class="left_arrow_line2">
           <img src="http://demourls.xyz/first-touch/picture.png">
           <p>PUBLISHA NEW POST</p>
         </div>
       </b-col>


    </b-row>

</div>
<career-history v-if="info" :careerHistory="info.career_history"/>
      </div>
    </div>
     <sidebar />
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

.timeline_div {
    width: 100%;
    margin-top: 35px;
    float: left;
}

hr.slider_hr {
    width: 60px;
    height: 6px;
    border: 0;
    background: #a6cf4c;
    margin: 0;
}

.timeline_div h3 {
    color: #929292;
    font-family: ubuntulight;
    font-size: 18px;
    font-weight: normal;
    margin: 20px 0;
    letter-spacing: 4px;
}

.left_arrow_line2 {
    width: 100%;
    float: left;
}

.left_arrow_line2 img { float:left;}

.timeline_div p {
    width: 66%;
    float: left;
    padding-left: 12px;

}

.time_div1 {
    float: left;
    width: 172px;
    margin-top: 4px;
}

.time_div1_img {
    width: 38px;
    float: left;
    margin-right: 12px;
}

.timeline_div p {
    font-size: 14px;
    font-family: ubuntulight;
    font-weight: normal;
    color: #929292;
    letter-spacing: 4px;
}
.time_div2 {
    float: left;
    width: 172px;
    margin-top: 4px;
}

.time_div2_img {
    width: 38px;
    margin-right: 12px;
    float: left;
}







</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import store from 'app/store';
import { ASYNC_LOADING, ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import NotificationSidebar from 'app/components/NotificationSidebar';

import Profile from './components/Profile';
import CareerHistory from './components/CareerHistory';
import FootballPlayer from './components/FootballPlayer';

export default {
  name: 'ProfilePage',
  props: ['mine'],
  components: {
    sidebar: NotificationSidebar,
    profile: Profile,
    'career-history': CareerHistory,
    'football-player': FootballPlayer,

  },
  computed: {
    ...mapGetters(['token', 'user', 'profile']),
    info() {
      if (!this.$route.params.id) return this.user.value;
      if (this.profile.status === ASYNC_SUCCESS) return this.profile.value;
      return null;
    },
  },
 role() {
    if (this.user.status === ASYNC_SUCCESS) {
    return this.user.value.role_name;
    } else {
    return '';
    }
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
