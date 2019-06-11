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
            <h5 class="spaced-title upper-cased main-color"> {{ $t("profile.club_info") }} </h5>
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
                        {{ $t("profile.edit") }}
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
        <ul class="nav justify-content-center" id="profile-navbar" role="tablist">
          <li class="nav-item">
            <a class="nav-link active" id="overview-tab" data-toggle="tab" href="#overview" role="tab" aria-controls="overview" aria-selected="true">{{ $t("profile.overview") }}</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" id="history-tab" data-toggle="tab" href="#history" role="tab" aria-controls="history" aria-selected="false">{{ $t("profile.history") }}</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" id="stats-tab" data-toggle="tab" href="#stats" role="tab" aria-controls="stats" aria-selected="false">{{ $t("profile.stats") }}</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" id="media-tab" data-toggle="tab" href="#media" role="tab" aria-controls="stats" aria-selected="false">{{ $t("profile.media") }}</a>
          </li>
        </ul>
        <div class="tab-content" id="profile-navbar-content">
          <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview-tab">
            <div class="row mt-1">
              <div id="summary" class="col-12">
                <h5 class="spaced-title upper-cased main-color">{{ $t("profile.personal_details.main") }}</h5>
              </div>
            </div>
            <div class="row mt-1">
              <div id="summary-contents" class="col-12">
                <p class="detail name">{{ personalProfile.first_name }} {{ personalProfile.middle_name }} {{ personalProfile.last_name }}</p>
                <p class="detail">
                  <span class="detail-title">{{ $t("profile.personal_details.date_of_birth") }}</span>
                  {{ birthday }}
                </p>
                <p class="detail">
                  <span class="detail-title">{{ $t("profile.personal_details.nationality") }}</span>
                  {{ nationality }}
                </p>
                <p class="detail">
                  <span class="detail-title">{{ $t("profile.personal_details.residency") }}</span>
                  {{ residency }}
                </p>
                <p class="detail">
                  <span class="detail-title">{{ $t("profile.personal_details.place_of_birth") }}</span>
                  {{ birthplace }}
                </p>
                <p class="detail">
                  <span class="detail-title">{{ $t("profile.personal_details.height") }}</span>
                  {{ personalProfile.height }} cm
                </p>
                <p class="detail">
                  <span class="detail-title">{{ $t("profile.personal_details.weight") }}</span>
                  {{ personalProfile.weight }} kg
                </p>
                <p class="detail">
                  <span class="detail-title">{{ $t("profile.personal_details.preferred_foot") }}</span>
                  {{ preferredFoot }}
                </p>
                <p class="detail">
                  <span class="detail-title">{{ $t("profile.personal_details.pro_status") }}</span>
                  {{ personalProfile.pro_status || "N/a"}}
                </p>
                <p class="detail">
                  <span class="detail-title">{{ $t("profile.personal_details.no_of_caps") }}</span>
                  {{ personalProfile.total_caps || "0" }}
                </p>
              </div>
            </div>

            <div class="row mt-1">
              <div id="position" class="col-12">
                <h5 class="spaced-title upper-cased main-color">{{ $t("profile.position.main") }}</h5>
              </div>
            </div>

            <div class="row mt-1">
              <div id="position-contents" class="col-12">
                <position-rating v-for="positionRating in playingPositions" :positionRating="positionRating"></position-rating>
              </div>
            </div>

            <div class="row mt-1">
              <div id="biography" class="col-12">
                <h5 class="spaced-title upper-cased main-color">{{ $t("profile.biography") }}</h5>
              </div>
            </div>

            <div class="row mt-1">
              <div id="biography-contents" class="col-12">
                <p> {{biography}} </p>
              </div>
            </div>
          </div>
          <div class="tab-pane fade" id="history" role="tabpanel" aria-labelledby="history-tab">
            <div class="row mt-1">
              <div id="career-history-section" class="col-12">
                <h5 class="spaced-title upper-cased main-color">{{ $t("profile.career_history.main") }}</h5>
              </div>
            </div>
            <career-events :careerHistory="careerHistory" />
          </div>
          <div class="tab-pane fade" id="stats" role="tabpanel" aria-labelledby="stats-tab">
            {{ $t("profile.stats_tab.main") }}
          </div>
          <div class="tab-pane fade" id="media" role="tabpanel" aria-labelledby="media-tab">
            <div class="row mt-1">
              <div id="media-section" class="col-12">
                <h5 class="spaced-title upper-cased main-color">{{ $t("profile.media_tab.main") }}</h5>
              </div>
            </div>
            <div class="row mt-1">
              <div id="add-media" class="col-12">
                <vue-dropzone
                  id="media-uploader"
                  :options="dropzoneOptions"
                  :awss3="awss3"
                  v-on:vdropzone-s3-upload-error="s3UploadError"
                  v-on:vdropzone-s3-upload-success="s3UploadSuccess"
                  >
                </vue-dropzone>
              </div>
              <div id="existing-media" class="col-12">
                <img v-for="mediaUrl in media" :src="mediaUrl" v-bind:key="mediaUrl" class="ft-thumbnail img-thumbnail" />
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
@import '~stylesheets/button';

