<template>
  <div class="analyzed-matches">
    <div class="row header" :class="type">
      <div class="remove" v-if="!readonly"></div>
      <div class="col-2"> Date </div>
      <div class="col-2"> Opponent </div>
      <div class="col-2"> Venue </div>
      <div class="col-2" v-if="type == 'team'">
        Result
      </div>
      <div class="col-2" v-if="type == 'player'">
        Observation Type
      </div>
      <div class="col-3" v-if="type == 'player'">
        Comment
      </div>
    </div>
    <div class="row mt-2 mb-2" v-for="(match, index) in analyzed_matches" v-bind:key="match.id">
      <div class="remove" v-if="!readonly && analyzed_matches.length > 1" @click="removeRowMatches(index)">
        <icon name='trash'></icon>
      </div>

      <div class="col-2" :class="match.date != '' ? 'date-selected': ''">
        <ft-datepicker class="form-control" v-if="!readonly" placeholder="Date" :value="match.date" v-on:update:val="match.date = $event" />
        <span class="read" v-if="readonly">
          {{match.date | moment}}
        </span>
      </div>
      <div class="col-2" :title="match.opponent">
        <input type="text" class="form-control m-field-input" :readonly="readonly" v-model="match.opponent" />
      </div>
      <div class="col-2" :title="match.venue">
        <input type="text" class="form-control m-field-input" :readonly="readonly" v-model="match.venue" />
      </div>
      <div class="col-2" v-if="type == 'team'" :title="match.result">
        <input type="text" class="form-control m-field-input" :readonly="readonly" v-model="match.result" />
      </div>
      <div class="col-2" v-if="type == 'player'" :title="match.observation_type">
        <v-select v-if="!readonly" ref="vSelect" v-model="match.observation_type" :options="['Match','Training']" />
        <span class="read" v-if="readonly">{{match.observation_type}}</span>
      </div>
      <div class="col-3" v-if="type == 'player'" :title="match.comment">
        <input type="text" class="form-control m-field-input" :readonly="readonly" v-model="match.comment" />
      </div>
    </div>
    <div class="row">
      <div class="col-2">
        <button v-if="!readonly" class="btn btn-secondary" @click="addRowMatches">Add Match</button>
      </div>
    </div>
  </div>
</template>

<script>
  import VSelect from 'vue-select';
  import 'vue-awesome/icons/trash';
  import 'vue-awesome/icons/calendar-alt';
  import 'vue-awesome/icons/calendar-check';
  import 'vue-awesome/icons/times';
  import Icon from 'vue-awesome/components/Icon';
  import FtDatepicker from 'app/components/Input/FtDatepicker';

  export default {
    name: 'MatchAnalyzed',
    props: ['analyzed_matches', 'type', 'mode'],
    data() {
      return {
        readonly: this.mode == 'read'
      };
    },
    components: {
      VSelect,
      Icon,
      FtDatepicker
    },
    methods: {
      removeRowMatches: function (index) {
        this.analyzed_matches.length > 1 ? this.analyzed_matches.splice(index, 1) : '';
      },
      addRowMatches: function () {
        this.analyzed_matches.push({
          date: '',
          opponent: '',
          venue: '',
          comment: '',
          observation_type: ''
        });
      },
    }
  };
</script>
