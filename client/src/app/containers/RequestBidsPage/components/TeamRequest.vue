<template>
  <div class="wrapper ft-item">
    <div class="header-wrapper col-lg-12">
      <div class="header col-lg-12 row">
        <div class="col-lg-4 header-title">
          <h5 class="title">Team Request</h5>
          <p class="id">{{request.id | requestId(request.type_request) }}</p>
        </div>
      </div>
    </div>
    <div class="content-wrapper">
      <div class="content col-lg-12">
        <div class="img-container">
          <img class="img-fluid avatar" src="/images/landing-page/ft-icons-club.png" />
          <p>
            <span>DEADLINE {{request.deadline | moment}}</span>
          </p>
        </div>
        <div class="info col-lg-8">
          <h2 class="title">
            <span class="target" v-if="request.team">
              <router-link v-if="clubProfile" :to="{ name: 'teamProfilePage', params: { id: request.team.id }}" target="_blank">{{request.team.team_name}} </router-link>
              <span v-if="!clubProfile">{{request.team.team_name}} </span>
            </span>
            <span class="target" v-if="!request.team">TEAM NAME</span>
          </h2>
          <p class="extra">
            <span class="field row">
              <span class="col-lg-4">Created at: </span>
              <span class="col-lg-6">{{ request.created_at | moment}}
              </span>
            </span>
            <span class="field row">
              <span class="col-lg-4">Min Match Observed: </span>
              <span class="col-lg-6">{{ request.meta_data.min_matches}}
              </span>
            </span>
            <span class="field row">
              <span class="col-lg-4">Price range: </span>
              <span class="col-lg-6">{{request.price.value}} to {{request.price.max}} {{request.price.currency | currency}}
              </span>
            </span>
            <span class="field row">
              <span class="col-lg-4 yes" v-if="request.meta_data.training_report == 'yes'">Training report required</span>
            </span>
            <span class="field row">
              <span class="col-lg-4">Comments: </span>
              <span class="col-lg-6">{{ request.meta_data.comments}}
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
      return {};
    },
    methods: {
      getLanguage(key) {
        return countrydata.languages[key] ? countrydata.languages[key].name : '';
      },
      getNationality(key) {
        return countrydata.countries[key] ? countrydata.countries[key].name : '';
      }
    },
    computed: {
      clubProfile() {
        return this.$router.matcher.match({
          name: 'teamProfilePage'
        }).matched.length > 0
      }
    }
  };
</script>