.detail-title {
  color: $secondary-text-color;
}
.ft-thumbnail {
  max-width: 250px;
}
</style>

<script>
import PositionRating from '../PositionRating';
import countrydata from 'country-data';
import moment from 'moment';
import TimelineItem from 'app/components/TimelineItem';
import CareerEvents from '../CareerEvents';
import ConnectButtons from '../ConnectButtons';
import 'vue-awesome/icons/pencil-alt';
import VIcon from 'vue-awesome/components/Icon'
import vue2Dropzone from 'vue2-dropzone'
import 'vue2-dropzone/dist/vue2Dropzone.min.css'

export default {
  name: 'PlayerProfile',
  props: ['mine', 'user', 'connectionStatus'],
  components: {
    TimelineItem,
    PositionRating,
    CareerEvents,
    ConnectButtons,
    VIcon,
    vueDropzone: vue2Dropzone
  },
  data () {
    return {
      awss3: {
        signingURL: 'api/v1/direct_upload/signed_request',
        headers: {
          Authorization: this.$store.state.token.value
        },
        params : {},
        sendFileToServer : false,
        withCredentials: false
      },
      dropzoneOptions: {
        thumbnailWidth: 150
      }
    }
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
    residency() {
      if(!this.personalProfile || !this.personalProfile.residence_country_code) { return "Unknown"; }
      let residencyCountryInfo = countrydata.countries[this.personalProfile.residence_country_code];
      let residencyCountryName = residencyCountryInfo.name;
      let residencyCountryFlag = residencyCountryInfo.emoji;

      return `${residencyCountryName} ${residencyCountryFlag}`;
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
    preferredFoot() {
      return _.capitalize(this.personalProfile.preferred_foot);
    },
    playingPositions() {
      if(!this.personalProfile) { return [] }
      return this.personalProfile.playing_positions;
    },
    careerHistory() {
      if(!this.user) { return [] }
      return this.user.career_history || [];
    },
    biography() {
      if(!this.personalProfile || !this.personalProfile.biography) { return "This user has not written anything yet"; }
      return this.personalProfile.biography;
    },
    media() {
      if(!this.user) { return [] }
      return this.user.media || [];
    }
  },
  methods: {
    s3UploadError(errorMessage) {
      console.error(errorMessage);
    },
    s3UploadSuccess(s3ObjectLocation, response) {
      console.info(s3ObjectLocation);
      const data = { media_url: s3ObjectLocation };
      fetch(`/api/v1/users/${this.$store.state.user.value.id}/media`, {
        method: 'POST',
        headers: {
          Authorization: this.$store.state.token.value,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
      })
    }
  }
};
</script>
