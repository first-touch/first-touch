<template>
  <div>
    <table class="table analyzed_matches">
      <thead>
        <tr>
          <th scope="col" class="col-md-2">Date</th>
          <th scope="col" class="col-md-2">Opponent</th>
          <th class="col-md-2">Venue</th>
          <th v-if="type == 'team'" class="col-md-2">Result</th>
          <th v-if="type == 'player'" class="col-md-2">Training Observed </th>
          <th v-if="type == 'player'" class="col-md-2">Comment</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(match, index) in analyzed_matches" v-bind:key="match.id">
          <td>
            <datepicker :input-class="[match.date != '' ? 'selected': '', 'input-date'].join(' ')" v-model="match.date" class="datepicker" format="MM/dd/yyyy"></datepicker>
          </td>
          <td>
            <input type="text" v-model="match.opponent" />
          </td>
          <td>
            <input type="text" v-model="match.venue" />
          </td>
          <td v-if="type == 'team'">
            <input type="text" v-model="match.comment" />
          </td>
          <td v-if="type == 'player'">
            <select v-model="match.training">
              <option value="true" selected>Yes</option>
              <option value="false">No</option>
            </select>
          </td>
          <td v-if="type == 'player'">
            <input type="text" v-model="match.comment" /> </td>
          <td class="remove-items">
            <a v-if="analyzed_matches.length > 1" @click="removeRowMatches(index)">X</a>
          </td>
        </tr>
      </tbody>
    </table>
    <button class="button row btn-primary add-match" @click="addRowMatches">Add Match</button>
  </div>
</template>
<style lang="scss">
  .analyzed_matches {
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
@import "~stylesheets/variables";
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
  }
</style>

<script>
  import Datepicker from 'vuejs-datepicker';

  export default {
    name: 'MatchAnalyzed',
    props: ['analyzed_matches','type'],
    components: {
      datepicker: Datepicker
    },
    methods: {
      removeRowMatches: function (index) {
        this.analyzed_matches.length > 1 ?
          this.analyzed_matches.splice(index, 1) :
          '';
      },
      addRowMatches: function () {
        this.analyzed_matches.push({
          date: '',
          opponent: '',
          venue: '',
          comment: '',
        });
      }
    }
  };
</script>
