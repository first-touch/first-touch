<template>
  <div>
    <div class="sidenav-left">
      <router-link class="brand" to="/">
        <img class="img-fluid" src="/images/landing-page/ft-navbar-logo.png" alt="Ft Logo" />
      </router-link>
      <div class="m-profile">
        <img class="rounded-circle img-fluid avatar" src="https://upload.wikimedia.org/wikipedia/en/thumb/7/7c/Toronto_FC_Logo.svg/1095px-Toronto_FC_Logo.svg.png" >
        <h4 class="profile-name">{{clubName}}</h4>
        <router-link to="/" class="a-sidebar-button">My profile</router-link>
      </div>
      <ul class="nav-list">
        <li class="nav-item">
          <div class="nav-item-inner">
            <router-link to="/club"> Dashboard </router-link>
          </div>
        </li>
        <li class="nav-item" :class="{ active: tab[0] }">
          <div class="nav-item-inner" @click="onTabClick(0)">
            Channel
          </div>
          <ul class="sub-nav">
            <li class="sub-nav-item" :class="{ active: page === 'channel' || !page }">
              <router-link to="/club">Stream</router-link>
            </li>
            <li class="sub-nav-item" :class="{ active: page === 'profile' }">
              Profile
            </li>
            <li class="sub-nav-item" :class="{ active: page === 'calendar' }">
              Calendar
            </li>
            <li class="sub-nav-item" :class="{ active: page === 'messages' }">
              Messages
            </li>
            <li class="sub-nav-item" :class="{ active: page === 'notes' }">
              <router-link to="/club/notes">Notes</router-link>
            </li>
          </ul>
        </li>
        <li class="nav-item" :class="{ active: tab[1] }">
          <div class="nav-item-inner" @click="onTabClick(1)">
            Team
          </div>
          <ul class="sub-nav">
            <li class="sub-nav-item">Performance</li>
            <li class="sub-nav-item">Competition</li>
            <li class="sub-nav-item">Players</li>
            <li class="sub-nav-item">Coach</li>
          </ul>
        </li>
        <li class="nav-item" :class="{ active: tab[2] || /\/club\/scouting/.test(page) || /\/club\/request/.test(page) }">
          <div class="nav-item-inner nav-item-inner-link" @click="onTabClick(2);">
            Scouting
          </div>
          <ul class="sub-nav">
            <li class="sub-nav-item" :class="{ active: page === '/club/scouting/report/marketplace' || !page }">
              <router-link :to="{ name: 'clubReportMarketplace'}">MarketPlace</router-link>
            </li>
            <li class="sub-nav-item" :class="{ active: page === '/club/scouting/request' || !page }">
              <router-link :to="{ name: 'clubRequestList'}">Assignments</router-link>
            </li>
            <li class="sub-nav-item" :class="{ active: page === '/club/scouting/report/list' || !page }">
              <router-link :to="{ name: 'clubReportList'}">Reports</router-link>
            </li>
            <li class="sub-nav-item" :class="{ active: page === '/club/scouting/payments' || !page }">
              <router-link :to="{ name: 'ClubPaymentDetails'}">Payment Details</router-link>
            </li>
          </ul>
        </li>
        <li class="nav-item" :class="{ active: tab[3] }">
          <div class="nav-item-inner" @click="onTabClick(3)">
            Recruiment
          </div>
        </li>
        <li class="nav-item" :class="{ active: tab[4] }">
          <div class="nav-item-inner" @click="onTabClick(4)">
            Network
          </div>
        </li>
        <li class="nav-item" :class="{ active: tab[5] }">
          <div class="nav-item-inner" @click="onTabClick(5)">
            Admin
          </div>
        </li>
      </ul>
    </div>
    <div class="sidenav-right">
      <div class="nav-list">
        <div class="nav-item">
          <a href="/about">About</a>
        </div>
        <div class="nav-item">
          <a href="/settings">Settings</a>
        </div>
        <div class="nav-item">
          <button @click="handleLogout">Logout</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables.scss';
  @import '~stylesheets/common_style';
  .sidenav-left {
    overflow-y: auto;

    .nav-list {
      margin: 15px 0 15px -20px;
      display: flex;
      flex-direction: column;

      .nav-item {
        margin-right: -20px;
        font-size: $left-menu-text-size;
        .sub-nav {
          max-height: 0;
          overflow: hidden;
          background-color: $main-text-color;
          margin: 0 10px;
          display: flex;
          flex-direction: column;
          .sub-nav-item {
            padding: 10px 0 10px 20px;
            font-weight: 300;
            text-transform: uppercase;
            &:not(:last-child) {
              border-bottom: 1px solid $navbar-background-color;
            }
            &.active .router-link-active {
              color: $main-header-color;
            }
            a {
              color: #fff;
              text-decoration: none;
            }
          }
          transition: max-height 1s;
        }
        .nav-item-inner {
          margin: 0 10px;
          text-transform: uppercase;
          color: $main-header-color;
          font-weight: 300;
          padding: 10px 0 10px 20px;
          border-top: 1px solid $main-text-color;
          color: $main-text-color;
          &:hover {
            background: #5e5e5e;
            cursor: pointer;
          }
        }
      }

      .nav-item:last-child .nav-item-inner {
        border-bottom: 1px solid $main-text-color;
      }

      .nav-item.active {
        position: relative;
        &::before {
          content: '';
          border-left: 4px solid $main-header-color;
          color: $main-header-color;
          position: absolute;
          top: 0;
          left: 0;
          height: 45px;
        }
          .sub-nav {
            max-height: 400px;
          }
      }
    }
  }
</style>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';

export default {
  name: 'ClubNavbar',
  props: ['page'],
  data() {
    return {
      tab: [
        ['channel', 'profile','scouting', 'calendar', 'messages', 'notes'].indexOf(
          this.page
        ) > -1 || !this.page,
        false,
        false,
        false,
        false
      ]
    };
  },
  computed:{
    ...mapGetters(['token']),
    clubName(){
      if (this.token.clubs && this.token.clubs.length > 0)
        return this.token.clubs[0].name;
      return ''
    }
  },
  methods: {
    ...mapActions(['logout']),
    onTabClick(idx) {
      this.tab = [
        ...this.tab.slice(0, idx),
        !this.tab[idx],
        ...this.tab.slice(idx + 1)
      ];
    },
    toMarketplace() {
      this.$router.push({
        name: 'clubReportMarketplace'
      })
    },
    handleLogout() {
      this.logout().then(() => {
        console.log('here');
        this.$router.push('/');
      })
    }
  }
};
</script>
