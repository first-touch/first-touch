<template>
  <div class="wrapper ft-item">
    <div class="header-wrapper col-md-12">
      <div class="header col-md-12 row">
        <div class="col-md-4 header-title">
          <h5 class="title">Team Request</h5>
          <p class="id">{{request.id | requestId(request.type_request) }}</p>
        </div>
        <div class="col-md-8 buttons-inner" v-if="!closeAction">
          <button class="ft-button" @click="closeAction(request)">Close</button>
        </div>
      </div>
    </div>
    <div class="content-wrapper">
      <div class="content col-md-12">
        <div class="img-container">
          <img class="img-fluid avatar" src="/images/landing-page/ft-icons-club.png" />
          <p>
            <span>DEADLINE {{request.deadline | moment}}</span>
          </p>
          <p class="price" v-if="request.price">{{request.price.value}} to {{request.price.max}} {{request.price.currency | currency}}</p>
        </div>
        <div class="info col-md-8">
          <h2 class="title">
            <span class="target" v-if="request.team">
              {{request.team.team_name}}
            </span>
            <span class="target" v-if="!request.team"> {{request.meta_data.search.team}}</span>
          </h2>
          <p class="extra">
            <span class="field row">
              <span class="col-md-4">Min Match Observed: </span>
              <span class="col-md-6">{{ request.meta_data.min_matches}}
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">League:</span>
              <span class="col-md-6" v-if="!request.team">
                {{request.meta_data.search.league}}
              </span>
              <span class="col-md-6" v-if="request.team">
                <span class="list" v-for="cp in request.team.competitions.competitions" :key="cp.id">{{cp.name}} </span>
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
    props: ['request', 'closeAction'],
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
