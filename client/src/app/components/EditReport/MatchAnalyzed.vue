<template>
  <div class="analyzed_matches ">
    <div class="row header col-md-12" :class="type">
      <div class="remove">
      </div>
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
        <div class="remove" v-if="analyzed_matches.length > 1" @click="removeRowMatches(index)">
          <icon name='trash'></icon>
        </div>
        <div class="col" @click="showCalendar(index)" :class="match.date != '' ? 'date-selected': ''">
          <datepicker ref="datepicker" input-class="input-date" v-model="match.date" class="datepicker col-md-8" format="MM/dd/yyyy"></datepicker>
          <icon name='calendar-alt' v-if="match.date == ''"></icon>
          <icon name='calendar-check' v-if="match.date != ''"></icon>

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
  @import '~stylesheets/variables';
  .analyzed_matches {
    .v-select {
      height: 2.5em;
      .selected-tag {
        color: $main-text-color;
      }
      .clearfix {
        height: 2.5em;
        border: 0;
      }
    }
    .input-date {
      color: $main-text-color;
    }
    .datepicker {
      background: white;
      display: inline-block;
      input.input-date {
        cursor: pointer;
        width: 100%;
        border: 0px;
        height: 2.5em;
        background: white;
      }
    }
  }
</style>
<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .header {
    .col {
      color: $main-text-color;
      font-weight: bold;
    }
    .remove {
      width: 2%;
      max-width: 20px;
    }
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
          color: $main-text-color;

          input,
          .selected-tag {
            color: $main-text-color;
          }
          margin: 0;
          padding: 0;
          width: 20%; // overflow: hidden;
          height: 2.5em;
        }
        .remove {
          width: 2%;
          padding-top: 10px;
          max-width: 20px;
          cursor: pointer;
          &:hover {
            color: red;
          }
        }
      }
    }
  }

  .analyzed_matches {
    margin: 0;
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
    border-radius: 4px;
    color: white;
    min-height: 20px;
    color: $main-text-color;
    border: 1px solid $main-text-color;
    background-color: $button-background;
    cursor: pointer;
    &:hover{
      background-color: $button-background-hover;
    }
  }
</style>

<script>
  import Datepicker from 'vuejs-datepicker';
  import vSelect from 'vue-select';
  import 'vue-awesome/icons/trash';
  import 'vue-awesome/icons/calendar-alt';
  import 'vue-awesome/icons/calendar-check';

  import Icon from 'vue-awesome/components/Icon';

  export default {
    name: 'MatchAnalyzed',
    props: ['analyzed_matches', 'type'],
    components: {
      datepicker: Datepicker,
      vselect: vSelect,
      icon: Icon
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
          training: 'No'
        });
      },
      showCalendar: function (index) {
        this.$refs.datepicker[index].showCalendar();
      }
    }
  };
</script>
