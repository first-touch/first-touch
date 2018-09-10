<template>
  <timeline-item bgColor="transparent" padding="0">
    <div :class="`profile-item-container ${bioActive ? 'active' : ''}`" v-if="info">
      <div class="flipper">
      <div class="front">
        <div class="top">
          <edit-btn v-if="mine" to="#"/>
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
                <!-- <router-link v-if="mine" to="/profile/edit" class="btn btn-bright">Edit Profile</router-link> -->
                <a v-if="!mine && !info.following" @click.prevent="follow" href="#" class="btn btn-bright">+ Follow</a>
                <a v-else-if="!mine && info.following" class="btn btn-dark">&#10003; Following</a>
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
          <edit-btn v-if="mine" to="#"/>
          <div class="summary">
            <h5 class="summary-title">Summary</h5>
            <p class="summary-field name">{{ info.personal_profile.first_name }} {{ info.personal_profile.middle_name }} {{ info.personal_profile.last_name }}</p>
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
            <button class="btn btn-bright" @click="toggleBio">Biography</button>
          </div>
          <div class="position">
            <p class="position-title">Playing position</p>
            <p class="position-content">{{ info.personal_profile.playing_position }}</p>
            <!-- <img class="img-fluid position-map" src="http://www.conceptdraw.com/solution-park/resource/images/solutions/soccer/Sport-Soccer-Football-Formation-4-4-1-1.png" /> -->
            <position-map :positions="['Midfielder (Right)', 'Midfielder (Left)']"/>
          </div>
        </div>
      </div>
      <div class="back">
        <div class="bio">
          <h5 class="bio-title">Biography</h5>
          <p class="bio-txt">
            Bacon ipsum dolor amet ham filet mignon buffalo tri-tip, beef fatback rump prosciutto jowl tongue cow sirloin porchetta. Doner shankle turducken, ground round turkey boudin pig sirloin leberkas cupim chicken shank. T-bone swine picanha turducken, kielbasa ground round chuck shank ham hock alcatra tail tri-tip burgdoggen. Shankle picanha fatback cow shoulder, turkey venison tri-tip andouille sirloin buffalo leberkas chicken prosciutto. Short ribs corned beef pork loin, ribeye porchetta salami biltong strip steak filet mignon sausage jerky spare ribs flank pastrami meatball. Turkey frankfurter meatloaf brisket leberkas porchetta corned beef pancetta jowl bacon beef ribs picanha pork belly rump meatball. Burgdoggen salami turducken biltong alcatra venison sausage fatback shoulder drumstick andouille.
            <br/>
            Fatback salami t-bone, spare ribs landjaeger short loin pig hamburger. Alcatra pork chop burgdoggen filet mignon, tongue cupim ribeye leberkas. Pork meatball beef, chuck landjaeger frankfurter kielbasa fatback salami pork belly tenderloin ground round porchetta meatloaf. Landjaeger shoulder drumstick strip steak, filet mignon andouille pork chop jowl flank porchetta jerky ribeye ham hock shankle venison. Turkey sausage meatball buffalo pork chop chuck swine tail hamburger doner.
          </p>
          <br/>
          <button class="btn btn-bright" @click="toggleBio">Close</button>
        </div>
      </div>
      </div>
    </div>
  </timeline-item>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

$profile-height: 710px;

.profile-item-container {
  width: 100%;
  perspective: 1000px;
  height: $profile-height;

  .flipper {
    border-radius: 5px;
    padding: 20px;
    transition: 0.6s;
    transform-style: preserve-3d;
    position: relative;
  }

  &.active .flipper {
    transform: rotateY(180deg);
  }
  .front,
  .back {
    backface-visibility: hidden;
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: $profile-height;
    background-color: #fff;
    border-radius: 5px;
    padding: 20px;
  }

  .front {
    // z-index: 2;
    transform: rotateY(0deg);
    .top {
      display: flex;
      position: relative;
      .avatar {
        height: 185px;
        border-radius: 50%;
      }
      .info {
        margin-top: 10px;
        margin-left: 20px;
        flex: 1 0 calc(100% - 320px);
        h4,
        p {
          margin-bottom: 0.2rem;
          font-weight: 300;
        }
        .name {
          color: $main-header-color;
          text-transform: uppercase;
          letter-spacing: 2px;
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
      position: relative;
      display: flex;
      margin-top: 30px;
      .summary {
        flex: 1 0 55%;
        .summary-title {
          color: $secondary-text-color;
          text-transform: uppercase;
          margin-bottom: 20px;
          letter-spacing: 0.3rem;
        }
        .name {
          text-transform: capitalize;
        }
        .summary-field {
          color: $main-text-color;
          margin-bottom: 0.2rem;
          font-weight: 300;
          .summary-field-title {
            color: $secondary-text-color;
          }
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
  .back {
    transform: rotateY(180deg);
    .bio {
      .bio-title {
        color: $secondary-text-color;
        text-transform: uppercase;
        margin-bottom: 20px;
        letter-spacing: 0.3rem;
      }
      .bio-txt {
        color: $main-text-color;
        margin-bottom: 0.2rem;
        font-weight: 300;
      }
    }
  }
}
</style>

<script>
import TimelineItem from 'app/components/TimelineItem';
import PositionMap from './components/PositionMap';
import EditBtn from './components/EditBtn'

export default {
  name: 'Profile',
  props: ['mine', 'info', 'follow', 'connect'],
  components: {
    'timeline-item': TimelineItem,
    'position-map': PositionMap,
    'edit-btn': EditBtn,
  },
  data() {
    return {
      bioActive: false,
    };
  },
  methods: {
    toggleBio() {
      this.$set(this, 'bioActive', !this.bioActive);
    }
  }
};
</script>
