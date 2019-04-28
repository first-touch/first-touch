<template>
  <div class="container">
    <div class="row">
      <div class="col-4 avatar-wrapper">
        <div class="avatar img-responsive img-circle" v-bind:style="{ 'background-image': 'url('+personalProfile.avatar_url+')' }"></div>
      </div>

      <div class="col-8">
        <div class="row">
          <div class="col-12">
            <h5 class="main-header-color upper-cased">{{ personalProfile.first_name }} {{ personalProfile.last_name }}</h5>
          </div>

          <div class="col-12">
            <p id="role">{{ role }}</p>
          </div>
        </div>

        <div class="club-info-wrapper row">
          <div class="col-12">
            <h5 class="spaced-title upper-cased main-color">Club Info</h5>
          </div>
          <div class="col-1">
            <div class="avatar img-responsive img-circle" v-bind:style="{ 'background-image': 'url('+clubAvatar+')' }"></div>
          </div>

          <div class="col-11">
            <p id="club"> {{ clubName }}</p>
          </div>
        </div>

        <div class="profile-actions" >
          <router-link  v-if="mine"
                        class="a-link"
                        to="/profile/edit">
                        <v-icon name="pencil-alt" scale="0.9"/>
                        Edit Profile
          </router-link>
        </div>

        <div v-if="!mine" class="d-none d-md-block">
          <connect-buttons :userId="userId" :connectionStatus="connectionStatus"></connect-buttons>
        </div>
      </div>
    </div>

    <div v-if="!mine" class="d-md-none">
      <connect-buttons :userId="userId" :connectionStatus="connectionStatus"></connect-buttons>
    </div>

    <div class="row mt-2">
      <div class="col-12">
        <div class="tab-content" id="summary-navbar-content">
          <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview-tab">
            <div class="row mt-1">
              <div id="summary" class="col-12">
                <h5 class="spaced-title upper-cased main-color">Personal Details</h5>
              </div>
            </div>
            <div class="row mt-1">
              <div id="summary-contents" class="col-12">
                <p class="detail name">{{ personalProfile.first_name }} {{ personalProfile.middle_name }} {{ personalProfile.last_name }}</p>
                <p class="detail">
                  <span class="detail-title">Date of birth</span>
                  {{ birthday }}
                </p>
                <p class="detail">
                  <span class="detail-title">Nationality</span>
                  {{ nationality }}
                </p>
              </div>
            </div>

            <div class="row mt-1">
              <div id="biography" class="col-12">
                <h5 class="spaced-title upper-cased main-color">Biography</h5>
              </div>
            </div>

            <div class="row mt-1">
              <div id="biography-contents" class="col-12">
                <p> {{biography}} </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.detail-title {
  color: $secondary-text-color;
}
</style>

<script>
import 'vue-awesome/icons/pencil-alt';
import VIcon from 'vue-awesome/components/Icon';
import PositionRating from '../PositionRating';
import countrydata from 'country-data';
import moment from 'moment';
import TimelineItem from 'app/components/TimelineItem';
import CareerEvents from '../CareerEvents';
import ConnectButtons from '../ConnectButtons';
import 'vue-awesome/icons/pencil-alt';
import VIcon from 'vue-awesome/components/Icon'

export default {
  name: 'DirectorProfile',
  props: ['mine', 'user', 'connectionStatus'],
  components: {
    TimelineItem,
    PositionRating,
    CareerEvents,
    ConnectButtons,
    VIcon
  },
  computed: {
    userId() {
      if(!this.user) { return ""; }
      return this.user.id;
    },
    personalProfile() {
      if(!this.user) { return {}; }
      return this.user.personal_profile;
    },
    role() {
      if(!this.user) { return "Unknown"; }
      return _.capitalize(this.user.role_name);
    },
    currentClub() {
      if(!this.user || !this.user.current_club) { return {}; }
      return this.user.current_club;
    },
    clubAvatar() {
      return this.currentClub.club_logo;
    },
    clubName() {
      if(!this.currentClub || !this.currentClub.country_code) { return "No club"; }
      let countryInfo = countrydata.countries[this.currentClub.country_code];
      let countryName = countryInfo.name;
      let countryFlag = countryInfo.emoji;
      return `${this.user.current_club.name}, ${countryName} ${countryFlag}`;
    },
    birthday() {
      if(!this.personalProfile) { return "Unknown"; }
      let bday = moment(this.personalProfile.birthday, "YYYY-MM-dd");
      let age = moment().diff(bday, 'years');
      return `${bday.format("LL")} (age ${age})`;
    },
    nationalityCountryInfo() {
      if(!this.personalProfile || !this.personalProfile.nationality_country_code) { return "Unknown"; }
      return countrydata.countries[this.personalProfile.nationality_country_code];
    },
    nationality() {
      if(!this.personalProfile || !this.personalProfile.nationality_country_code) { return "Unknown"; }

      return `${this.nationalityCountryInfo.name} ${this.nationalityCountryInfo.emoji}`;
    },
    birthplace() {
      if(!this.personalProfile) { return "Unknown"; }
      return `${this.personalProfile.place_of_birth}, ${this.nationalityCountryInfo.name}`;
    },
    biography() {
      if(!this.personalProfile || !this.personalProfile.biography) { return "This user has not written anything yet"; }
      return this.personalProfile.biography;
    }
  }
};
</script>
