<template>
<div>
  <div class="sidenav-left">
    <router-link class="brand" to="/">
      <img class="img-fluid" src="/images/landing-page/ft-navbar-logo.png" alt="Ft Logo" />
    </router-link>
    <div class="profile">
      <img class="rounded-circle img-fluid" src="https://unsplash.it/500/500" />
      <h4 class="profile-name">{{ name }}</h4>
      <h5 class="profile-role">Football player</h5>
      <h5 class="profile-club">real madrid</h5>
      <router-link to="/profile" class="profile-edit-button">Edit Profile</router-link>
    </div>
    <ul class="nav-list">
      <li class="nav-item" :class="{ active: page === 'home' }">
        <div class="nav-item-inner">
          <router-link to="/">Home</router-link>
        </div>
      </li>
      <li class="nav-item" :class="{ active: page === 'profile' }">
        <div class="nav-item-inner">
          <router-link to="/profile">Profile</router-link>
        </div>
      </li>
      <li class="nav-item" :class="{ active: page === 'calendar' }">
        <div class="nav-item-inner">
          <router-link to="/calendar">Calendar</router-link>
        </div>
      </li>
      <li class="nav-item" :class="{ active: page === 'messages' }">
        <div class="nav-item-inner">
          <router-link to="/messages">Messages</router-link>
        </div>
      </li>
      <li class="nav-item" :class="{ active: page === 'network' }">
        <div class="nav-item-inner">
          <router-link to="/network">My Network</router-link>
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
    </div>
  </div>
</div>
</template>

<style lang="sass" scoped>
@import "~stylesheets/variables.scss";
@import "~stylesheets/common_style.scss";

.sidenav-left {
  display: flex;
  flex-direction: column;
  position: fixed;
  z-index: 3;
  left: 0;
  top: 0;
  width: $navbar-width;
  height: 100vh;
  background-color: $navbar-background-color;
  padding: $navbar-padding;
  box-shadow: 2px 0 2px 0 #555;
  .brand {
    margin: 0 0 15px 0;
  }
  .profile {
    margin: 15px 0;
    * { margin: 10px 0; }
    .img-fluid {
      max-width: 50%;
    }

    .profile-name {
      text-transform: uppercase;
      color: $main-header-color;
      font-weight: 300;
      font-size: 1.2em;
    }
    .profile-club, .profile-role {
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
      font-size: .85em;
      padding: 5px 20px;
      color: $secondary-text-color;
      &:hover {
        text-decoration: none;
      }
    }
  }

  .nav-list {
    margin: 15px 0 15px -20px;
    display: flex;
    flex-direction: column;
    .nav-item .nav-item-inner {
      text-transform: uppercase;
      font-weight: 300;
      margin: 0 20px;
      padding: 10px 0;
      border-top: 1px solid $main-text-color;
      a { color: $main-text-color; }
      a:hover, a:focus { text-decoration: none; }
    }

    .nav-item:last-child .nav-item-inner {
      border-bottom: 1px solid $main-text-color;
    }

    .nav-item.active {
      border-left: 7px solid $main-header-color;
      .nav-item-inner { margin-left: 13px; }
      a { color: $main-header-color; }
    }
  }
}
  .sidenav-right {
    height: 124px;
    box-shadow: -2px -2px 2px #555;
    background-color: $navbar-background-color;
    .nav-list {
      display: flex;
      height: 119px;
      align-items: center;
      .nav-item {
        padding: 20px;
        text-transform: uppercase;
        a {
          color: $main-header-color;
          font-weight: 300;
          font-size: .9em;
        }
        a:hover {
          color: #fff;
          text-decoration: none;
        }
      }
    }
  }
</style>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import store from '../store';
  import { ASYNC_LOADING, ASYNC_SUCCESS } from '../constants/AsyncStatus';

  export default {
    name: 'AppNavbar',
    props: ['page'],
    computed: {
      ...mapGetters(['token', 'user']),
      name() {
        return (this.user.status === ASYNC_SUCCESS)
          ? `${this.user.value.personal_profile.first_name} ${this.user.value.personal_profile.last_name}`
          : '';
      }
    },
    methods: {
      ...mapActions(['getUserInfo']),
      search() {
        fetch(`/api/v1/search?q=${this.searchTerm}`, {
          method: 'GET',
          headers: { 'Authorization': this.token.value }
        }).then((res) => {
          res.status === 200 && res.json().then((r) => this.$set(this, "results", r.users));
        });
      }
    },
    mounted() {
      if (this.token.status !== ASYNC_SUCCESS) {
        this.getUserInfo({ token: this.token.value });
      }
    }
  }
</script>