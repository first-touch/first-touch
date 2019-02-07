<template>
  <div id="content">
    <landing-navbar />
    <div class="carousel-wrapper">
      <carousel :per-page="1" paginationActiveColor="#439042">
        <slide>
          <div class="slide-wrapper slide-one">
            <div class="d-flex justify-content-center">
              <img src="/images/landing-page/ft-logo.png" alt="Ft Logo" />
            </div>
            <div class="d-flex justify-content-center mt-4 mb-4">
              <p id="first-touch-vision" class="text-center upper-cased">The football platform for managing careers, performance and team processes</p>
            </div>
            <div class="row justify-content-center mt-4 mb-4">
              <div class="col-lg-3 col-xs-1 pl-5 pr-5">
                <router-link to="/users/sign_up" class="form-control a-bar-button">Get started</router-link>
              </div>
            </div>
            <div class="row justify-content-center">
              <p class="typewriter">#RaiseYourGame</p>
            </div>
          </div>
        </slide>
        <slide>
          <div class="slide-wrapper slide-two">
            <div class="row justify-content-center">
              <div class="col-12">
                <h1 class="text-center">
                  Players
                </h1>
              </div>
            </div>
            <div class="d-flex justify-content-center mt-4 mb-4">
              <p id="first-touch-vision" class="text-center">Build and promote your profile, raise your game and take your career as far as you can.</p>
            </div>
            <div class="row justify-content-center">
              <div class="col-lg-3 col-xs-1 pl-5 pr-5">
                <router-link to="/users/sign_up/player" class="form-control a-bar-button">Register Now</router-link>
              </div>
            </div>
          </div>
        </slide>
        <slide>
          <div class="slide-wrapper slide-three">
            <div class="row justify-content-center">
              <div class="col-12">
                <h1 class="text-center">
                  Scouts
                </h1>
              </div>
            </div>
            <div class="d-flex justify-content-center mt-4 mb-4">
              <p id="first-touch-vision" class="text-center">Build your reputation as a talent spotter or analyst and make a living from the sport you love.</p>
            </div>
            <div class="row justify-content-center">
              <div class="col-lg-3 col-xs-1 pl-5 pr-5">
                <router-link to="/users/sign_up/scout" class="form-control a-bar-button">Register Now</router-link>
              </div>
            </div>
          </div>
        </slide>
        <slide>
          <div class="slide-wrapper slide-four">
            <div class="row justify-content-center">
              <div class="col-12">
                <h1 class="text-center">
                  Clubs
                </h1>
              </div>
            </div>
            <div class="d-flex justify-content-center mt-4 mb-4">
              <p id="first-touch-vision" class="text-center">Maximise your teams’ performance by digitising everything from training and team management to scouting and medical processes.</p>
            </div>
            <div class="row justify-content-center">
              <div class="col-lg-3 col-xs-1 pl-5 pr-5">
                <router-link to="/users/sign_up/director" class="form-control a-bar-button">Register Now</router-link>
              </div>
            </div>
          </div>
        </slide>
      </carousel>
    </div>
    <div id="transition-page" class="mt-5">
      <div class="container-fluid col-12">
        <h1 class="text-center upper-cased main-header-color"> Take football seriously? </h1>
        <h2 class="text-center mt-4">
          <router-link to="/users/sign_up" class="a-link dark">Sign Up Now!</router-link>
        </h2>
      </div>
    </div>
    <div id="second-page" class="mt-5">
      <div class="container-fluid">
        <div class="row justify-content-center">
          <div class="head-text challenge-head">
            The Challenge
          </div>
        </div>
      </div>
      <div class="row justify-content-center">
        <div class="challenge-sub">
          <p class="main-description">Managing an increasing amount of information and tasks using outdated processes and tools, limited budgets, resources and
          capabilities present a real challenge for today’s professionals as they seek to maximise performance and remain
          competitive.</p>
        </div>
      </div>

      <div class="row justify-content-center">
        <div class="head-text solution-head">
          The Solution
        </div>
      </div>

      <div class="row justify-content-center">
        <div class="solution-sub">
          <p class="main-description">A cloud-based platform that optimises the management of teams, players and careers by consolidating and digitising sports
          performance and team management processes, whilst capitalising on and augmenting core networks within the industry.</p>
        </div>
      </div>

      <div class="row justify-content-center">
        <div class="head-text key-head">
          Key Capabilities
        </div>
      </div>

      <div class="capabilities row-list">
        <div class="row justify-content-center">
          <div class="col-lg-4">
            <div class="subhead-capabilities">
              <p>Career Management</p>
            </div>
            <div class="key-description">
              <ul>
                <li>Consolidate information into an attractive sporting profile for many core roles </li>
                <li>Build a professional network of agents, scouts, coaches, players and teams </li>
                <li>Interact with, learn from and share with peers and experts in a global community</li>
              </ul>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="subhead-capabilities">
              <p>Team Management</p>
            </div>
            <div class="key-description">
              <ul>
                <li>Manage full team rosters with team and individual player reports </li>
                <li>Empower players and staff to collaborate with versatile communications tools </li>
                <li>Enable Managers to develop and share tactical strategies securely</li>
              </ul>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="subhead-capabilities">
              <p>Performance Insights</p>
            </div>
            <div class="key-description">
              <ul>
                <li>Capture match data and stats using intuitive and flexible reporting mechanisms </li>
                <li>Prepare your next game by requesting opposition analyses from trusted scouts </li>
                <li>Use match insights to prepare your coach and team for the next match</li>
              </ul>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="subhead-capabilities">
              <p>Development & Fitness</p>
            </div>
            <div class="key-description">
              <ul>
                <li>Create training exercise programs and assign them to groups or individuals</li>
                <li>Analyse and track players’ talent development and progress</li>
                <li>Manage medical data and rehabilitation programs on the go with simple notes</li>
              </ul>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="subhead-capabilities">
              <p>Scouting & Recruitment</p>
            </div>
            <div class="key-description">
              <ul>
                <li>Create and assign scouting requests, simply and intuitively </li>
                <li>Access a global network of independent scouts to acquire scouting insights </li>
                <li>Sell and acquire reports in an open marketplace</li>
              </ul>
            </div>
          </div>
          <div class="col-lg-4">
            <div class="subhead-capabilities">
              <p>Club Management</p>
            </div>
            <div class="key-description">
              <ul>
                <li>Access, schedule and manage events on the go, from matches to social gatherings </li>
                <li>Coordinate administrative activities such as contracts and league registrations </li>
                <li>Search for, identify and hire the best managers, coaches and medical staff </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
    <ft-footer />
  </div>
