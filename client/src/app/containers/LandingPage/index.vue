<template>
  <div id="content">
  <landing-navbar sticky />
    <div class="full">

      <div id="firstpgSlide" class="carousel slide" data-ride="carousel">

        <div class= "row justify-content-center">
          <ol class="carousel-indicators cursor toggle">
            <li data-target="#firstpgSlide" data-slide-to="0" class="active">Main</li>
            <li data-target="#firstpgSlide" data-slide-to="1" >Players</li>
            <li data-target="#firstpgSlide" data-slide-to="2" >Scouts</li>
            <li data-target="#firstpgSlide" data-slide-to="3" >Clubs</li>
          </ol>
        </div>

        <div class="carousel-inner" role="listbox">
          <div class="carousel-item active main">
            <img class="menu" src="/images/landing-page/team-logo.jpg" alt="First slide">
            <div class="intro-message">
              <div class="container">
                <div class="carousel-caption d-lg-block">
                  <div class="row justify-content-center">
                    <img src="images/landing-page/ft-logo.png" alt="Ft logo">
                  </div>
                  <div class="row justify-content-center">
                    <div class="col-12">
                      <ul class="main center">
                        Carving out
                        <br>
                        individual and collective
                        <br>
                        success stories
                      </ul>
                    </div>
                  </div>
                  <div class="row justify-content-center">
                    <ul>
                      <li>
                        <a class="bar-button center" href="users/sign_up">
                          Get Started
                        </a>
                      </li>
                    </ul>
                  </div>
                  <div class="row justify-content-center">
                    <h1 class="typewriter">
                      #RaiseYourGame
                    </h1>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="carousel-item player">
            <img class="img-fluid menu" src="/images/landing-page/BG-player.jpg" alt="Second slide">
            <div class= "contentSlides">
              <div class="container-fluid">
                <div class="carousel-caption">
                  <div class="row">
                    <h1 class= "header col-12">
                      Players
                    </h1>
                  </div>
                  <div class="row">
                    <div class="col-sm-12 col-md-11">
                      <h3 class="description col-12">
                        Build and promote your profile, raise your game and take your career as far as you can.
                      </h3>
                    </div>
                    <div class="col-md-1">
                      <a class="bar-button center" href="users/sign_up">
                        Register Now
                      </a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="carousel-item scouts">
            <img class="img-fluid menu" src="/images/landing-page/BG-scouts.jpg" alt="Third slide">
            <div class= "contentSlides">
              <div class="container-fluid">
                <div class="carousel-caption">
                  <div class="row">
                    <h1 class= "header col-12">
                      Scouts
                    </h1>
                  </div>
                  <div class="row">
                    <div class="col-sm-12 col-md-11">
                      <h3 class="description col-12">
                        Build your reputation as a talent spotter or analyst and make a living from the sport you love.
                      </h3>
                    </div>
                    <div class="col-md-1">
                      <a class="bar-button center" href="users/sign_up">
                        Register Now
                      </a>
                    </div>
                  </div>

                </div>
              </div>
            </div>
          </div>

          <div class="carousel-item clubs">
            <img class="img-fluid menu" src="/images/landing-page/BG-clubs2.jpg" alt="Fourth slide">
            <div class= "contentSlides">
              <div class="container-fluid">
                <div class="carousel-caption">
                  <div class="row">
                    <h1 class="header col-12">
                      Clubs
                   </h1>
                  </div>
                <div class="row">
                  <div class="col-sm-12 col-md-11">
                    <h3 class="description col-12">
                      Maximise your teams’ performance by digitising everything from training and team management to scouting and medical processes.
                    </h3>
                  </div>
                  <div class="col-md-1">
                    <a class="bar-button center" href="users/sign_up">
                      Register Now
                    </a>
                  </div>
                </div>
              </div>
             </div>
            </div>
          </div>
        </div> <!--carousel inner-->
      </div> <!--#firstpgSlide-->
    </div><!--#full-->

    <div id="trans2ndpg">
      <div class="container-fluid col-12">
        <div class="header text-center">
            Take football seriously?
        </div>
        <div class="text-center">
          <h2>
              Sign Up Now!
          </h2>
        </div>
      </div>
    </div>

    <div id="second-page"> <!-- black background -->
      <div class="container-fluid">
        <div class="second-layer"> <!-- content within parallax -->

            <div class="row justify-content-center">
              <div class="headText challengeHead">
                The Challenge
              </div>
            </div>

            <div class="row justify-content-center">
              <div class="challenge">
                  Managing an increasing amount of information and tasks using outdated processes and tools,
                  limited budgets, resources and capabilities present a real challenge for today’s professionals
                  as they seek to maximise performance and remain competitive.
              </div>
            </div>

            <div class="row justify-content-center">
              <div class="headText solutionHead" >
                The Solution
              </div>
            </div>

            <div class="row justify-content-center">
              <div class="solution" >
                    A cloud-based platform that optimises the management of teams, players and careers by consolidating
                    and digitising sports performance and team management processes,
                    whilst capitalising on and augmenting core networks within the industry.
              </div>
            </div>

            <div class="row justify-content-center">
              <div class="headText keyHead">
                Key Capabilities
              </div>
            </div>

            <div class="capabilities rowList"> <!-- rowList shown only when screen is large (desktop and laptop)-->
              <div class="row justify-content-center">
                <div class="col-md-6 col-lg-4">
                  <div class="subheadCapabilities">
                    Career Management
                  </div>
                  <div class="keyDescription">
                    <ul>
                      <li>Consolidate information into an attractive sporting profile for many core roles </li>
                      <li>Build a professional network of agents, scouts, coaches, players and teams </li>
                      <li>Interact with, learn from and share with peers and experts in a global community</li>
                    </ul>
                  </div>
                </div>
                <div class="col-md-6 col-lg-4">
                  <div class="subheadCapabilities">
                    Team Management
                  </div>
                  <div class="keyDescription">
                    <ul>
                      <li>Manage full team rosters with team and individual player reports </li>
                      <li>Empower players and staff to collaborate with versatile communications tools </li>
                      <li>Enable Managers to develop and share tactical strategies securely</li>
                    </ul>
                  </div>
                </div>
                <div class="col-md-6 col-lg-4">
                  <div class="subheadCapabilities">
                    Performance Insights
                  </div>
                  <div class="keyDescription">
                    <ul>
                      <li>Capture match data and stats using intuitive and flexible reporting mechanisms </li>
                      <li>Prepare your next game by requesting opposition analyses from trusted scouts </li>
                      <li>Use match insights to prepare your coach and team for the next match</li>
                    </ul>
                  </div>
                </div>
                <div class="col-md-6 col-lg-4">
                  <div class="subheadCapabilities">
                    Player Development & Fitness
                  </div>
                  <div class="keyDescription">
                    <ul>
                      <li>Create training exercise programs and assign them to groups or individuals</li>
                      <li>Analyse and track players’ talent development and progress</li>
                      <li>Manage medical data and rehabilitation programs on the go with simple notes</li>
                    </ul>
                  </div>
                </div>
                <div class="col-md-6 col-lg-4">
                  <div class="subheadCapabilities">
                    Scouting & Recruitment
                  </div>
                  <div class="keyDescription">
                    <ul>
                      <li>Create and assign scouting requests, simply and intuitively </li>
                      <li>Access a global network of independent scouts to acquire scouting insights </li>
                      <li>Sell and acquire reports in an open marketplace</li>
                    </ul>
                  </div>
                </div>
                <div class="col-md-6 col-lg-4">
                  <div class="subheadCapabilities">
                    Club Management
                  </div>
                  <div class="keyDescription">
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
          <div id="secondpgSlide" class="carousel slide w-80" data-ride="carousel">
            <ol class="carousel-indicators">
              <li data-target="#secondpgSlide" data-slide-to="0" class="active"></li>
              <li data-target="#secondpgSlide" data-slide-to="1"></li>
              <li data-target="#secondpgSlide" data-slide-to="2"></li>
              <li data-target="#secondpgSlide" data-slide-to="3"></li>
              <li data-target="#secondpgSlide" data-slide-to="4"></li>
              <li data-target="#secondpgSlide" data-slide-to="5"></li>
            </ol>
            <div class="carousel-inner">
              <div class="carousel-item active">
                <img class="noBG" src="/images/landing-page/team-logo.jpg" alt="First slide">
                <div class="carousel-caption">
                  <div class="subheadCapabilities">
                    <div class="col-12">
                    Career Management
                  </div>
                  </div>
                  <div class="keyDescription row">
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
                <img class="noBG" src="/images/landing-page/team-logo.jpg" alt="First slide">
                <div class="carousel-caption">
                  <div class="subheadCapabilities">
                    <div class="col-12">
                      Team Management
                    </div>
                  </div>
                  <div class="keyDescription row justify-content-center">
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
                <img class="noBG" src="/images/landing-page/team-logo.jpg" alt="First slide">
                <div class="carousel-caption">
                  <div class="subheadCapabilities">
                    <div class="col-12">
                      Performance Insights
                    </div>
                  </div>
                  <div class="keyDescription row justify-content-center">
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
                <img class="noBG" src="/images/landing-page/team-logo.jpg" alt="First slide">
                <div class="carousel-caption">
                  <div class="subheadCapabilities">
                    <div class="col-12">
                      Player Development & Fitness
                    </div>
                  </div>
                  <div class="keyDescription row justify-content-center">
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
                <img class="noBG" src="/images/landing-page/team-logo.jpg" alt="First slide">
                <div class="carousel-caption">
                  <div class="subheadCapabilities">
                    <div class="col-12">
                      Scouting & Recruitment
                    </div>
                  </div>
                  <div class="keyDescription row justify-content-center">
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
                <img class="noBG" src="/images/landing-page/team-logo.jpg" alt="First slide">
                <div class="carousel-caption">
                  <div class="subheadCapabilities">
                    <div class="col-12">
                      Club Management
                    </div>
                  </div>
                  <div class="keyDescription row justify-content-center">
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
              <a class="carousel-control-prev" href="#secondpgSlide" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
              </a>
              <a class="carousel-control-next" href="#secondpgSlide" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
              </a>
            </div> <!-- carousel-inner-->

          </div> <!-- #secondpgSlide -->

        </div> <!--second layer-->
      </div> <!-- container-fluid -->
    </div> <!-- second-page -->



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
              <li data-target="#toggle" data-slide-to="1" ></li>
              <li data-target="#toggle" data-slide-to="2"></li>
              <li data-target="#toggle" data-slide-to="3"></li>
              <li data-target="#toggle" data-slide-to="4"></li>
              <li data-target="#toggle" data-slide-to="5"></li>
              <li data-target="#toggle" data-slide-to="6"></li>
            </ol>

            <div class="carousel-inner" role="listbox">
              <div class="carousel-item active">
                <div class="polaroid">
                  <img class="d-block img-fluid" src="/images/landing-page/role_agents.jpg" alt="First slide">
                  <span class="polTitle">
                    Agents
                  </span>
                  <div class="description">
                  recruit and manage clients
                  </div>
                  <a class="registerPlus" href="users/sign_up">
                    <img src="/images/landing-page/role_registerPlus.png" alt="Register Sign">
                  </a>
                </div>
              </div>

              <div class="carousel-item">
                <div class="polaroid">
                  <img class="d-block img-fluid " src="/images/landing-page/role_manager.jpg" alt="Second slide">
                  <span class="polTitle">
                    Managers
                  </span>
                  <div class="description">
                      power up your team management
                  </div>
                  <a class="registerPlus" href="users/sign_up">
                    <img src="/images/landing-page/role_registerPlus.png" alt="Register Sign">
                  </a>
                </div>
              </div>

              <div class="carousel-item">
                <div class="polaroid">
                  <img class="d-block img-fluid " src="/images/landing-page/role_coach.jpg" alt="Third slide">
                  <span class="polTitle">
                    Coaches
                  </span>
                  <div class="description">
                    develop your players & your knowledge
                  </div>
                  <a class="registerPlus" href="users/sign_up">
                    <img src="/images/landing-page/role_registerPlus.png" alt="Register Sign">
                  </a>
                </div>
              </div>

              <div class="carousel-item">
                <div class="polaroid">
                  <img class="d-block img-fluid " src="/images/landing-page/role_medic.jpg" alt="Fourth slide">
                  <span class="polTitle">
                    Medical Staff
                  </span>
                  <div class="description">
                    effectively manage your medical affairs
                  </div>
                  <a class="registerPlus" href="users/sign_up">
                    <img src="/images/landing-page/role_registerPlus.png" alt="Register Sign">
                  </a>
                </div>
              </div>

              <div class="carousel-item">
                <div class="polaroid">
                  <img class="d-block img-fluid " src="/images/landing-page/role_scouts.jpg" alt="Fifth slide">
                  <span class="polTitle">
                    Scouts
                  </span>
                  <div class="description">
                    discover, promote and report on talent
                  </div>
                  <a class="registerPlus" href="users/sign_up">
                    <img src="/images/landing-page/role_registerPlus.png" alt="Register Sign">
                  </a>
                </div>
              </div>

              <div class="carousel-item">
                <div class="polaroid">
                  <img class="d-block img-fluid " src="/images/landing-page/role_gm.jpg" alt="Sixth slide">
                  <span class="polTitle">
                    General Managers
                  </span>
                  <div class="description">
                    achieve success through digitisation
                  </div>
                  <a class="registerPlus" href="users/sign_up">
                    <img src="/images/landing-page/role_registerPlus.png" alt="Register Sign">
                  </a>
                </div>
            </div>

            <div class="carousel-item">
                <div class="polaroid">
                  <img class="d-block img-fluid" src="/images/landing-page/role_player.jpg" alt="Seventh slide">
                  <span class="polTitle">
                    Players
                  </span>
                  <div class="description">
                    Promote your game and career
                  </div>
                  <a class="registerPlus" href="users/sign_up">
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
        <a class="text" href="/terms_conditions#contact">
          Help
        </a>
      </div>
      <div class="col-12 col-lg links">
        <a class="text" href="/terms_conditions">
          User Agreement
        </a>
      </div>
      <div class="col-12 col-lg links">
        <a class="text" href="/">
          Community Guidelines
        </a>
      </div>
      <div class="col-12 col-lg links">
        <a class="text" href="/privacy_policy">
          Privacy Policy
        </a>
      </div>
      <div class="col-12 col-lg links">
        <a class="text">
          Follow Us
        </a>
      </div>
      <div class="media links col-12 col-lg justify-content-center">
        <a href="https://www.instagram.com/?hl=en" target="_blank" >
          <img class="social" src="images/landing-page/social_instagram.png" alt="instagram">
        </a>
        <a href="https://www.facebook.com" target="_blank" >
          <img class="social" src="images/landing-page/social_facebook.png" alt="facebook">
        </a>
        <a href="https://www.linkedin.com" target="_blank" >
          <img class="social" src="images/landing-page/social_linkedIn.png" alt="linkedIn">
        </a>
        <a href="https://twitter.com/?lang=en" target="_blank" >
          <img class="social" src="images/landing-page/social_twitter.png" alt="twitter">
        </a>
        </div>

      </div> <!--row-->
    </div> <!--container-->
  </div>

  </div>
