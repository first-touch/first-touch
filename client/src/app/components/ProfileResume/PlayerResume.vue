<template>
  <timeline-item>
    <div class="profile-item-container" v-if="player">
      <div class="top row">
        <img class="img-fluid avatar" :src="player.avatar_url" />
        <div class="info col-lg-4">
          <h4 class="name">{{ player.first_name }} {{ player.last_name }}</h4>
          <p class="role">Football Player</p>
          <p class="club">Real Madrid FC, Spain</p>
          <p class="detail">
            <span class="detail-title">Date of birth</span>
            {{ player.birthday }}
          </p>
          <p class="detail">
            <span class="detail-title">Nationality</span>
            {{ player.nationality_country_code | country}}
          </p>
          <p class="detail">
            <span class="detail-title">Place of birth</span>
            {{ player.place_of_birth | country }}
          </p>
        </div>
        <div class="info info-second col-lg-4">
          <p class="detail">
            <span class="detail-title">Height</span>
            {{ player.height }} cm
          </p>
          <p class="detail">
            <span class="detail-title">Weight</span>
            {{ player.weight }} kg
          </p>
          <p class="detail">
            <span class="detail-title">Preferred Foot:</span>
            {{ player.preferred_foot }}
          </p>
          <p class="detail">
            <span class="detail-title">Pro Status:</span>
            {{ player.pro_status || "N/a"}}
          </p>
          <p class="detail">
            <span class="detail-title">Playing position:</span>
            {{ player.playing_position }}
          </p>
        </div>
      </div>
    </div>
    <div class="profile-item-container" v-if="!player && search">
      <div class="top row">
        <img class="img-fluid avatar" src="https://unsplash.it/500/500" />
        <div class="info col-lg-4">
          <h4 class="name">{{ search.player }}</h4>
          <p class="role">Football Player</p>
          <div v-if="clubInfo">
            <p class="detail">
              <span class="detail-title">Team Name:</span>
              {{clubInfo.team_name}}
            </p>
            <p class="detail" v-if="clubInfo.competitions">
              <span class="detail-title">League:</span>
              <span class="list" v-for="cp in clubInfo.competitions.competitions" :key="cp.id">{{cp.name}} </span>
            </p>
          </div>
          <div v-if="!clubInfo">
            <p class="detail">
              <span class="detail-title">Team Name:</span>
              {{search.club}}
            </p>
            <p class="detail">
              <span class="detail-title">League:</span>
              <span class="list">{{search.club}} </span>
            </p>
          </div>
        </div>
      </div>
    </div>
  </timeline-item>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .profile-item-container {
    background-color: #fff;
    border-radius: 5px;
    padding: 20px;
    width: 100%;
    .top {
      display: flex;
      .avatar {
        height: 150px;
        border-radius: 50%;
      }
      .info {
        &.info-second {
          margin-top: 20px;
        }
        flex: 1 0 calc(100% - 320px);
        .name {
          color: $main-header-color;
          text-transform: uppercase;
        }
        .role,
        .club,
        .detail {
          color: $main-text-color;
        }
        .role {
          font-size: 1.2em;
        }
        .detail-title {
          color: $secondary-text-color;
        }
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
        *:last-child {
          margin-top: 30px;
        }
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
  import TimelineItem from 'app/components/TimelineItem';

  export default {
    name: 'PlayerResume',
    props: ['player', 'search', 'clubInfo'],
    components: {
      'timeline-item': TimelineItem,
    },
  }
</script>
