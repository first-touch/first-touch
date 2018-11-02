<template>
  <div>
    <div class="sidenav-left">
      <router-link class="brand" to="/">
        <img class="img-fluid" src="/images/landing-page/ft-navbar-logo.png" alt="Ft Logo" />
      </router-link>
      <div class="profile">
        <img class="rounded-circle img-fluid" src="https://static.independent.co.uk/s3fs-public/thumbnails/image/2018/08/31/07/Cristiano-Ronaldo.jpg"/>
        <h2 class="profile-name">{{ firstname }}</h2>
        <h2 class="profile-name">{{ lastname }}</h2>
        <h5 class="profile-role">{{role}}</h5>
        <h5 class="profile-club">real madrid</h5>
        <router-link to="/profile/edit" class="profile-edit-button">Edit Profile</router-link>
        <router-link to="/club" v-if="club" class="profile-edit-button">My clubs</router-link>

      </div>
      <ul class="nav-list">
        <li class="nav-item" :class="{ active: page === 'home'  && submenu == -1 }">
          <div class="nav-item-inner" @click="setMenu(-1)">
            <router-link to="/">Home</router-link>
          </div>
        </li>
        <li class="nav-item" :class="{ active: page === 'profile'  && submenu == -1 }">
          <div class="nav-item-inner" @click="setMenu(-1)">
            <router-link to="/profile">Profile</router-link>
          </div>
        </li>
        <li class="nav-item" :class="{ active: page === 'calendar' && submenu == -1 }">
          <div class="nav-item-inner" @click="setMenu(-1)">
            <router-link to="/calendar">Calendar</router-link>
          </div>
        </li>
        <li class="nav-item" :class="{ active: page === 'messages'  && submenu == -1 }">
          <div class="nav-item-inner" @click="setMenu(-1)">
            <router-link to="/messages">Messages</router-link>
          </div>
        </li>
        <li class="nav-item" :class="{ active: page === 'network' && submenu == -1}">
          <div class="nav-item-inner" @click="setMenu(-1)">
            <router-link to="/network">My Network</router-link>
          </div>
        </li>
        <li class="nav-item" v-if="scout" :class="{ active: scoutingPage() }">
          <div class="nav-item-inner submenu" @click="setMenu(0)">
            Scouting
          </div>
          <ul class="sub-nav">
            <li class="sub-nav-item" :class="{ active: page === '/scouting/report/create' || !page }">
              <router-link :to="{ name: 'scoutReportCreate'}">Create Report</router-link>
            </li>
            <li class="sub-nav-item" :class="{ active: page === '/scouting/jobs/list' || !page }">
              <router-link :to="{ name: 'scoutJobsList'}">Jobs List</router-link>
            </li>
            <li class="sub-nav-item" :class="{ active: page === '/scouting/jobs/bank' || !page }">
              <router-link :to="{ name: 'scoutJobsBank'}">Jobs Bank</router-link>
            </li>
            <li class="sub-nav-item" :class="[{active: page === '/scouting/payment' || !page },{'error':!hasBankAccount}]">
              <router-link :to="{ name: 'scoutPaymentDetailPage'}">Payment Details</router-link>
            </li>

          </ul>
        </li>
      </ul>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
@import '~stylesheets/common_style';