</template>

<style lang="scss" scoped>

</style>

<script>
import LandingNavbar from 'app/components/LandingNavbar.vue';
import LinkButton from 'app/components/LinkButton.vue';
import AOS from 'aos';
import 'aos/dist/aos.css';

AOS.init();

AOS.init({
  disable: false, // accepts following values: 'phone', 'tablet', 'mobile', boolean, expression or function
  // Settings that can be overriden on per-element basis, by `data-aos-*` attributes:
  duration: 1500, // values from 0 to 3000, with step 50ms
  easing: 'ease-in-sine',
  once: true, // whether animation should happen only once - while scrolling down
  mirror: false, // whether elements should animate out while scrolling past them
});

export default {
  name: 'LandingPage',
  components: {
    'landing-navbar': LandingNavbar,
    'v-linkbutton': LinkButton,
  },
  mounted() {
    this.$nextTick(() => {

      $('.more').click(function() {
        return $(this)
          .parent()
          .fadeOut();
      });

      $('.back').click(function() {
        return $(this)
          .prev()
          .fadeIn();
      });
    });
  },
  beforeDestroy() {
    $(window).off('scroll');
  },
};

$(document).ready(function () {
  if( $(window).width() < 992) {
    $('.carousel').each(function(){
        $(this).carousel({
            interval: false
        });
    });
  }
  else {
    $('#toggle .carousel-item').each(function(){
        var next = $(this).next();
        if (!next.length) {
          next = $(this).siblings(':first');
        }
        next.children(':first-child').clone().appendTo($(this));
        for (var i=0;i<1;i++) {
          next=next.next();
          if (!next.length) {
            next = $(this).siblings(':first');
          }
          next.children(':first-child').clone().appendTo($(this));
        }
      });
      $('#secondpgSlide').carousel({
      interval: false
      })
      $('#toggle').carousel({
        interval: false
      })
  }

});

</script>
