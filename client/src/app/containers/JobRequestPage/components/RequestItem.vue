<template>
  <div class="wrapper">
    <div class="header-wrapper">
      <div class="header col-md-10">
        <div class="img-container">
          <img class="img-fluid avatar" :src="src" />
        </div>
        <div class="info col-md-8" v-if="request.type_request == 'position'">
          <h2 class="title" :title="request.headline">
            <span class="list" v-for="position in request.report_data.playing_position" :key="position.id">{{position}}</span>
            Based in {{getNationality(request.report_data.residence_country_code)}} </h2>
          <p class="extra">
            <span class="target yes" v-if="request.report_data.loan == 'yes'">Interested In Loan</span>
            <span class="target yes" v-if="request.report_data.transfer == 'yes'">Interested In Transfer</span>
            <span class="target yes" v-if="request.report_data.expiring_contract == 'yes'">Expiring Contract</span>
            <span>{{request.created_at | moment}} -> {{request.deadline | moment}}</span>
          </p>
        </div>
        <div class="info col-md-8" v-if="request.type_request == 'player'">
          <h2 class="title" :title="request.headline">
            <span class="list" v-for="position in request.report_data.playing_position" :key="position.id">{{position}}</span>
            Based in {{getNationality(request.report_data.residence_country_code)}} </h2>
          <p class="extra">
            <span class="target">{{request.player.first_name}} {{request.player.last_name}} </span>
            <span>{{request.created_at | moment}} -> {{request.deadline | moment}}</span>
          </p>
        </div>
        <div class="info col-md-8" v-if="request.type_request == 'team'">
          <h2 class="title" :title="request.headline">
            Real Madrid Fc WIP </h2>
          <p class="extra">
            <span>{{request.created_at | moment}} -> {{request.deadline | moment}}</span>
          </p>
        </div>
      </div>
      <div class="widget">
        <router-link :to="`/club/request/${request.id}`">
          <button class="btn-round">View</button>
        </router-link>
        <a v-if="request.status == 'publish'" @click="update(request.id, 'private')">
          <button class="btn-round">Unpublish</button>
        </a>
        <a v-if="request.status == 'private'" @click="update(request.id, 'publish')">
          <button class="btn-round">Publish</button>
        </a>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .wrapper {
    padding: 0 30px;
    border-top: 1px solid $secondary-text-color;
    &:last-child {
      border-bottom: 1px solid $secondary-text-color;
    }
    .list {
      text-transform: capitalize;
      &::after {
        content: ', ';
      }
      &:last-child::after {
        content: '';
      }
    }
    .avatar {
      height: 300px;
      border-radius: 50%;
    }

    .title {
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      font-size: 15px;
    }
    .header-wrapper {
      display: flex;
      justify-content: space-between;
      .header {
        display: flex;
        .img-container {
          height: 120px;
          max-width: 120px;
          margin-right: 30px;
          .img-fluid {
            max-height: 100%;
          }
        }
        .info {
          display: flex;
          flex-direction: column;
          justify-content: center;
          .target {
            display: block;
            &.yes {
              color: $timeline-widget-button-background;
            }
          }
          .extra {
            text-transform: none;
            .author {
              color: #000;
            }
          }
        }
      }
      .widget {
        padding: 20px 0;
        display: flex;
        flex-direction: column;
        justify-content: space-around;
        .btn-round {
          cursor: pointer;
          border-radius: 9999px;
          border: 1px solid $secondary-text-color;
          background: #fff;
          width: 100px;
          &:hover {
            background: $button-background-hover;
          }
        }
      }
    }
  }
</style>
<script>
  import countrydata from 'country-data';

  export default {
    name: 'RequestItem',
    props: ['request', 'update'],
    methods: {
      getLanguage(key) {
        return countrydata.languages[key] ? countrydata.languages[key].name : key;
      },
      getNationality(key) {
        return countrydata.countries[key] ? countrydata.countries[key].name : key;
      }
    },
    computed: {
      src: function () {
        var src = '';
        switch (this.request.type_request) {
          case 'player':
            src = '/images/landing-page/ft-icons-player.png';
            break;
          case 'team':
            src = '/images/landing-page/ft-icons-club.png';
            break;
          case 'position':
            src = '/images/landing-page/ft-icons-player.png';
            break;
        }
        return src;
      }
    }
  };
</script>
