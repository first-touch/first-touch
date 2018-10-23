<template>
  <div>
    <h4 class="spaced-title">My Bids List</h4>
    <timeline-item>
      <div class="wrapper ft-item">
        <div class="header-wrapper col-lg-12">
          <div class="header col-lg-12 row">
            <div class="col-lg-4 header-title">
              <h5 class="title">Position Assignment Overview</h5>
            </div>
          </div>
        </div>
        <div class="content-wrapper">
          <div class="content col-lg-12">
            <div class="info col-lg-8" v-if="request.type_request == 'position'">
              <h2 class="title">
                <span class="target" v-if="request.player">
                  <router-link :to="{ name: 'userProfilePage', params: { id: request.meta_data.player_id }}" target="_blank">{{request.player.first_name}} {{request.player.last_name}}</router-link>
                </span>
                <span class="target" v-if="!request.player">{{request.meta_data.player_name}}</span>
              </h2>
              <p class="extra">
                <span class="field row">
                  <span class="col-lg-4">DEADLINE: </span>
                  <span class="col-lg-6">{{request.deadline | moment}}
                  </span>
                </span>
                <span class="field row">
                  <span class="col-lg-4">Price range: </span>
                  <span class="col-lg-6">{{request.price.value}} to {{request.price.max}} {{request.price.currency | currency}}
                  </span>
                </span>
                <span v-if="!request.player">
                  <span class="field row">
                    <span class="col-lg-4">Age Range: </span>
                    <span class="col-lg-6">{{ request.meta_data.min_age}} to {{ request.meta_data.max_age}} years
                    </span>
                  </span>
                  <span class="field row">
                    <span class="col-lg-4">Weight Range: </span>
                    <span class="col-lg-6">{{ request.meta_data.min_height}} to {{ request.meta_data.max_height}} cm
                    </span>
                  </span>
                  <span class="field row">
                    <span class="col-lg-4">Height Range: </span>
                    <span class="col-lg-6">{{ request.meta_data.min_weight}} to {{ request.meta_data.max_weight}} kg
                    </span>
                  </span>
                  <span class="field row">
                    <span class="col-lg-4">Position(s):</span>
                    <span class="col-lg-6">
                      <span class="list" v-for="position in request.meta_data.playing_position" :key="position.id">{{position}}</span>
                    </span>
                  </span>
                  <span class="field row">
                    <span class="col-lg-4">Preferred Foot:</span>
                    <span class="col-lg-6">{{ request.meta_data.preferred_foot | preferredFoot}}
                    </span>
                  </span>
                  <span class="field row">
                    <span class="col-lg-4">Language(s):</span>
                    <span class="col-lg-6">
                      <span class="list" v-for="language in request.meta_data.languages" :key="language.id">{{getLanguage(language)}}</span>
                    </span>
                  </span>
                  <span class="field row">
                    <span class="col-lg-4">Nationality: </span>
                    <span class="col-lg-6">{{getNationality(request.meta_data.nationality_country_code)}}
                    </span>
                  </span>
                  <span class="field row">
                    <span class="col-lg-4">Based in: </span>
                    <span class="col-lg-6">{{getNationality(request.meta_data.residence_country_code)}}
                    </span>
                  </span>
                  <span class="field row" v-if="request.meta_data.passport">
                    <span class="col-lg-4">Passport: </span>
                    <span class="col-lg-6">{{request.meta_data.passport}}
                    </span>
                  </span>
                </span>
                <span class="field row">
                  <span class="col-lg-4 yes" v-if="request.meta_data.training_report == 'yes'">Training report required</span>
                </span>
                <span class="field row">
                  <span class="yes col-lg-4" v-if="request.meta_data.loan == 'yes'">Interested In Loan</span>
                </span>
                <span class="field row">
                  <span class="yes col-lg-4" v-if="request.meta_data.transfer == 'yes'">Interested In Transfer</span>
                </span>
                <span class="field row">
                  <span class="col-lg-4" v-if="request.meta_data.expiring_contract == 'yes'">Expiring Contract</span>
                  <span class="col-lg-6">{{ request.meta_data.expiring_contract_min | moment}} to {{ request.meta_data.expiring_contract_max | moment}}</span>
                </span>
                <span class="field row">
                  <span class="col-lg-4">Player Value: </span>
                  <span class="col-lg-6">{{ request.meta_data.value.value}} to {{ request.meta_data.value.max}} {{ request.meta_data.value.currency
                    | currency}}
                  </span>
                </span>
                <span class="field row">
                  <span class="col-lg-4">Wage Budget: </span>
                  <span class="col-lg-6">{{ request.meta_data.wage_budget.value}} {{ request.meta_data.wage_budget.currency | currency}}
                  </span>
                </span>
                <span class="field row">
                  <span class="col-lg-4">Desirable Attributes: </span>
                  <span class="col-lg-6">{{ request.meta_data.desirable_attributes}}
                  </span>
                </span>
                <span class="field row" v-if="request.meta_data.comments">
                  <span class="col-lg-4">Comments: </span>
                  <span class="col-lg-6">{{ request.meta_data.comments}}
                  </span>
                </span>
              </p>
            </div>
          </div>
        </div>
      </div>
    </timeline-item>
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
  import TimelineItem from 'app/components/TimelineItem';

  export default {
    name: 'RequestItem',
    props: ['request'],
    components: {
      'timeline-item': TimelineItem
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
