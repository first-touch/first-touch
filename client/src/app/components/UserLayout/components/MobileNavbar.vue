<template>
  <div id="first-touch-navbar">
    <!-- Sidebar -->
    <nav v-bind:class="{ active: isActive }" id="sidebar">
      <div class="sidebar-header">
        <h3>Bootstrap Sidebar</h3>
      </div>

      <ul class="list-unstyled components">
        <p>Dummy Heading</p>
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
    <button v-on:click="toggleSidebar" type="button" id="sidebarCollapse" class="btn btn-info">
      <i class="fas fa-align-left"></i>
      <span>Toggle Sidebar</span>
    </button>
  </div>
</template>

<style lang="scss" scoped>
  #first-touch-navbar {
    display: flex;
    flex-direction: row;
    align-items: start;
  }

  #sidebarCollapse {
    position: relative;
    z-index: 1000;
    top: 10px;
    left: 10px;
  }

  #sidebar {
    min-width: 250px;
    max-width: 250px;
    min-height: 100vh;

    background: #7386D5;
    color: #fff;
    transition: all 0.3s;

    // TODO: Fix this class name as it means the exact opposite. If the sidebar
    // is active then currently its hidden
    &.active {
      margin-left: -250px;
    }

    .sidebar-header {
      padding: 20px;
      background: #6d7fcc;
    }

    ul.components {
      padding: 20px 0;
      border-bottom: 1px solid #47748b;
    }

    ul {
      p {
        color: #fff;
        padding: 10px;
      }

      li a {
        padding: 10px;
        font-size: 1.1em;
        display: block;
      }

      li a:hover {
        color: #7386D5;
        background: #fff;
      }

      li.active > a, a[aria-expanded="true"] {
        color: #fff;
        background: #6d7fcc;
      }
    }
  }

  ul ul a {
    font-size: 0.9em !important;
    padding-left: 30px !important;
    background: #6d7fcc;
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

  @media(max-width: 768px) {
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
