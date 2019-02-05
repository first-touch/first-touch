<template>
  <div v-bind:class="{ active: isActive }" id="first-touch-navbar">
    <!-- Sidebar -->
    <nav v-bind:class="{ active: isActive }" id="sidebar">
      <div class="sidebar-header">
        <img class="img-fluid" src="/images/landing-page/ft-navbar-logo.png" alt="Ft Logo" />
      </div>

      <ul class="list-unstyled components">
        <li class="active">
          <a href="#home-submenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Home</a>
            <ul class="collapse list-unstyled" id="home-submenu">
            <li>
              <a href="#">Home 1</a>
            </li>
            <li>
              <a href="#">Home 2</a>
            </li>
            <li>
              <a href="#">Home 3</a>
            </li>
          </ul>
        </li>
        <li>
          <a href="#">Profile</a>
        </li>
        <li>
          <a href="#">Messages</a>
        </li>
        <li>
          <a href="#">My Network</a>
        </li>
        <li>
          <a href="#scouting-submenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Scouting</a>
          <ul class="collapse list-unstyled" id="scouting-submenu">
            <li>
              <a href="#">Create Report</a>
            </li>
            <li>
              <a href="#">Jobs List</a>
            </li>
            <li>
              <a href="#">Jobs Bank</a>
            </li>
            <li>
              <a href="#">Payment Details</a>
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
      }

      li a:hover {
        background: $nav-hover-background;
        color: $secondary-text-color;
        text-decoration: none;
      }

      li.active > a, a[aria-expanded="true"] {
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
export default {
  name: 'MobileNavbar',
  data() {
    return {
      isActive: false
    }
  },
  methods: {
    toggleSidebar() {
      this.isActive = !this.isActive;
    }
  }
};
</script>