</template>

<style lang="scss" scoped>
  .slide-wrapper {
    padding-top: 50px;
    padding-bottom: 30px;

    &.slide-one {
      background: url("/images/landing-page/bg-teams.png") no-repeat center center;
      -webkit-background-size: cover;
      -moz-background-size: cover;
      -o-background-size: cover;
      background-size: cover;
    }

    &.slide-two {
      background: url("/images/landing-page/bg-players.png") no-repeat center center;
      -webkit-background-size: cover;
      -moz-background-size: cover;
      -o-background-size: cover;
      background-size: cover;
      padding-top: 150px;
      padding-bottom: 150px;
    }

    &.slide-three {
      background: url("/images/landing-page/bg-scouts.png") no-repeat center center;
      -webkit-background-size: cover;
      -moz-background-size: cover;
      -o-background-size: cover;
      background-size: cover;
      padding-top: 150px;
      padding-bottom: 150px;
    }

    &.slide-four {
      background: url("/images/landing-page/bg-clubs.png") no-repeat center center;
      -webkit-background-size: cover;
      -moz-background-size: cover;
      -o-background-size: cover;
      background-size: cover;
      padding-top: 150px;
      padding-bottom: 150px;
    }
  }
</style>

<script>
  import { Carousel, Slide } from 'vue-carousel';
  import LandingNavbar from 'app/components/LandingNavbar';
  import LinkButton from 'app/components/LinkButton';
  import Footer from 'app/components/Footer';

  export default {
    name: 'LandingPage',
    components: {
      'landing-navbar': LandingNavbar,
      'v-linkbutton': LinkButton,
      'ft-footer': Footer,
      Carousel,
      Slide,
    },
  };
</script>
