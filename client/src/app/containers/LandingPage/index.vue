<template>
  <div id="content">
    <landing-navbar sticky />
    <div class="full">
      <div id="first-p-Slide" class="carousel slide" data-ride="carousel">
        <div class="row justify-content-center">
          <ol class="carousel-indicators cursor toggle">
            <li data-target="#first-p-Slide" data-slide-to="0" class="active">Main</li>
            <li data-target="#first-p-Slide" data-slide-to="1">Players</li>
            <li data-target="#first-p-Slide" data-slide-to="2">Scouts</li>
            <li data-target="#first-p-Slide" data-slide-to="3">Clubs</li>
          </ol>
        </div>

        <div class="carousel-inner" role="listbox">

          <div class="carousel-item active main">
            <img class="menu img-fluid" src="/images/landing-page/bg-teams.png" alt="First slide">
            <div class="carousel-caption intro-message">
              <div class="d-flex flex-column justify-content-center">
                <div class="row justify-content-center">
                  <img src="images/landing-page/ft-logo.png" class="img-fluid" alt="Ft logo">
                </div>
                <div class="row justify-content-center main">
                  The football platform for
                  <br>managing careers, performance
                  <br>and team processes
                </div>
                <div class="row justify-content-center">
                  <router-link to="/users/sign_up" class="a-bar-button">Get started</router-link>
                </div>
                <div class="row justify-content-center">
                  <h1 class="typewriter">
                    #RaiseYourGame
                  </h1>
                </div>
              </div>
            </div>
          </div>

          <div class="carousel-item player">
            <img class="img-fluid menu" src="/images/landing-page/bg-players.png" alt="Second slide">
            <div class="carousel-caption content-slides">
              <div class="row">
                <div class="col-12">
                  <h1 class="header">
                    Players
                  </h1>
                </div>
              </div>
              <div class="row">
                <div class="col-10">
                  <h3 class="description">
                    Build and promote your profile, raise your game and take your career as far as you can.
                  </h3>
                </div>
              </div>
              <div class="row">
                <div class="col-1">
                  <router-link to="/users/sign_up/player" class="a-bar-button">
                    Register Now
                  </router-link>
                </div>
              </div>
            </div>
          </div>

          <div class="carousel-item scouts">
            <img class="img-fluid menu" src="/images/landing-page/bg-scouts.png" alt="Third slide">
            <div class="carousel-caption content-slides">
              <div class="row">
                <div class="col-12">
                  <h1 class="header">
                    Scouts
                  </h1>
                </div>
              </div>
              <div class="row">
                <div class="col-10">
                  <h3 class="description">
                    Build your reputation as a talent spotter or analyst and make a living from the sport you love.
                  </h3>
                </div>
              </div>
              <div class="row">
                <div class="col-1">
                  <router-link to="/users/sign_up/scout" class="a-bar-button">
                    Register Now
                  </router-link>
                </div>
              </div>
            </div>
          </div>

          <div class="carousel-item clubs">
            <img class="img-fluid menu" src="/images/landing-page/bg-clubs.png" alt="Fourth slide">
            <div class="carousel-caption content-slides">
              <div class="row">
                <div class="col-12">
                  <h1 class="header">
                    Clubs
                  </h1>
                </div>
              </div>
              <div class="row">
                <div class="col-12">
                  <h3 class="description">
                    Maximise your teams’ performance by digitising everything from training and team management to scouting and medical processes.
                  </h3>
                </div>
              </div>
              <div class="row">
                <div class="col-1">
                  <a class="a-bar-button center" href="users/sign_up/director">
                    Register Now
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!--carousel inner-->
      </div>
      <!--#first-p-Slide-->
    </div>
    <!--#full-->

    <div id="transition-page">
      <div class="container-fluid col-12">
        <div class="header text-center">
          Take football seriously?
        </div>
        <div class="text-center">
          <h2>
            <router-link to="/users/sign_up" class="sign-up">Sign Up Now!</router-link>
          </h2>
        </div>
      </div>
    </div>

    <div id="second-page">
      <!-- black background -->
      <div class="container-fluid">
        <div class="second-layer">
          <!-- content within parallax -->

          <div class="row justify-content-center">
            <div class="head-text challenge-head">
              The Challenge
            </div>
          </div>

          <div class="row justify-content-center">
            <div class="challenge-sub">
              Managing an increasing amount of information and tasks using outdated processes and tools, limited budgets, resources and
              capabilities present a real challenge for today’s professionals as they seek to maximise performance and remain
              competitive.
            </div>
          </div>

          <div class="row justify-content-center">
            <div class="head-text solution-head">
              The Solution
            </div>
          </div>

          <div class="row justify-content-center">
            <div class="solution-sub">
              A cloud-based platform that optimises the management of teams, players and careers by consolidating and digitising sports
              performance and team management processes, whilst capitalising on and augmenting core networks within the industry.
            </div>
          </div>

          <div class="row justify-content-center">
            <div class="head-text key-head">
              Key Capabilities
            </div>
          </div>

          <div class="capabilities row-list">
            <!-- row-list shown only when screen is large (desktop and laptop)-->
            <div class="row justify-content-center">
              <div class="col-lg-4">
                <div class="subhead-capabilities">
                  Career Management
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
                  Team Management
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
                  Performance Insights
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
                  Development & Fitness
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
                  Scouting & Recruitment
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
                  Club Management
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

          <!-- carousell on second page only shown when window is less than 992px (min-width: 992)-->
          <div class="row justify-content-center">
            <div id="second-p-slide" class="carousel slide" data-ride="carousel">
              <ol class="carousel-indicators">
                <li data-target="#second-p-slide" data-slide-to="0" class="active"></li>
                <li data-target="#second-p-slide" data-slide-to="1"></li>
                <li data-target="#second-p-slide" data-slide-to="2"></li>
                <li data-target="#second-p-slide" data-slide-to="3"></li>
                <li data-target="#second-p-slide" data-slide-to="4"></li>
                <li data-target="#second-p-slide" data-slide-to="5"></li>
              </ol>
              <div class="carousel-inner">
                <div class="carousel-item active">
                  <img class="background-image" src="/images/landing-page/bg-teams.png" alt="First slide">
                  <div class="carousel-caption">
                    <div class="subhead-capabilities">
                      <div class="col-12">
                        Career Management
                      </div>
                    </div>
                    <div class="key-description row">
                      <div class="col-12">
                        <ul>
                          <li>Consolidate information into an attractive sporting profile for many core roles </li>
                          <li>Build a professional network of agents, scouts, coaches, players and teams </li>
                          <li>Interact with, learn from and share with peers and experts in a global community</li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <img class="background-image" src="/images/landing-page/bg-teams.png" alt="First slide">
                  <div class="carousel-caption">
                    <div class="subhead-capabilities">
                      <div class="col-12">
                        Team Management
                      </div>
                    </div>
                    <div class="key-description row justify-content-center">
                      <div class="col-12">
                        <ul>
                          <li>Manage full team rosters with team and individual player reports </li>
                          <li>Empower players and staff to collaborate with versatile communications tools </li>
                          <li>Enable Managers to develop and share tactical strategies securely</li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <img class="background-image" src="/images/landing-page/bg-teams.png" alt="First slide">
                  <div class="carousel-caption">
                    <div class="subhead-capabilities">
                      <div class="col-12">
                        Performance Insights
                      </div>
                    </div>
                    <div class="key-description row justify-content-center">
                      <div class="col-12">
                        <ul>
                          <li>Capture match data and stats using intuitive and flexible reporting mechanisms </li>
                          <li>Prepare your next game by requesting opposition analyses from trusted scouts </li>
                          <li>Use match insights to prepare your coach and team for the next match</li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <img class="background-image" src="/images/landing-page/bg-teams.png" alt="First slide">
                  <div class="carousel-caption">
                    <div class="subhead-capabilities">
                      <div class="col-12">
                        Player Development & Fitness
                      </div>
                    </div>
                    <div class="key-description row justify-content-center">
                      <div class="col-12">
                        <ul>
                          <li>Create training exercise programs and assign them to groups or individuals</li>
                          <li>Analyse and track players’ talent development and progress</li>
                          <li>Manage medical data and rehabilitation programs on the go with simple notes</li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <img class="background-image" src="/images/landing-page/bg-teams.png" alt="First slide">
                  <div class="carousel-caption">
                    <div class="subhead-capabilities">
                      <div class="col-12">
                        Scouting & Recruitment
                      </div>
                    </div>
                    <div class="key-description row justify-content-center">
                      <div class="col-12">
                        <ul>
                          <li>Create and assign scouting requests, simply and intuitively </li>
                          <li>Access a global network of independent scouts to acquire scouting insights </li>
                          <li>Sell and acquire reports in an open marketplace</li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="carousel-item">
                  <img class="background-image" src="/images/landing-page/bg-teams.png" alt="First slide">
                  <div class="carousel-caption">
                    <div class="subhead-capabilities">
                      <div class="col-12">
                        Club Management
                      </div>
                    </div>
                    <div class="key-description row justify-content-center">
                      <div class="col-12">
                        <ul>
                          <li>Access, schedule and manage events on the go, from matches to social gatherings </li>
                          <li>Coordinate administrative activities such as contracts and league registrations </li>
                          <li>Search for, identify and hire the best managers, coaches and medical staff </li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
                <a class="carousel-control-prev" href="#second-p-slide" role="button" data-slide="prev">
                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                  <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#second-p-slide" role="button" data-slide="next">
                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                  <span class="sr-only">Next</span>
                </a>
              </div>
              <!-- carousel-inner-->

            </div>
            <!-- #second-p-slide -->
          </div>

        </div>
        <!--second layer-->
      </div>
      <!-- container-fluid -->
    </div>
    <!-- second-page -->



    <div id="third-page">
      <div class="container col-12">
        <div class="row justify-content-center">
          <div class="header">
            ROLES WE SERVE
          </div>
        </div>


        <div class="col-12 col-sm-12">
          <div class="row justify-content-center">

            <div id="toggle" class="carousel slide w-80" data-ride="carousel">
              <ol class="carousel-indicators">
                <li data-target="#toggle" data-slide-to="0" class="active"></li>
                <li data-target="#toggle" data-slide-to="1"></li>
                <li data-target="#toggle" data-slide-to="2"></li>
                <li data-target="#toggle" data-slide-to="3"></li>
                <li data-target="#toggle" data-slide-to="4"></li>
                <li data-target="#toggle" data-slide-to="5"></li>
                <li data-target="#toggle" data-slide-to="6"></li>
              </ol>

              <div class="carousel-inner" role="listbox">
                <div class="carousel-item active">
                  <div class="polaroid">
                    <img class="d-block img-fluid" src="/images/landing-page/role_player.jpg" alt="Seventh slide">
                    <span class="polaroid-title">
                      Players
                    </span>
                    <div class="description">
                      Promote your game and career
                    </div>
                    <a class="register-plus-logo" href="users/sign_up">
                      <img src="/images/landing-page/role_registerPlus.png" alt="Register Sign">
                    </a>
                  </div>
                </div>

                <div class="carousel-item">
                  <div class="polaroid">
                    <img class="d-block img-fluid " src="/images/landing-page/role_scouts.jpg" alt="Fifth slide">
                    <span class="polaroid-title">
                      Scouts
                    </span>
                    <div class="description">
                      discover, promote and report on talent
                    </div>
                    <a class="register-plus-logo" href="users/sign_up">
                      <img src="/images/landing-page/role_registerPlus.png" alt="Register Sign">
                    </a>
                  </div>
                </div>

                <div class="carousel-item">
                  <div class="polaroid">
                    <img class="d-block img-fluid " src="/images/landing-page/role_manager.jpg" alt="Second slide">
                    <span class="polaroid-title">
                      Managers
                    </span>
                    <div class="description">
                      power up your team management
                    </div>
                    <a class="register-plus-logo" href="users/sign_up">
                      <img src="/images/landing-page/role_registerPlus.png" alt="Register Sign">
                    </a>
                  </div>
                </div>

                <div class="carousel-item">
                  <div class="polaroid">
                    <img class="d-block img-fluid" src="/images/landing-page/role_agents.jpg" alt="First slide">
                    <span class="polaroid-title">
                      Agents
                    </span>
                    <div class="description">
                      recruit and manage clients
                    </div>
                    <a class="register-plus-logo" href="users/sign_up">
                      <img src="/images/landing-page/role_registerPlus.png" alt="Register Sign">
                    </a>
                  </div>
                </div>

                <div class="carousel-item">
                  <div class="polaroid">
                    <img class="d-block img-fluid " src="/images/landing-page/role_coach.jpg" alt="Third slide">
                    <span class="polaroid-title">
                      Coaches
                    </span>
                    <div class="description">
                      develop your players & your knowledge
                    </div>
                    <a class="register-plus-logo" href="users/sign_up">
                      <img src="/images/landing-page/role_registerPlus.png" alt="Register Sign">
                    </a>
                  </div>
                </div>

                <div class="carousel-item">
                  <div class="polaroid">
                    <img class="d-block img-fluid " src="/images/landing-page/role_gm.jpg" alt="Sixth slide">
                    <span class="polaroid-title">
                      General Managers
                    </span>
                    <div class="description">
                      achieve success through digitisation
                    </div>
                    <a class="register-plus-logo" href="users/sign_up">
                      <img src="/images/landing-page/role_registerPlus.png" alt="Register Sign">
                    </a>
                  </div>
                </div>

                <div class="carousel-item">
                  <div class="polaroid">
                    <img class="d-block img-fluid " src="/images/landing-page/role_medic.jpg" alt="Fourth slide">
                    <span class="polaroid-title">
                      Medical Staff
                    </span>
                    <div class="description">
                      effectively manage your medical affairs
                    </div>
                    <a class="register-plus-logo" href="users/sign_up">
                      <img src="/images/landing-page/role_registerPlus.png" alt="Register Sign">
                    </a>
                  </div>
                </div>
              </div>

              <a class="carousel-control-prev arrowLeft" href="#toggle" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
              </a>
              <a class="carousel-control-next arrowRight" href="#toggle" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div id="footer">
      <div class="container">
        <div class="row">
          <div class="col">
            <img class="logo" src="images/landing-page/ft-footer-logo.png" alt="Ft logo">
            <span class="cRight">&copy;2016</span>
          </div>
          <div class="col-12 col-lg links">
            <a class="text" href="/terms_conditions">
              User Agreement
            </a>
          </div>
          <div class="col-12 col-lg links">
            <a class="text" href="/community_guidelines">
              Community Guidelines
            </a>
          </div>
          <div class="col-12 col-lg links">
            <a class="text" href="/privacy_policy">
              Privacy Policy
            </a>
          </div>
          <div class="col-12 col-lg links">
            <a class="text" href="/contact_us">
              Contact Us
            </a>
          </div>
          <div class="col-12 col-lg links">
            <a class="text">
              Follow Us
            </a>
          </div>
          <div class="media links col-12 col-lg justify-content-center">
            <a href="https://www.instagram.com/?hl=en" target="_blank">
              <img class="social" src="images/landing-page/social_instagram.png" alt="instagram">
            </a>
            <a href="https://www.facebook.com" target="_blank">
              <img class="social" src="images/landing-page/social_facebook.png" alt="facebook">
            </a>
            <a href="https://www.linkedin.com" target="_blank">
              <img class="social" src="images/landing-page/social_linkedIn.png" alt="linkedIn">
            </a>
            <a href="https://twitter.com/?lang=en" target="_blank">
              <img class="social" src="images/landing-page/social_twitter.png" alt="twitter">
            </a>
          </div>

        </div>
        <!--row-->
      </div>
      <!--container-->
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/pages/landing';
</style>

<script>
  import LandingNavbar from 'app/components/LandingNavbar';
  import LinkButton from 'app/components/LinkButton';

  export default {
    name: 'LandingPage',
    components: {
      'landing-navbar': LandingNavbar,
      'v-linkbutton': LinkButton,
    },
    mounted() {
      this.$nextTick(() => {
        if ($(window).width() < 992) {
          $('.carousel').each(function () {
            $(this).carousel({
              interval: false
            });
          });
        } else {
          $('#toggle .carousel-item').each(function () {
            var next = $(this).next();
            if (!next.length) {
              next = $(this).siblings(':first');
            }
            next.children(':first-child').clone().appendTo($(this));
            for (var i = 0; i < 1; i++) {
              next = next.next();
              if (!next.length) {
                next = $(this).siblings(':first');
              }
              next.children(':first-child').clone().appendTo($(this));
            }
          });
          $('#second-p-slide').carousel({
            interval: false
          })
          $('#toggle').carousel({
            interval: false
          })
        }
      });
    },
    beforeDestroy() {
      $(window).off('scroll');
    },
  };
</script>
