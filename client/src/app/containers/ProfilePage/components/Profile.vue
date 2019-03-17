<template>
  <div class="container">
    <div class="row">
      <div class="col-4">
        <div class="avatar img-responsive img-circle" v-bind:style="{ 'background-image': 'url('+info.personal_profile.avatar_url+')' }"></div>
      </div>

      <div class="col-8">
        <h4 class="main-header-color upper-cased">{{ info.personal_profile.first_name }} {{ info.personal_profile.last_name }}</h4>
        <h5 id="role">{{ role }}</h5>
        <p id="club"> {{ clubName }}</p>
      </div>
    </div>

    <div class="row mt-2">
      <div class="col-12">
        <ul class="nav justify-content-center" id="profile-navbar" role="tablist">
          <li class="nav-item">
            <a class="nav-link active" id="overview-tab" data-toggle="tab" href="#overview" role="tab" aria-controls="overview" aria-selected="true">Overview</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" id="history-tab" data-toggle="tab" href="#history" role="tab" aria-controls="history" aria-selected="false">History</a>
          </li>
        </ul>
        <div class="tab-content" id="profile-navbar-content">
          <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview-tab">
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
                  <h5>Playing position</h5>
                  <position-rating v-for="positionRating in playingPositions" :positionRating="positionRating"></position-rating>
                </div>
              </div>
            </div>
          </div>
          <div class="tab-pane fade" id="history" role="tabpanel" aria-labelledby="history-tab">History</div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.avatar {
  background-position: center center;
  background-repeat: no-repeat;
  background-size: cover;
  border-radius: 50%;

  height: 0;
  padding-bottom: 100%;
  position: relative;
  width: 100%;
}

.profile-item-container {
  display: flex;
  flex-direction: column;

  .flex-row {
    display: flex;
  }
  // TODO: Consider moving to separate component

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
    margin-top: 30px;
    margin-bottom: 20px;
    .widget-row {
      display: flex;
      align-items: center;
    }
    .btn {
      margin-right: 5px;
    }
  }
}
</style>

<script>
import PositionRating from './PositionRating';
import countrydata from 'country-data';
import moment from 'moment';
import TimelineItem from 'app/components/TimelineItem';

export default {
  name: 'Profile',
  props: ['mine', 'info', 'follow', 'connect'],
  components: {
    'timeline-item': TimelineItem,
    'position-rating': PositionRating
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
    },
    playingPositions() {
      if(!this.info.personal_profile) { return [] }
      return this.info.personal_profile.playing_positions;
    }
  }
};
</script>
