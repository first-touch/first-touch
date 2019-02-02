<template>
  <timeline-item>
    <div class="profile-item-container" v-if="info">
      <div id="biography" class="flex-row">
        <div class="avatar-wrapper">
          <img class="img-fluid avatar" :src="info.personal_profile.avatar_url" />
        </div>
        <div class="info">
          <h4 class="main-header-color upper-cased">{{ info.personal_profile.first_name }} {{ info.personal_profile.last_name }}</h4>
          <h5 id="role">{{ role }}</h5>
          <p id="club"> {{ clubName }}</p>
          <p class="detail">
            <span class="detail-title">Date of birth</span>
            {{ birthday }}
          </p>
          <p class="detail">
            <span class="detail-title">Nationality/Residency</span>
            {{ nationalityResidency }}
          </p>
          <p class="detail">
            <span class="detail-title">Place of birth</span>
            {{ birthplace }}
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
          </div>
        </div>
      </div>
      <hr />
      <div id="summary">
        <h4 class="spaced-title upper-cased main-color">Summary</h4>
        <div class="flex-row">
          <div id="summary-text-wrapper">
            <p class="detail name">{{ info.personal_profile.first_name }} {{ info.personal_profile.middle_name }} {{ info.personal_profile.last_name }}</p>
            <p class="detail">
              <span class="detail-title">Height</span>
              {{ info.personal_profile.height }} cm
            </p>
            <p class="detail">
              <span class="detail-title">Weight</span>
              {{ info.personal_profile.weight }} kg
            </p>
            <p class="detail">
              <span class="detail-title">Preferred Foot:</span>
              {{ preferredFoot }}
            </p>
            <p class="detail">
              <span class="detail-title">Pro Status:</span>
              {{ info.personal_profile.pro_status || "N/a"}}
            </p>
            <p class="detail">
              <span class="detail-title"># Caps:</span>
              {{ info.personal_profile.total_caps || "0" }}
            </p>
            <a href="#" class="btn btn-bright">Biography</a>
          </div>
          <div id="playing-position-wrapper">
            <p class="position-title">Playing position</p>
            <p class="position-content">{{ info.personal_profile.playing_position }}</p>
            <img class="img-fluid position-map" src="http://www.conceptdraw.com/solution-park/resource/images/solutions/soccer/Sport-Soccer-Football-Formation-4-4-1-1.png" />
          </div>
        </div>
      </div>
    </div>
  </timeline-item>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.profile-item-container {
  display: flex;
  flex-direction: column;

  .flex-row {
    display: flex;
  }
  // TODO: Consider moving to separate component
  .avatar-wrapper {
    height: 250px;
    width: 250px;
    overflow: hidden;

    .avatar {
      height: 100%;
      border-radius: 50%;
      object-fit: cover;
    }
  }

  .info {
    margin-left: 20px;
  }

  .detail-title {
    color: $secondary-text-color;
  }

  #summary-text-wrapper, #playing-position-wrapper {
    width: 50%;
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
</style>

<script>
import countrydata from 'country-data';
import moment from 'moment';
import TimelineItem from 'app/components/TimelineItem';

export default {
  name: 'Profile',
  props: ['mine', 'info', 'follow', 'connect'],
  components: {
    'timeline-item': TimelineItem,
  },
  computed: {
    role() {
      if(!this.info) { return "Unknown"; }
      return _.capitalize(this.info.role_name);
    },
    clubName() {
      if(!this.info.current_club) { return "No club"; }
      let countryInfo = countrydata.countries[this.info.current_club.country_code];
      let countryName = countryInfo.name;
      let countryFlag = countryInfo.emoji;
      return `${this.info.current_club.name}, ${countryName} ${countryFlag}`;
    },
    birthday() {
      if(!this.info.personal_profile) { return "Unknown"; }
      let bday = moment(this.info.personal_profile.birthday, "YYYY-MM-dd");
      let age = moment().diff(bday, 'years');
      return `${bday.format("LL")} (age ${age})`;
    },
    nationalityResidency() {
      if(!this.info.personal_profile) { return "Unknown"; }
      let nationalityCountryInfo = countrydata.countries[this.info.personal_profile.nationality_country_code];
      let nationalityCountryName = nationalityCountryInfo.name;
      let nationalityCountryFlag = nationalityCountryInfo.emoji;

      let residencyCountryInfo = countrydata.countries[this.info.personal_profile.residence_country_code];
      let residencyCountryName = residencyCountryInfo.name;
      let residencyCountryFlag = residencyCountryInfo.emoji;
      return `${nationalityCountryName} ${nationalityCountryFlag} / ${residencyCountryName} ${residencyCountryFlag}`;
    },
    birthplace() {
      if(!this.info.personal_profile) { return "Unknown"; }
      let nationalityCountryInfo = countrydata.countries[this.info.personal_profile.nationality_country_code];
      let nationalityCountryName = nationalityCountryInfo.name;
      return `${this.info.personal_profile.place_of_birth}, ${nationalityCountryName}`;
    },
    preferredFoot() {
      return _.capitalize(this.info.personal_profile.preferred_foot);
    }
  }
};
</script>
