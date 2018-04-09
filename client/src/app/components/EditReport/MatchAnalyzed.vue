<template>
  <div class="analyzed_matches ">
    <div class="row header col-md-12" :class="type">
      <div class="col">
        Date
      </div>
      <div class="col">
        Opponent
      </div>
      <div class="col">
        Venue
      </div>
      <div class="col" v-if="type == 'team'">
        Result
      </div>
      <div class="col" v-if="type == 'player'">
        Training Observed
      </div>
      <div class="col" v-if="type == 'player'">
        Comment
      </div>
    </div>
    <div class="content col-md-12" :class="type">
      <div class="row col-md-12" v-for="(match, index) in analyzed_matches" v-bind:key="match.id">
        <div class="col">
          <datepicker :input-class="[match.date != '' ? 'selected': '', 'input-date'].join(' ')" v-model="match.date" class="datepicker"
            format="MM/dd/yyyy"></datepicker>
        </div>
        <div class="col">
          <input type="text" v-model="match.opponent" />
        </div>
        <div class="col">
          <input type="text" v-model="match.venue" />
        </div>
        <div class="col" v-if="type == 'team'">
          <input type="text" v-model="match.result" />
        </div>
        <div class="col" v-if="type == 'player'">
          <vselect v-model="match.training" :options="['Yes','No']" />
        </div>
        <div class="col" v-if="type == 'player'">
          <input type="text" v-model="match.comment" />
        </div>
      </div>
    </div>
    <button class="button row  add-match" @click="addRowMatches">Add Match</button>
  </div>
</template>
<style lang="scss">
.analyzed_matches {
  .v-select {
    height: 2.5em;
    .clearfix {
      height: 2.5em;
          border: 0;
    }
  }
  .datepicker {
    background: white;
    input.input-date {
      cursor: pointer;
      width: 100%;
      border: 0px;
      height: 2.5em;
      background: white;
      background: url('/images/calendar.png') no-repeat;
      background-size: 3em 2.5em;
      background-position: right;
      &.selected {
        background: url('/images/calendar-fill.png') no-repeat;
        background-size: 3em 2.5em;
        background-position: right;
      }
    }
  }
}
</style>
<style lang="scss" scoped>
@import '~stylesheets/variables';

.header {
}

.content {
  margin: 0;
  padding: 0;
  &.player {
    margin: 0;
    padding: 0;
    .row {
      margin: 0;
      padding: 0;
      .col {
        margin: 0;
        padding: 0;
        width: 20%;
        // overflow: hidden;
        height: 2.5em;
      }
    }
  }
}

.analyzed_matches {
  margin: 0;
  td,
  th {
    border: 1px solid grey;
    width: 10%;
    text-align: center;
    height: 2.5em;
  }
  .remove-items {
    border: none;
    a {
      color: red;
      cursor: pointer;
    }
  }
  td {
    padding: 0;
    margin: 0;
  }
  input,
  select {
    border: none;
    text-align: center;
    width: 100%;
    height: 100%;
  }
  color: $main-text-color;
  background: white;
}

.add-match {
  margin: 0;
  padding: 4px;
  font-size: 10px;
  background: $main-header-color;
  border-color: $main-header-color;
  border-radius: 4px;
  cursor: pointer;
  color:white;
}
</style>

<script>
import Datepicker from 'vuejs-datepicker';
import vSelect from 'vue-select';

export default {
  name: 'MatchAnalyzed',
  props: ['analyzed_matches', 'type'],
  components: {
    datepicker: Datepicker,
    vselect: vSelect
  },
  methods: {
    removeRowMatches: function(index) {
      this.analyzed_matches.length > 1 ? this.analyzed_matches.splice(index, 1) : '';
    },
    addRowMatches: function() {
      this.analyzed_matches.push({
        date: '',
        opponent: '',
        venue: '',
        comment: '',
        training: 'No'
      });
    }
  }
};
</script>
