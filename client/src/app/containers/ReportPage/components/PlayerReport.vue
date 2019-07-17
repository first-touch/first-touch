<template>
  <div v-if="report.id">
    <timeline-item>
      <h4 class="spaced-title upper-cased main-header-color mb-2">{{report.headline}}</h4>
      <div class="row">
        <div class="col-6">
          <p>UPDATED {{report.meta_data.created_at | moment}}</p>
        </div>
        <div class="col-6">
          <p>
            Price:
            <span>
              {{report.price.value}} {{report.price.currency | currency}}
            </span>
          </p>
        </div>
      </div>
      <div class="row">
        <div class="col-6">
          <user-avatar :src="currentAvatar" :is-editor="false" />
        </div>
        <div class="col-6">
          <h4 class="upper-cased main-header-color" v-if="report.player">{{report.player.first_name}} {{report.player.last_name}}</h4>
          <h4 class="upper-cased main-header-color" v-if="!report.player && report.meta_data.search">{{report.meta_data.search.player}} </h4>
          <p class="role">Football Player</p>
          <p class="team" v-if="!report.team_info && report.team">{{report.team.team_name}}
            <span class="list" v-for="comp in report.team.competitions.competitions" :key="comp.id"> {{comp.name}}</span>
          </p>
          <p class="detail">
            <span class="detail-title">Age:</span>
            <span v-if="report.player"> {{ playerInfo.birthday | age }}</span>
            <span v-if="!report.player"> {{ playerInfo.age }}</span>
          </p>
          <p class="detail">
            <span class="detail-title">Team:</span>
            <span v-if="report.team_info">
              <span class="list" v-for="team in report.team_info.teams" :key="team.id">{{team.team_name}}</span>
            </span>
            <span v-if="!report.team_info && report.meta_data.search">
              {{report.meta_data.search.club}}
            </span>
          </p>
          <p class="detail">
            <span class="detail-title">League:</span>
            <span v-if="report.team_info">
              <span class="list" v-for="team in report.team_info.teams" :key="team.id">
                <span class="list" v-for="comp in team.competitions.competitions" :key="comp.id"> {{comp.name}}</span>
              </span>
            </span>
            <span v-if="!report.team_info && report.meta_data.search">
              <span v-if="report.league">
                {{report.league.name}}
              </span>
              <span v-if="!report.league">
                {{report.meta_data.search.league}}
              </span>

            </span>
          </p>
          <p class="detail">
            <span class="detail-title">Nationality:</span>
            <span v-if="playerInfo.nationality_country_code"> {{getNationality(playerInfo.nationality_country_code)}}</span>
          </p>
          <p class="detail">
            <span class="detail-title">Place of birth:</span>
            <span v-if="playerInfo.nationality_country_code"> {{getNationality(playerInfo.nationality_country_code)}}</span>
          </p>
        </div>
      </div>
      <hr />
      <h5 class="spaced-title upper-cased">Summary</h5>
      <div class="row">
        <div class="col-4">
          <p class="summary-field" v-if="playerInfo.height">
            <span class="summary-field-title">Height:</span>
            <span v-if="playerInfo.height">{{playerInfo.height}} cm</span>
          </p>
        </div>
        <div class="col-4">
          <p class="summary-field" v-if="playerInfo.weight">
            <span class="summary-field-title">Weight:</span>
            <span v-if="playerInfo.weight">{{playerInfo.weight}} kg</span>
          </p>
        </div>
        <div class="col-4">
          <p class="summary-field" v-if="playerInfo.preferred_foot">
            <span class="summary-field-title">Preferred Foot:</span>
            <span v-if="playerInfo.preferred_foot">{{playerInfo.preferred_foot | preferredFoot}}</span>
          </p>
        </div>
        <div class="col-4">
          <p class="summary-field" v-if="playerInfo.languages">
            <h5 class="summary-field-title">Language(s): </h5>
            <span class="">
              <span v-for="language in playerInfo.languages" class="list" :key="language.id">{{getLanguage(language)}}</span>
            </span>
          </p>
        </div>
        <div class="col-4">
          <p class="summary-field" v-if="playerInfo.residence_country_code">
            <span class="summary-field-title">Based in:</span>
            {{getNationality(playerInfo.residence_country_code)}}
          </p>
        </div>
      </div>
      <div class="row">
        <div class="col-12" v-if="playerInfo.playing_position">
          <p class="position-title">Playing position(s):</p>
          <player-position class="col-lg-8" :value="playerInfo.playing_position" :readonly="true" />
        </div>
      </div>
    </timeline-item>
    <timeline-item>
      <h5 class="spaced-title upper-cased"> Contract Summary </h5>
      <div class="row">
        <h5 class="col-12">
          <v-icon v-if="report.meta_data.transfer_sum.transfer_interested !== 'No'" name="check"></v-icon>
          <v-icon v-if="report.meta_data.transfer_sum.transfer_interested === 'No'" name="times"></v-icon>
          Interested in Transfer
        </h5>
      </div>
      <div class="row">
        <h5 class="col-12">
          <v-icon v-if="report.meta_data.transfer_sum.loan_interested !== 'No'" name="check"></v-icon>
          <v-icon v-if="report.meta_data.transfer_sum.loan_interested === 'No'" name="times"></v-icon>
          Interested in Loan
        </h5>
      </div>
    </timeline-item>

    <timeline-item>
      <h5 class="spaced-title upper-cased"> Details </h5>
      <div class="row mb-3">
        <div class="col-12">
          <h5>Analyzed Matches</h5>
          <match-analyzed :analyzed_matches="report.meta_data.analyzed_matches" type="player" mode="read" />
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-12">
          <h5>Current Ability Overview</h5>
          <p>{{report.meta_data.overview}} </p>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-12">
          <h5>Physical Attribute(s)</h5>
          <p> {{report.meta_data.physical_attributes}} </p>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-12">
          <h5>Mental Attribute(s)</h5>
          <p> {{report.meta_data.mental_attributes}} </p>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-12">
          <h5>Technical Attribute(s)</h5>
          <p> {{report.meta_data.technical_attributes}} </p>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-12">
          <h5>Personality</h5>
          <p> {{report.meta_data.personality}}</p>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-12">
          <h5>Potential</h5>
          <p> {{report.meta_data.potential}} </p>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-12">
          <h5>Other Observations & Viewpoints To Note</h5>
          <p> {{report.meta_data.observations}} </p>
        </div>
      </div>
      <div class="row mb-3">
        <div class="col-12">
          <h5>Conclusion</h5>
          <p> {{report.meta_data.conclusion}} </p>
        </div>
      </div>
      <div class="row">
        <div class="col-12">
          <h5>Attachments</h5>
          <button v-for="attachment in report.attachments.attachments"
                  :key="attachment.id"
                  class="btn-info btn-attachments ft-button"
                  @click="downloadFile(attachment.url, attachment.filename)">
            {{attachment.filename}}
          </button>
        </div>
      </div>
    </timeline-item>
  </div>
</template>

<script>
import MatchAnalyzed from 'app/components/Input/MatchAnalyzed';
import PlayerPosition from 'app/components/Input/PlayerPosition';

import VIcon from 'vue-awesome/components/Icon';
import countrydata from 'country-data';
import TimelineItem from 'app/components/TimelineItem';
import UserAvatar from "app/components/UserAvatar";

export default {
  name: 'PlayerReport',
  props: ['report', 'downloadFile'],
  components: {
    VIcon,
    PlayerPosition,
    MatchAnalyzed,
    TimelineItem,
    UserAvatar
  },
  data() {
    return {};
  },
  computed: {
    playerInfo() {
      if (this.report) {
        if (this.report.player) return this.report.player;
        if (this.report.meta_data.player_info) return this.report.meta_data.player_info;
      }
      return null;
    },
    currentAvatar() {
      if(!this.playerInfo) { return ""; }
      return this.playerInfo.avatar_url;
    }
  },
  methods: {
    getLanguage(key) {
      return countrydata.languages[key] ? countrydata.languages[key].name : 'key';
    },
    getNationality(key) {
      return countrydata.countries[key] ? countrydata.countries[key].name : 'key';
    }
  }
};
</script>
