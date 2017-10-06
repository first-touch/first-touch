<template>
<div>
  <div class="sidenav-left">
    <router-link class="brand" to="/">
      <img class="img-fluid" src="/images/landing-page/ft-navbar-logo.png" alt="Ft Logo" />
    </router-link>
    <div class="profile">
      <img class="rounded-circle img-fluid" src="https://upload.wikimedia.org/wikipedia/en/thumb/7/7c/Toronto_FC_Logo.svg/1095px-Toronto_FC_Logo.svg.png" />
      <h4 class="profile-name">The Team FC</h4>
      <router-link to="/profile/edit" class="profile-edit-button">Edit Profile</router-link>
    </div>
    <ul class="nav-list">
      <li class="nav-item" :class="{ active: tab[0] }" >
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
      <li class="nav-item" :class="{ active: tab[1] }" >
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
      <li class="nav-item" :class="{ active: tab[2] }">
        <div class="nav-item-inner" @click="onTabClick(2)">
          Recruiment
        </div>
      </li>
      <li class="nav-item" :class="{ active: tab[3] }">
        <div class="nav-item-inner" @click="onTabClick(3)">
          Network
        </div>
      </li>
      <li class="nav-item" :class="{ active: tab[4] }">
        <div class="nav-item-inner" @click="onTabClick(4)">
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
    </div>
  </div>
</div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables.scss';
@import '~stylesheets/common_style';

.sidenav-left {
  .brand {
    margin: 0 0 15px 0;
  }
  .profile {
    margin: 15px 0;
    display: flex;
    flex: 1 0 200px;
    flex-direction: column;
    align-items: center;
    * {
      margin: 10px 0;
    }
    .img-fluid {
      max-width: 50%;
    }

    .profile-name {
      text-transform: uppercase;
      color: $main-header-color;
      font-weight: 300;
      font-size: 1.2em;
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
      border-radius: 9999px;
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
    margin: 15px 0 15px -20px;
    display: flex;
    flex-direction: column;
    overflow-y: scroll;
    &::-webkit-scrollbar {
      display: none;
    }

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
        text-transform: uppercase;
        font-weight: 300;
        padding: 10px 0 10px 20px;
        border-top: 1px solid $main-text-color;
        color: $main-text-color;
      }
    }

    .nav-item:last-child .nav-item-inner {
      border-bottom: 1px solid $main-text-color;
    }

    .nav-item.active {
      .nav-item-inner {
        border-left: 7px solid $main-header-color;
        color: $main-header-color;
      }
      .sub-nav {
        max-height: 400px;
      }
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
        font-size: 0.9em;
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

export default {
  name: 'ClubNavbar',
  props: ['page'],
  data() {
    return {
      tab: [
        ['channel', 'profile', 'calendar', 'messages', 'notes'].indexOf(
          this.page,
        ) > -1 || !this.page,
        false,
        false,
        false,
        false,
      ],
    };
  },
  methods: {
    onTabClick(idx) {
      this.tab = [
        ...this.tab.slice(0, idx),
        !this.tab[idx],
        ...this.tab.slice(idx + 1),
      ];
    },
  },
};
</script>
