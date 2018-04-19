<template>
  <div class="wrapper">
    <div class="header-wrapper">
      <div class="header col-md-10">
        <div class="img-container">
          <img class="img-fluid avatar" :src="src" />
        </div>
        <div class="info col-md-8" v-if="request.type_request == 'position'">
          <h2 class="title">
            <span class="list" v-for="position in request.meta_data.playing_position" :key="position.id">{{position}}</span>
          </h2>
          <p class="extra">
            <span class="field row">
              <span class="col-md-4">Request Id:</span>
              <span class="col-md-6"> {{request.id | requestId(request.type_request) }}
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Position:</span>
              <span class="col-md-6">
                <span class="list" v-for="position in request.meta_data.playing_position" :key="position.id">{{position}}</span>
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Based in: </span>
              <span class="col-md-6">{{getNationality(request.meta_data.residence_country_code)}}
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Deadline </span>
              <span class="col-md-6">{{request.deadline | moment}}
              </span>
            </span>
            <span class="field yes row" v-if="request.meta_data.loan == 'yes'">
              <span class="col-md-12">Interested In Loan</span>
            </span>
            <span class="field yes row" v-if="request.meta_data.transfer == 'yes'">
              <span class="col-md-12">Interested In Transfer</span>
            </span>
            <span class="field yes row" v-if="request.meta_data.expiring_contract == 'yes'">
              <span class="col-md-4">Expiring Contract: </span>
              <span class="col-md-6">
                {{request.meta_data.expiring_contract_min | moment}} to {{request.meta_data.expiring_contract_max | moment}}
              </span>
            </span>
          </p>
        </div>
        <div class="info col-md-8" v-if="request.type_request == 'player'">
          <h2 class="title">
            <span class="target" v-if="request.player">{{request.player.first_name}} {{request.player.last_name}} </span>
            <span class="target" v-if="!request.player">{{request.meta_data.player_name}}</span>
          </h2>
            <span class="pending" v-if="request.request_bids && request.request_bids.status =='pending'">Bid in pending</span>
          <p class="extra">
            <span class="field row">
              <span class="col-md-4">Request Id:</span>
              <span class="col-md-6"> {{request.id | requestId(request.type_request) }}
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Position:</span>
              <span class="col-md-6">
                <span class="list" v-for="position in request.meta_data.playing_position" :key="position.id">{{position}}</span>
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Based in: </span>
              <span class="col-md-6">{{getNationality(request.meta_data.residence_country_code)}}
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Deadline </span>
              <span class="col-md-6">{{request.deadline | moment}}
              </span>
            </span>
          </p>
        </div>
        <div class="info col-md-8" v-if="request.type_request == 'team'">
          <h2 class="title">
            Real Madrid Fc WIP </h2>
          <span class="pending" v-if="request.request_bids && request.request_bids.status =='pending'">Bid in pending</span>
          <p class="extra">
            <span class="field row">
              <span class="col-md-4">Request Id:</span>
              <span class="col-md-6"> {{request.id | requestId(request.type_request) }}
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">League:</span>
              <span class="col-md-6">
                WIP
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Player In Databases</span>
              <span class="col-md-6">WIP
              </span>
            </span>
            <span class="field row">
              <span class="col-md-4">Deadline </span>
              <span class="col-md-6">{{request.deadline | moment}}
              </span>
            </span>
          </p>
        </div>
      </div>
      <div class="widget col-md-2">
        <router-link v-if="own" :to="{ name: 'clubRequest', params: { id: request.id }}">
          <button class="btn-round">Edit</button>
        </router-link>
        <router-link v-if="own" :to="{ name: 'clubRequestBids', params: { id: request.id }}">
          <button class="btn-round">View Bids</button>
        </router-link>
        <a v-if="request.status == 'publish' && own" @click="update(request.id, 'private')">
          <button class="btn-round">Unpublish</button>
        </a>
        <a v-if="request.status == 'private' && own" @click="update(request.id, 'publish')">
          <button class="btn-round">Publish</button>
        </a>
        <a v-if="!own" @click="viewSummary(request)">
          <button class="btn-round">View Details</button>
        </a>
        <a v-if="!own && request.type_request != 'position' && addBid" @click="addBid(request)">
          <button class="btn-round" v-if="request.request_bids">Update Bid</button>
          <button class="btn-round" v-if="!request.request_bids">Bid</button>
        </a>
        <a v-if="!own && request.type_request == 'position' && addBid" @click="addBid(request)">
          <button class="btn-round">+ To job list</button>
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
    color: $secondary-header-color;
    text-transform: uppercase;
    letter-spacing: 3px;
    font-size: 15px;
  }
  .pending{
    font-weight: bold;
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
      padding: 0 0;
      display: flex;
      flex: 1;
      flex-direction: column;
      justify-content: space-around;
      a {
        display: flex;
        flex: 1;
        max-height: 50px;
        .btn-round {
          margin: 10px;
          width: 100%;
          max-width: 140px;
          flex: 1;
          display: flex;
          justify-content: center;
          text-align: center;
          color: $main-text-color;
          cursor: pointer;
          border-radius: 9999px;
          border: 1px solid $secondary-text-color;
          background: #fff;
          &:hover {
            background: $button-background-hover;
          }
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
  props: ['request', 'update', 'own', 'viewSummary', 'addBid'],
  methods: {
    getLanguage(key) {
      return countrydata.languages[key] ? countrydata.languages[key].name : key;
    },
    getNationality(key) {
      return countrydata.countries[key] ? countrydata.countries[key].name : key;
    }
  },
  computed: {
    src: function() {
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
