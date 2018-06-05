<template>
  <div>
    <h4 class="header" v-if="request.player">
      <router-link :to="{ name: 'userProfilePage', params: { id: request.player.id }}" target="_blank">{{playerName}} {{teamName}}</router-link>
    </h4>
    <h4 class="header" v-if="!request.player"> {{playerName}} {{teamName}} </h4>
    <timeline-item>
      <div class="wrapper ft-item">
        <div class="header-wrapper col-lg-12">
          <div class="header row">
            <div class="col-lg-8 header-title">
              <h5 class="title">Player Assignment Overview</h5>
            </div>
            <request-buttons class="col row" :toEdit="toEdit" :status="request.status" :updateStatus="updateStatus" />
          </div>
        </div>
        <div class="content-wrapper">
          <div class="content col-lg-12">
            <div class="info col-lg-8">
              <p class="extra">
                <span v-if="!request.player">
                  <span class="field row">
                    <span class="col-lg-4">Age: </span>
                    <span class="col-lg-6">{{ request.meta_data.age}}
                    </span>
                  </span>
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
                </span>
                <span class="field row">
                  <span class="col-lg-4">Min Match Observed: </span>
                  <span class="col-lg-6">{{ request.meta_data.min_matches}}
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
  import RequestButtons from './buttons';

  export default {
    name: 'RequestItem',
    props: ['request', 'updateStatus', 'toEdit'],
    components: {
      'timeline-item': TimelineItem,
      'request-buttons': RequestButtons
    },
    computed: {
      playerName() {
        if (this.request.player) {
          return this.request.player.first_name + ' ' + this.request.player.last_name;
        }
        return this.request.meta_data.search.player;
      },
      teamName() {
        if (this.request.team) {
          return this.request.team.team_name;
        }
        return this.request.meta_data.search.club;
      }
    },
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
      },
    }
  };
</script>
