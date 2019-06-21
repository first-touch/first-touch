<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <router-link to="/" class="navbar-brand">
      <img class="img-fluid" src="/images/landing-page/ft-navbar-logo.png" alt="Ft Logo" />
    </router-link>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <search-bar />
      <ul class="navbar-nav navbar-right ml-auto">
        <li class="nav-item">
          <router-link class="nav-link" to="/profile"> {{ $t("navbar.profile") }} </router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link" to="/messages"> {{ $t("navbar.messages") }} </router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link" to="/network"> {{ $t("navbar.my_network") }} </router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link" to="/notes"> {{ $t("navbar.notes") }} </router-link>
        </li>
        <li v-if="hasClubModule" class="nav-item dropdown">
          <!-- <router-link class="nav-link" to="/club">Club</router-link> -->
          <a class="nav-link dropdown-toggle" href="#" id="scouting-dropdown-club" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            {{ $t("navbar.scouting.main") }}
          </a>
          <div class="dropdown-menu" aria-labelledby="scouting-dropdown-club">
            <router-link class="dropdown-item" :to="{ name: 'requestList'}">{{ $t("navbar.scouting.assignments") }}</router-link>
            <router-link class="dropdown-item" :to="{ name: 'scoutJobsList'}">{{ $t("navbar.scouting.find_reports") }}</router-link>
            <router-link class="dropdown-item" :to="{ name: 'scoutReports'}">{{ $t("navbar.scouting.my_reports") }}</router-link>
            <router-link class="dropdown-item" :to="{ name: 'scoutPaymentDetailPage'}">{{ $t("navbar.scouting.payment_details") }}</router-link>
          </div>
        </li>
        <li v-if="hasScoutModule" class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="scouting-dropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
             {{ $t("navbar.scouting.main") }}
          </a>
          <div class="dropdown-menu" aria-labelledby="scouting-dropdown">
            <router-link class="dropdown-item" :to="{ name: 'scoutJobsBank'}"> {{ $t("navbar.scouting.find_work") }} </router-link>
            <router-link class="dropdown-item" :to="{ name: 'scoutJobsList'}"> {{ $t("navbar.scouting.my_assignments") }} </router-link>
            <router-link class="dropdown-item" :to="{ name: 'scoutReports'}"> {{ $t("navbar.scouting.my_reports") }} </router-link>
            <router-link class="dropdown-item" :to="{ name: 'scoutReportCreate'}"> {{ $t("navbar.scouting.create_report") }} </router-link>
            <router-link class="dropdown-item" :to="{ name: 'scoutPaymentDetailPage'}"> {{ $t("navbar.scouting.payment_details") }} </router-link>
          </div>
        </li>
        <li v-if="hasPartnerModule" class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="partners-dropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Partners
          </a>
          <div class="dropdown-menu" aria-labelledby="scouting-dropdown">
            <router-link class="dropdown-item" to="/">{{ $t("navbar.scouting.scouts") }}</router-link>
            <router-link class="dropdown-item" to="/"> {{ $t("navbar.scouting.directors") }} </router-link>
            <router-link class="dropdown-item" to="/"> {{ $t("navbar.scouting.agents") }} </router-link>
          </div>
        </li>
        <li class="nav-item">
          <router-link class="nav-link" to="#" @click.native="handleLogout"> {{ $t("navbar.logout") }} </router-link>
        </li>
        <language-switcher />
      </ul>
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
import LanguageSwitcher from 'app/components/LanguageSwitcher';

export default {
  name: 'MobileNavbar',
  components: {
    SearchBar,
    LanguageSwitcher
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
    isDirector(){ return this.role == 'director'},
    hasScoutModule() {
      return this.role == 'scout';
    },
    hasPartnerModule() {
      return false;
      // return this.role == 'scout' || this.role == 'agent' || this.role == 'director';
    },
    hasClubModule() {
      return this.role == 'director';
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
