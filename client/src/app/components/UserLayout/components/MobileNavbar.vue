<template>
  <div v-bind:class="{ active: isActive }" id="first-touch-navbar">
    <!-- Sidebar -->
    <nav v-bind:class="{ active: isActive }" id="sidebar">
      <div class="sidebar-header">
        <img class="img-fluid" src="/images/landing-page/ft-navbar-logo.png" alt="Ft Logo" />
      </div>

      <ul class="list-unstyled components">
        <li>
          <router-link to="/" @click.native="closeSidebar">Home</router-link>
        </li>
        <li>
          <router-link to="/profile" @click.native="closeSidebar">Profile</router-link>
        </li>
        <li>
          <router-link to="/messages" @click.native="closeSidebar">Messages</router-link>
        </li>
        <li>
          <router-link to="/network" @click.native="closeSidebar">My Network</router-link>
        </li>
        <li>
          <router-link to="/notes" @click.native="closeSidebar">My Notes</router-link>
        </li>
        <li v-if="hasClubModule">
          <router-link to="/club" @click.native="closeSidebar">Club</router-link>
        </li>
        <li v-if="hasScoutModule">
          <a href="#scouting-submenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Scouting</a>
          <ul class="collapse list-unstyled" id="scouting-submenu">
            <li>
              <router-link :to="{ name: 'scoutReportCreate'}" @click.native="closeSidebar">Create Report</router-link>
            </li>
            <li>
              <router-link :to="{ name: 'scoutJobsList'}" @click.native="closeSidebar">Jobs List</router-link>
            </li>
            <li>
              <router-link :to="{ name: 'scoutJobsBank'}" @click.native="closeSidebar">Jobs Bank</router-link>
            </li>
            <li>
              <router-link :to="{ name: 'scoutPaymentDetailPage'}" @click.native="closeSidebar">Payment Details</router-link>
            </li>
          </ul>
        </li>
        <li v-if="hasPartnerModule">
          <a href="#partners-submenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Partners</a>
          <ul class="collapse list-unstyled" id="partners-submenu">
            <li>
              <router-link to="/" @click.native="closeSidebar">Scouts</router-link>
            </li>
            <li>
              <router-link to="/" @click.native="closeSidebar">Directors of Football</router-link>
            </li>
            <li>
              <router-link to="/" @click.native="closeSidebar">Agents</router-link>
            </li>
          </ul>
        </li>
      </ul>
    </nav>
    <button v-on:click="toggleSidebar" type="button" id="sidebar-collapse" class="a-bar-button d-sm-block d-md-none">
      <span class="navbar-toggler-icon"></span>
    </button>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .navbar-toggler-icon {
    background-image: url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(255, 255, 255, 0.5)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E")
  }

  #first-touch-navbar {
    display: flex;
    flex-direction: row;
    align-items: start;
    max-width: 250px;
  }

  #sidebar-collapse {
    position: relative;
    z-index: 1000;
    top: 10px;
    left: 10px;
  }

  #sidebar {
    min-width: 250px;
    max-width: 250px;
    min-height: 100vh;

    background: $navbar-background-color;
    color: $secondary-text-color;
    transition: all 0.3s;

    // TODO: Fix this class name as it means the exact opposite. If the sidebar
    // is active then currently its hidden
    &.active {
      margin-left: -250px;
    }

    .sidebar-header {
      padding: 20px;
    }

    ul.components {
      padding: 20px 0;
      border-bottom: 1px solid $navbar-background-color-faded;
    }

    ul {
      p {
        padding: 10px;
      }

      li a {
        padding: 10px;
        font-size: 1.1em;
        display: block;
        text-transform: uppercase;
      }

      li a:hover {
        background: $nav-hover-background;
        color: $secondary-text-color;
        text-decoration: none;
      }

      li a.router-link-exact-active.router-link-active, a[aria-expanded="true"] {
        color: $main-header-color;
      }
    }
  }

  ul ul a {
    font-size: 0.9em !important;
    padding-left: 30px !important;
  }

  a[data-toggle="collapse"] {
    position: relative;
  }

  .dropdown-toggle::after {
    display: block;
    position: absolute;
    top: 50%;
    right: 20px;
    transform: translateY(-50%);
  }

  @media screen and (max-width: 768px) {
    #sidebar {
      margin-left: -250px;
    }
    #sidebar.active {
      margin-left: 0;
    }
  }
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_LOADING, ASYNC_SUCCESS } from '../../../constants/AsyncStatus';

export default {
  name: 'MobileNavbar',
  data() {
    return {
      isActive: false
    }
  },
  computed: {
    ...mapGetters(['user']),
    role() {
      if (this.user.status === ASYNC_SUCCESS) {
        return this.user.value.role_name;
      } else {
        return '';
      }
    },
    hasScoutModule() {
      console.log(this.role);
      return this.role == 'scout';
    },
    hasPartnerModule() {
      return this.role == 'scout' || this.role == 'agent' || this.role == 'director';
    },
    hasClubModule() {
      return this.role == 'player' || this.role == 'director';
    }
  },
  methods: {
    toggleSidebar() {
      this.isActive = !this.isActive;
    },
    closeSidebar() {
      if(!this.isActive) { return; }
      this.isActive = false;
    }
  }
};
</script>
