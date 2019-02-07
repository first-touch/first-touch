<template>
  <div class="wrapper">
    <landing-navbar/>
    <div class="container">
      <div class="header">
        <div class="hero-container">
          <img src="/images/landing-page/ft-navbar-logo.svg" alt="Ft Logo" class="hero">
        </div>
      </div>
      <div class="info">
        <h3 class="title">total football management</h3>
        <p class="subtitle"><em>noun</em></p>
        <p class="meaning">a footballing philosophy in which every professional in the world
          of football is able to effectively manage every aspect of their role during the course of a career.</p>
        <p class="description" style="margin-top: 30px;">
          FirstTouch is a Total Football Management platform for Players, Coaches, Scouts, Agents and many other
          professionals tied to the game. From scouting to tactics and training. We are trying to do our part to
          democratise football by bringing resources that would only be available to the elite, to the masses;
          by giving players and professionals globally the same opportunities to showcase, develop and manage their talent.
        </p>
        <p class="description">
          With a founding team that spans Europe, Asia and South America, FirstTouch wants to become the football ecosystem
          and management platform of choice for millions of people who are involved in the game on a daily basis.
        </p>
        <h5 class="glance-title">
          Firsttouch at a glance
        </h5>
        <div class="company-info">
          <div class="left">
            <div class="item">
              <p class="item-title">Founded</p>
              <p class="item-des">February 2017</p>
            </div>
            <div class="item">
              <p class="item-title">CEO</p>
              <p class="item-des">Matthew Jurado</p>
            </div>
            <div class="item">
              <p class="item-title">Headquarters</p>
              <p class="item-des">292 Main Street<br/>Gibraltar, GX11 1AA</p>
            </div>
          </div>
          <div class="right">
            <div class="item">
              <p class="item-title">Professional Background</p>
              <p class="item-des">Made up of Entrepreneurs, Businessmen, Developers, Accountants and Lawyers.</p>
            </div>
            <div class="item">
              <p class="item-title">Football Background</p>
              <p class="item-des">We are players, coaches, scouts and journalists.</p>
            </div>
            <div class="item">
              <p class="item-title">Matches Played</p>
              <p class="item-des">More than we can count.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <ft-footer />
  </div>
</template>
<style lang="scss" scoped>
@import '~stylesheets/variables';
.wrapper {
  width: 100vw;
  background-color: $landing-page-dark-background-color;
  min-height: 100vh;
  padding-bottom: 20px;
}
.container {
  margin-top: 20px;
  border-radius: 20px;
  padding: 0;
  overflow: hidden;
  .header {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 300px;
    background: url('/images/landing-page/mountain.jpg') no-repeat center bottom;
    background-size: cover;
    .hero-container {
      img {
        height: 100px;
      }
    }
  }
  .info {
    background: #fff;
    padding: 20px;
    letter-spacing: 0.8px;
    h3,
    p {
      color: #000;
    }
    .subtitle {
      font-size: 0.85rem;
    }
    .meaning {
      padding-left: 20px;
      border-left: 4px solid rgba(10, 10, 10, 0.5);
      color: grey;
    }
    .glance-title {
      text-transform: uppercase;
      color: #7f7f7f;
      font-size: 1.1rem;
      border-bottom: 1px solid #ccc;
      padding-bottom: 7px;
      padding-left: 5px;
      margin-bottom: 10px;
      margin-top: 30px;
    }
    .company-info {
      display: flex;

      .left,
      .right {
        margin-top: 20px;
        margin-bottom: 20px;
      }
      .left {
        padding-right: 40px;
        border-right: 1px solid #ccc;
      }
      .right {
        padding-left: 40px;
      }
      p.item-* {
        font-size: 0.85rem;
      }
      .item-title {
        text-transform: uppercase;
        margin: 0;
      }
      .item-des {
        color: #7f7f7f;
      }
    }
  }
}
</style>

<script>
import LandingNavbar from 'app/components/LandingNavbar';
import Footer from 'app/components/Footer';

export default {
  name: 'About',
  components: {
    'landing-navbar': LandingNavbar,
    'ft-footer': Footer
  }
};
</script>
