<template>
  <div class="root">
    <div class="sidenav-left">
      <a class="brand" href="/">
        <img class="img-fluid" src="/images/landing-page/ft-navbar-logo.png" alt="Ft Logo" />
      </a>
      <div class="profile">
        <img class="rounded-circle img-fluid" src="https://unsplash.it/500/500" />
        <h4 class="profile-name">{{ name }}</h4>
        <h5 class="profile-role">Football player</h5>
        <h5 class="profile-club">real madrid</h5>
        <a href="/profile" class="profile-edit-button">Edit Profile</a>
      </div>
      <ul class="nav-list">
        <li class="nav-item" :class="{ active: page === 'home' }">
          <div class="nav-item-inner">
            <a href="/">Home</a>
          </div>
        </li>
        <li class="nav-item" :class="{ active: page === 'profile' }">
          <div class="nav-item-inner">
            <a href="/profile">Profile</a>
          </div>
        </li>
        <li class="nav-item" :class="{ active: page === 'calendar' }">
          <div class="nav-item-inner">
            <a href="/calendar">Calendar</a>
          </div>
        </li>
        <li class="nav-item" :class="{ active: page === 'message' }">
          <div class="nav-item-inner">
            <a href="/message">Message</a>
          </div>
        </li>
        <li class="nav-item" :class="{ active: page === 'network' }">
          <div class="nav-item-inner">
            <a href="/network">My Network</a>
          </div>
        </li>
      </ul>
    </div>
    <div class="searchbar-top">
      <div class="input-group">
        <input type="text" v-model="searchTerm" @keyup="search" class="form-control" placeholder="Search for players, clubs, events" />
        <span class="input-group-btn">
          <button class="btn btn-secondary" type="button">
            <img class="img-fluid" src="https://d30y9cdsu7xlg0.cloudfront.net/png/15803-200.png" />
          </button>
        </span>
        <div class="search-results-container">
          <result v-for="result in results" :info="result" />
        </div>
      </div>
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
      <div class="info-blk">
        <div class="info-blk-header">
          <a href="#" class="info-blk-header-name">
            Notifications
          </a>
          <a href="/notification" class="info-blk-header-seemore">
            See More
          </a>
        </div>
        <div class="info-blk-body">
          <div class="list">
            <div class="item">
              <span class="person">Jose Mourinho</span> would like to get in touch
            </div>
            <div class="item">
              <span class="person">Jorge Campos</span> liked you post
            </div>
            <div class="item">
              <span class="person">Tony Media</span> would like to get in touch
            </div>
          </div>
        </div>
      </div>
      <div class="info-blk">
        <div class="info-blk-header">
          <a href="#" class="info-blk-header-name">
            Events
          </a>
          <a href="/events" class="info-blk-header-seemore">
            See More
          </a>
        </div>
        <div class="info-blk-body">
          <div class="list">
            <div class="item">
              <div class="event-name">UEFA Champions League Final Match</div>
              <div class="duel"><span class="team">Real Madrid</span> x <span class="team">Aletico Madrid</span></div>
              <div class="time">28 May at 18:30</div>
              <div class="venue">San Siro Stadium, Milan, Italy</div>
            </div>
            <div class="item">
              <div class="event-name">BBVA Spanish League Match</div>
              <div class="duel"><span class="team">Real Madrid</span> x <span class="team">Valenvia CF</span></div>
              <div class="time">04 June at 18:30</div>
              <div class="venue">Santiago Bernabeu Stadium, Madrid, Spain</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="sass" scope>
  @import "~stylesheets/variables.scss";
  .root {
    height: 119px;
    background-color: $navbar-background-color;
  }

  .sidenav-left {
    display: flex;
    flex-direction: column;
    position: fixed;
    z-index: 3;
    left: 0;
    top: 0;
    width: 18vw;
    height: 100vh;
    background-color: $navbar-background-color;
    padding: 20px;
    box-shadow: 2px 0 2px 0 #555;
    .brand {
      margin: 0 0 15px 0;
      display: flex;
      justify-content: center;
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
        a:hover { text-decoration: none; }
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

  .searchbar-top {
    position: fixed;
    z-index: 2;
    top: 0;
    left: 18vw;
    width: 62vw;
    padding: 40px;
    background-color: $navbar-background-color-faded;
    .input-group {
      flex-wrap: wrap;
      .form-control {
        flex: 1 0 80%;
        border-radius: 0;
        border-color: #ccc;
        &:focus { border-color: #ccc; }
        &:hover, &:focus { border-right: none; }
        &:focus ~ .search-results-container {
          display: flex;
        }
      }
      .input-group-btn .btn {
        flex: 1 0 20%;
        border-radius: 0;
        border-left: none;
        &:hover {
          background-color: #fff;
          border-color: #ccc;
          border-left: none;
        }
        .img-fluid {
          width: 20px;
          height: 20px;
        }
      }

    }
    .search-results-container {
      display: none;
      flex-wrap: wrap;
      position: absolute;
      flex: 1 0 auto;
      width: 100%;
      margin-top: 40px;
      &:hover { display: flex; }
    }
  }

  .sidenav-right {
    position: fixed;
    z-index: 3;
    right: 0;
    top: 0;
    width: 20vw;
    height: 100vh;
    background-color: $navbar-background-color;
    box-shadow: -2px 0px 2px #555;
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
    .info-blk {
      padding: 10px 20px;
      margin-bottom: 40px;
      font-weight: 300;
      &:before {
        content : "";
        position: absolute;
        left: 20px;
        margin-top: -15px;
        width: 15%;
        border-top: 5px solid $secondary-header-color;
      }
      .info-blk-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
      }
      .info-blk-header-name {
        text-transform: uppercase;
        color: $secondary-text-color;
        font-size: .9em;
        &:hover { text-decoration: none; }
      }
      .info-blk-header-seemore {
        color: $secondary-text-color;
        font-size: .8em;
        &:hover { text-decoration: none; }
      }
      .info-blk-body {
        font-size: .8em;
        .list { border-bottom: 1px solid $secondary-text-color; }
        .item {
          border-top: 1px solid $secondary-text-color;
          color: $secondary-text-color;
          margin-bottom: 20px;
          .person, .event-name, .duel { color: #fff; }
        }
      }
    }
  }
</style>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import store from '../store';
  import { ASYNC_LOADING, ASYNC_SUCCESS } from '../constants/AsyncStatus';
  import SearchResult from '../components/SearchResult.vue';

  export default {
    name: 'AppNavbar',
    components: {
      'result': SearchResult
    },
    props: ['page'],
    data() {
      return {
        searchTerm: '',
        results: []
      }
    },
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
      if (this.token.status !== ASYNC_SUCCESS) this.getUserInfo({ token: this.token.value });
    }
  }
</script>