.sidenav-left {
  .brand {
    margin: 0 0 15px 0;
  }
  .profile {
    margin: 15px 0;
    * {
      margin: 10px 0;
    }
    .img-fluid {

    max-width: 31%;
    height: 73px;


    }

  .profile-name {
      font-size: 20px;
    color: #adda4e;
    letter-spacing: 8px;
    font-weight: normal;
}
    .profile-club,
    .profile-role {
      color: $secondary-text-color;
      font-weight: 300;
      text-transform: capitalize;
      font-size: 1em;
    }
    .profile-edit-button {
      border: 1px solid $secondary-text-color;
      border-radius: 4px;
      background-color: transparent;
      text-transform: uppercase;
      font-size: 0.85em;
      padding: 5px 20px;
      color: $secondary-text-color;
      &:hover {
        text-decoration: none;
      }
    }
  }

  .nav-list {
    padding-left: 0;
    margin: 15px 0 15px -20px;
    display: flex;
    flex-direction: column;
    .nav-item {
        .sub-nav {
          max-height: 0;
          overflow: hidden;
          background-color: $main-text-color;
          margin-left: 7px;
          display: flex;
          flex-direction: column;
          .sub-nav-item {
            padding: 10px 0 10px 20px;
            font-weight: 300;
            text-transform: uppercase;
            &.error {
              a {
                color: red;
              }
            }
            &:not(:last-child) {
              border-bottom: 1px solid $navbar-background-color;
            }
            &.active  {
              .submenu, .router-link-active {
                color: $main-header-color;
              }
            }
            a, .submenu, {
              color: #fff;
              text-decoration: none;
            }
          }
          transition: max-height 1s;
        }

      .nav-item-inner {
      text-transform: uppercase;
      font-weight: 300;
      font-size: $left-menu-text-size;
      margin: 0 0 0 20px;
      padding: 10px 0 10px 7px;
      border-top: 1px solid $main-text-color;
                &.submenu {
            cursor: pointer;
          }
      &:hover {
        background: #5e5e5e;
        cursor: pointer;
      }
      &.submenu, a {
        color: $main-text-color;
      }
      a:hover,
      a:focus {
        text-decoration: none;
      }
    }
  }

    .nav-item:last-child .nav-item-inner {
      border-bottom: 1px solid $main-text-color;
    }

    .nav-item.active {
      border-left: 7px solid $main-header-color;
      .sub-nav {
        max-height: 400px;
      }
      .nav-item-inner {
        margin-left: 13px;
      }
      a, .submenu {
        color: $main-header-color;
      }
    }
  }
}

@media screen and (max-width: 768px) {



  .sidenav-left{
           height: 130vh;}




}




</style>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_LOADING,
    ASYNC_SUCCESS
  } from '../../../constants/AsyncStatus';

export default {
  name: 'UserNavbar',
  props: ['page'],
  data() {
    return {
      submenu: -1
    };
  },
  computed: {
    ...mapGetters(['token', 'user']),
    name() {
      if (this.user.status === ASYNC_SUCCESS) {
        return `${this.user.value.personal_profile.first_name} ${
          this.user.value.personal_profile.last_name
        }`;
      } else {
        return '';
      }
    },
   firstname() {
      if (this.user.status === ASYNC_SUCCESS) {
        return `${this.user.value.personal_profile.first_name}`;
      } else {
        return '';
      }
    },
   lastname() {
      if (this.user.status === ASYNC_SUCCESS) {
        return `${
          this.user.value.personal_profile.last_name
        }`;
      } else {
        return '';
      }
    },
          club(){
        if (this.token.clubs && this.token.clubs.length > 0)
          return true;
        return false
      },
            hasBankAccount() {
        if (this.user.status === ASYNC_SUCCESS) {
          return (this.user.value.has_bank_account)
        }
        return false;
      },
    role() {
      if (this.user.status === ASYNC_SUCCESS) {
        return this.user.value.role_name;
      } else {
        return '';
      }
    },
          scout() {
        return this.role == 'scout';
      },
    isCoach() {
      return (
        this.user.status === ASYNC_SUCCESS &&
        this.user.value.role_name === 'coach'
      );
    }
  },
    methods: {
      ...mapActions(['getUserInfo', 'logout']),
      setMenu(id) {
        this.submenu = id;
      },
      scoutingPage() {
        if (/scouting\//.test(this.page) || this.submenu == 0) return true;
        return false;
      }
    },
  mounted() {
    if (this.token.status !== ASYNC_SUCCESS) {
      this.getUserInfo({ token: this.token.value });
    }
  }
};
</script>
