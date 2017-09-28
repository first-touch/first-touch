<template>
  <timeline-item>
    <div class="profile-item-container" v-if="info">
      <div class="top">
        <img class="img-fluid avatar" src="https://unsplash.it/500/500" />
        <div class="info">
          <h4 class="name">{{ info.personal_profile.first_name }} {{ info.personal_profile.last_name }}</h4>
          <p class="role">Football Player</p>
          <p class="club">Real Madrid FC, Spain</p>
          <p class="detail">
            <span class="detail-title">Date of birth</span>
            {{ info.personal_profile.birthday }}
          </p>
          <p class="detail">
            <span class="detail-title">Nationality</span>
            {{ info.personal_profile.nationality_country_code }}
          </p>
          <p class="detail">
            <span class="detail-title">Place of birth</span>
            {{ info.personal_profile.place_of_birth }}
          </p>
          <div class="widget">
            <div class="widget-row">
              <router-link v-if="mine" to="/profile/edit" class="btn btn-bright">Edit Profile</router-link>
              <a v-else-if="!info.following" @click.prevent="follow" href="#" class="btn btn-bright">+ Follow</a>
              <a v-else-if="info.following" class="btn btn-dark">&#10003; Following</a>
              <a v-if="!mine && info.connection_status === 'not_connected'"
                @click.prevent="connect" class="btn btn-bright">
                Connect
              </a>
              <a v-else-if="!mine && info.connection_status === 'pending'"
                class="btn btn-dark">&sim; Pending
              </a>
              <a v-else-if="!mine && info.connection_status === 'connected'"
                class="btn btn-dark">&#10003; Connected
              </a>
              <router-link v-if="!mine" :to="`/messages/${info.id}`" class="btn btn-bright">Message</router-link>
            </div>
            <div class="widget-row">
              <p class="connection"><span class="number">467</span> Connections</p>
            </div>
          </div>
        </div>
      </div>
      <hr />
      <div class="bottom">
        <div class="summary">
          <h5 class="summary-title">Summary</h5>
          <p class="summary-field">{{ info.personal_profile.first_name }} {{ info.personal_profile.middle_name }} {{ info.personal_profile.last_name }}</p>
          <p class="summary-field">
            <span class="summary-field-title">Height</span>
            {{ info.personal_profile.height }} cm
          </p>
          <p class="summary-field">
            <span class="summary-field-title">Weight</span>
            {{ info.personal_profile.weight }} kg
          </p>
          <p class="summary-field">
            <span class="summary-field-title">Preferred Foot:</span>
            {{ info.personal_profile.preferred_foot }}
          </p>
          <p class="summary-field">
            <span class="summary-field-title">Pro Status:</span>
            {{ info.personal_profile.pro_status || "N/a"}}
          </p>
          <p class="summary-field">
            <span class="summary-field-title"># Caps:</span>
            {{ info.personal_profile.total_caps || "0" }}
          </p>
          <a href="#" class="btn btn-bright">Biography</a>
        </div>
        <div class="position">
          <p class="position-title">Playing position</p>
          <p class="position-content">{{ info.personal_profile.playing_position }}</p>
          <img class="img-fluid position-map" src="http://www.conceptdraw.com/solution-park/resource/images/solutions/soccer/Sport-Soccer-Football-Formation-4-4-1-1.png" />
        </div>
      </div>
    </div>
  </timeline-item>
</template>

<style lang="sass" scoped>
  @import "~stylesheets/variables";
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
          margin-top: 70px;
          margin-bottom: 20px;
          .widget-row {
            display: flex;
            align-items: center;
          }
          .btn {
            margin-right: 5px;
          }
          .connection {
            color: $secondary-text-color;
            margin-bottom: 0;
            margin-left: auto;
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
</style>

<script>
  import TimelineItem from '../../shared/components/TimelineItem';

  export default {
    name: 'Profile',
    props: ['mine', 'info', 'follow', 'connect'],
    components: {
      'timeline-item': TimelineItem
    }
  }
</script>