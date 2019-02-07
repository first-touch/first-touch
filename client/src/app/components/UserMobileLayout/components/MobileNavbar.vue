<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <router-link to="/" class="navbar-brand">
      <img class="img-fluid" src="/images/landing-page/ft-navbar-logo.png" alt="Ft Logo" />
    </router-link>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item">
          <router-link class="nav-link" to="/profile">Profile</router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link" to="/messages">Messages</router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link" to="/network">My Network</router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link" to="/notes">My Notes</router-link>
        </li>
        <li v-if="hasClubModule">
          <router-link class="nav-link" to="/club">Club</router-link>
        </li>
        <li v-if="hasScoutModule">
          <a href="#scouting-submenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Scouting</a>
          <ul class="collapse list-unstyled" id="scouting-submenu">
            <li class="nav-item">
              <router-link class="nav-link" :to="{ name: 'scoutReportCreate'}">Create Report</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" :to="{ name: 'scoutJobsList'}">Jobs List</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" :to="{ name: 'scoutJobsBank'}">Jobs Bank</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" :to="{ name: 'scoutPaymentDetailPage'}">Payment Details</router-link>
            </li>
          </ul>
        </li>
        <li v-if="hasPartnerModule">
          <a href="#partners-submenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Partners</a>
          <ul class="collapse list-unstyled" id="partners-submenu">
            <li class="nav-item">
              <router-link class="nav-link" to="/">Scouts</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/">Directors of Football</router-link>
            </li>
            <li class="nav-item">
              <router-link class="nav-link" to="/">Agents</router-link>
            </li>
          </ul>
        </li>
        <li class="nav-item">
          <router-link class="nav-link" to="/about">About</router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link" to="#" @click.native="handleLogout">Logout</router-link>
        </li>
      </ul>
      <search-bar />
    </div>
  </nav>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  li a.router-link-exact-active.router-link-active, a[aria-expanded="true"] {
    color: $main-header-color;
  }
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_LOADING, ASYNC_SUCCESS } from '../../../constants/AsyncStatus';
import SearchBar from '../../SearchBar';

export default {
  name: 'MobileNavbar',
  components: {
    'search-bar': SearchBar
  },
  computed: {
    ...mapGetters(['user']),
    ...mapActions(['logout']),
    role() {
      if (this.user.status === ASYNC_SUCCESS) {
        return this.user.value.role_name;
      } else {
        return '';
      }
    },
    hasScoutModule() {
      return this.role == 'scout';
    },
    hasPartnerModule() {
      return this.role == 'scout' || this.role == 'agent' || this.role == 'director';
    },
    hasClubModule() {
      return this.role == 'player' || this.role == 'director';
    }
  },
  watch: {
    '$route': 'closeSidebar'
  },
  methods: {
    closeSidebar() {
      let navbar = $("#navbarSupportedContent");
      navbar.collapse('hide');
    },
    handleLogout() {
      this.logout.then(() => {
        this.$router.push('/users/sign_in');
      });
    }
  }
};
</script>
