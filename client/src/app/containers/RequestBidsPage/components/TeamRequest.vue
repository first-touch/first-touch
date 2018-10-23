<template>
  <div>
    <h4 class="spaced-title">{{teamName}} {{leagueName}}</h4>
    <timeline-item>

      <div class="wrapper ft-item">
        <div class="header-wrapper col-lg-12">
          <div class="header row">
            <div class="col-lg-8 header-title">
              <h5 class="title">Team Assignment Overview</h5>
            </div>
            <request-buttons class="col row" :toEdit="toEdit" :status="request.status" :updateStatus="updateStatus"/>
          </div>
        </div>
        <div class="content-wrapper">
          <div class="content col-lg-12">
            <div class="info col-lg-8">
              <p class="extra">
                <span class="field row">
                  <span class="col-lg-4">Created at: </span>
                  <span class="col-lg-6">{{ request.created_at | moment}}
                  </span>
                </span>
                <span class="field row">
                  <span class="col-lg-4">DEADLINE: </span>
                  <span class="col-lg-6">{{request.deadline | moment}}
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
    props: ['request', 'updateStatus','toEdit'],
    components: {
      'timeline-item': TimelineItem,
      'request-buttons': RequestButtons
    },

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
      },
      leagueName() {
        if (this.request.league) {
          return this.request.league.name;
        }
        return this.request.meta_data.search.league;
      },
      teamName() {
        if (this.request.team) {
          return this.request.team.team_name;
        }
        return this.request.meta_data.search.club;
      }
    }
  };
</script>
