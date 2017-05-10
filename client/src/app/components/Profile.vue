<template>
  <div class="profile-item">
    <div class="arrow"></div>
    <div class="profile-item-container" v-if="info">
      <div class="top">
        <img class="img-fluid avatar" src="https://unsplash.it/500/500" />
        <div class="info">
          <h4 class="name">{{ info.personal_profile.first_name }} {{ info.personal_profile.last_name }}</h4>
          <p class="role">Football Player</p>
          <p class="club">Real Madrid FC, Spain</p>
          <p class="detail">
            <span class="detail-title">Date of birth</span>
            5 February 1985 (age 31)
          </p>
          <p class="detail">
            <span class="detail-title">Nationality</span>
            Portuguese / Portuguese
          </p>
          <p class="detail">
            <span class="detail-title">Place of birth</span>
            Funchal, Madeira, Portugal
          </p>
          <div class="widget">
            <a v-if="mine" href="/profile/edit" class="btn btn-bright">Edit Profile</a>
            <a v-else-if="!info.following" @click.prevent="follow" href="#" class="btn btn-bright">+ Follow</a>
            <a v-else-if="info.following" class="btn btn-dark">&#10003; Following</a>
            <router-link v-if="!mine" :to="`/messages/${info.id}`" class="btn btn-bright">Message</router-link>
            <p class="connection"><span class="number">467</span> Connections</p>
          </div>
        </div>
      </div>
      <hr />
      <div class="bottom">
        <div class="summary">
          <h5 class="summary-title">Summary</h5>
          <p class="summary-field">Cristiano Ronaldo dos Santos Aveiro</p>
          <p class="summary-field">
            <span class="summary-field-title">Height</span>
            1.85m
          </p>
          <p class="summary-field">
            <span class="summary-field-title">Weight</span>
            80kg
          </p>
          <p class="summary-field">
            <span class="summary-field-title">Preferred Foot:</span>
            Right
          </p>
          <p class="summary-field">
            <span class="summary-field-title">Pro Status</span>
            ?
          </p>
          <p class="summary-field">
            <span class="summary-field-title"># Caps</span>
            ?
          </p>
          <a href="#" class="btn btn-bright">Biography</a>
        </div>
        <div class="position">
          <p class="position-title">Playing position</p>
          <p class="position-content">Forward</p>
          <img class="img-fluid position-map" src="http://www.conceptdraw.com/solution-park/resource/images/solutions/soccer/Sport-Soccer-Football-Formation-4-4-1-1.png" />
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
  @import "~stylesheets/variables";
  .profile-item {
    display: flex;
    border-left: 7px solid $main-header-color;
    margin-top: 20px;
    .profile-item-container {
      background-color: #fff;
      border-radius: 5px;
      padding: 20px;
      width: 100%;
      .top {
        display: flex;
        .avatar {
          height: 300px;
          border-radius: 50%;
        }
        .info {
          margin-top: 40px;
          margin-left: 20px;
          flex: 1 0 calc(100% - 320px);
          .name {
            color: $main-header-color;
            text-transform: uppercase;
          }
          .role, .club, .detail { color: $main-text-color; }
          .role { font-size: 1.2em; }
          .detail-title { color: $secondary-text-color; }
          .widget {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 70px;
            margin-bottom: 20px;
            .connection {
              color: $secondary-text-color;
              margin-bottom: 0;
              .number {
                color: $main-text-color;
                font-weight: bold;
                font-size: 1.3em;
              }
            }
          }
        }
      }
      .bottom {
        display: flex;
        margin-top: 30px;
        .summary {
          flex: 1 0 55%;
          .summary-title {
            color: $secondary-text-color;
            text-transform: uppercase;
            margin-bottom: 20px;
          }
          .summary-field {
            color: $main-text-color;
            margin-bottom: 5px;
          }
          *:last-child { margin-top: 30px; }
        }
        .position {
          flex: 1 0 45%;
          display: flex;
          flex-direction: column;
          align-items: center;
          .position-title {
            color: $secondary-text-color;
            font-size: 1.2em;
            margin-bottom: 0;
          }
          .position-content {
            color: $main-text-color;
            font-size: 1.2em;
          }
        }
      }
    }
  }
</style>

<script>
  export default {
    name: 'Profile',
    props: ['mine', 'info', 'follow']
  }
</script>