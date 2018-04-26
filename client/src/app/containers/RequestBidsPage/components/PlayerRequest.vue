<template>
  <div class="wrapper ft-item">
    <div class="header-wrapper col-md-12">
      <div class="header col-md-12 row">
        <div class="col-md-4 header-title">
          <h5 class="title">Player Request</h5>
          <p class="id">{{request.id | requestId(request.type_request) }}</p>
        </div>
      </div>
    </div>
    <div class="content-wrapper">
      <div class="content col-md-12">
        <div class="img-container">
          <img class="img-fluid avatar" src="/images/landing-page/ft-icons-player.png" />
          <p>
            <span>DEADLINE {{request.deadline | moment}}</span>
          </p>
          <p class="price" v-if="request.price">{{request.price.value}} {{request.price.currency | currency}}</p>
        </div>
        <div class="info col-md-8">
          <h2 class="title">
            <span class="target" v-if="request.player">
              <router-link :to="{ name: 'userProfilePage', params: { id: request.meta_data.player_id }}" target="_blank">{{request.player.first_name}} {{request.player.last_name}}</router-link>
            </span>
            <span class="target" v-if="!request.player">{{request.meta_data.player_name}}</span>
          </h2>
          <p class="extra">
            <span v-if="!request.player">
              <span class="field row">
                <span class="col-md-4">Age: </span>
                <span class="col-md-6">{{ request.meta_data.age}}
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Position(s):</span>
                <span class="col-md-6">
                  <span class="list" v-for="position in request.meta_data.playing_position" :key="position.id">{{position}}</span>
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Preferred Foot:</span>
                <span class="col-md-6">{{ request.meta_data.preferred_foot | preferredFoot}}
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Language(s):</span>
                <span class="col-md-6">
                  <span class="list" v-for="language in request.meta_data.languages" :key="language.id">{{getLanguage(language)}}</span>
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Nationality: </span>
                <span class="col-md-6">{{getNationality(request.meta_data.nationality_country_code)}}
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Based in: </span>
                <span class="col-md-6">{{getNationality(request.meta_data.residence_country_code)}}
                </span>
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Min Match Observed: </span>
              <span class="col-md-6">{{ request.meta_data.min_matches}}
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4 yes" v-if="request.meta_data.training_report == 'yes'">Training report required</span>
            </span>
            <span class="field row">
              <span class="col-md-4">Comments: </span>
              <span class="col-md-6">{{ request.meta_data.comments}}
              </span>
            </span>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>
<style lang="scss">
@import '~stylesheets/variables';
@import '~stylesheets/form';
</style>

<style lang="scss" scoped>
@import '~stylesheets/item';
</style>
<script>
import countrydata from 'country-data';

export default {
  name: 'RequestItem',
  props: ['request'],
  data() {
    return {
      price: this.request.price.value
    };
  },
  methods: {
    getLanguage(key) {
      return countrydata.languages[key] ? countrydata.languages[key].name : '';
    },
    getNationality(key) {
      return countrydata.countries[key] ? countrydata.countries[key].name : '';
    }
  }
};
</script>
