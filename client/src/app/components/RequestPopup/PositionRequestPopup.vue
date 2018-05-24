<template>
  <div class="wrapper ft-item">
    <div class="header-wrapper col-md-12">
      <div class="header col-md-12 row">
        <div class="col-md-4 header-title">
          <h5 class="title">Position Request</h5>
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
          <img class="img-fluid avatar" src="/images/landing-page/ft-icons-player.png" />
          <p>
            <span>DEADLINE {{request.deadline | moment}}</span>
          </p>
          <p class="price" v-if="request.price">{{request.price.value}} to {{request.price.max}} {{request.price.currency | currency}}</p>
        </div>
        <div class="info col-md-8" v-if="request.type_request == 'position'">
          <h2 class="title">
            <span class="target" v-if="request.player">
              <router-link :to="{ name: 'userProfilePage', params: { id: request.meta_data.player_id }}" target="_blank">{{request.player.first_name}} {{request.player.last_name}}</router-link>
            </span>
            <span class="target" v-if="!request.player">{{request.meta_data.player_name}}</span>
          </h2>
          <p class="extra">
            <span v-if="!request.player">
              <span class="field row">
                <span class="col-md-4">Age Range: </span>
                <span class="col-md-6">{{ request.meta_data.age_min}} to {{ request.meta_data.age_max}} years
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Height Range: </span>
                <span class="col-md-6">{{ request.meta_data.min_heigth}} to {{ request.meta_data.max_heigth}} cm
                </span>
              </span>
              <span class="field row">
                <span class="col-md-4">Weight Range: </span>
                <span class="col-md-6">{{ request.meta_data.min_weight}} to {{ request.meta_data.max_weight}} kg
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
              <span class="field row" v-if="request.meta_data.passport">
                <span class="col-md-4">Passport: </span>
                <span class="col-md-6">{{request.meta_data.passport}}
                </span>
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4 yes" v-if="request.meta_data.training_report == 'yes'">Training report required</span>
            </span>
            <span class="field row">
              <span class="yes col-md-4" v-if="request.meta_data.loan == 'yes'">Interested In Loan</span>
            </span>
            <span class="field row">
              <span class="yes col-md-4" v-if="request.meta_data.transfer == 'yes'">Interested In Transfer</span>
            </span>
            <span class="field row">
              <span class="col-md-4" v-if="request.meta_data.expiring_contract == 'yes'">Expiring Contract</span>
              <span class="col-md-6">{{ request.meta_data.expiring_contract_min | moment}} to {{ request.meta_data.expiring_contract_max | moment}}</span>
            </span>
            <span class="field row">
              <span class="col-md-4">Player Value: </span>
              <span class="col-md-6">{{ request.meta_data.value.value}} to {{ request.meta_data.value.max}} {{ request.meta_data.value.currency
                | currency}}
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Wage Budget: </span>
              <span class="col-md-6">{{ request.meta_data.wage_budget.value}} {{ request.meta_data.wage_budget.currency | currency}}
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Desirable Attributes: </span>
              <span class="col-md-6">{{ request.meta_data.desirable_attributes}}
              </span>
            </span>
            <span class="field row" v-if="request.meta_data.comments">
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
