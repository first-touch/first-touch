<template>
  <div class="analyzed_matches ft-input">
    <div class="row header col-md-12" :class="type">
      <div class="remove" v-if="!readonly">
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
    <div class="content col-md-12" :class="[type, readonly? 'readonly': '']">
      <div class="row col-md-12" v-for="(match, index) in analyzed_matches" v-bind:key="match.id">
        <div class="remove" v-if="!readonly && analyzed_matches.length > 1" @click="removeRowMatches(index)">
          <icon name='trash'></icon>
        </div>
        <div class="col form-control" :class="match.date != '' ? 'date-selected': ''">
          <span v-if="!readonly" class="col-md-12">
            <datepicker ref="datepicker" input-class="input-date" v-model="match.date" class="datepicker col-md-9" format="dd,MMM yyyy"></datepicker>
            <span @click="match.date = ''" class="icon-inner">
              <icon name='times' v-if="match.date != ''"></icon>
            </span>
            <span @click="showCalendar(index)" class="icon-inner">
              <icon name='calendar-alt' v-if="match.date == ''"></icon>
              <icon name='calendar-check' v-if="match.date != ''"></icon>
            </span>
          </span>
          <p class="read" v-if="readonly">
            {{match.date | moment}}
          </p>
        </div>
        <div class="col form-control" :title="match.opponent">
          <input type="text" :readonly="readonly" v-model="match.opponent" />
        </div>
        <div class="col form-control" :title="match.venue">
          <input type="text" :readonly="readonly" v-model="match.venue" />
        </div>
        <div class="col form-control" v-if="type == 'team'" :title="match.result">
          <input type="text" :readonly="readonly" v-model="match.result" />
        </div>
        <div class="col form-control" v-if="type == 'player'" :title="match.training">
          <vselect v-if="!readonly" v-model="match.training" :options="['Yes','No']" />
          <p class="read" v-if="readonly">{{match.training}}</p>
        </div>
        <div class="col form-control" v-if="type == 'player'" :title="match.comment">
          <input type="text" :readonly="readonly" v-model="match.comment" />
        </div>
      </div>
    </div>
    <button v-if="!readonly" class="button row  add-match" @click="addRowMatches">Add Match</button>
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
    input {
      color: $main-text-color;
      text-align: left;
    }
    .datepicker {
      background: white;
      display: inline-block;
      input.input-date {
        cursor: pointer;
        width: 100%;
        border: 0px;
        height: 2.3em;
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
    &.readonly {
      .form-control {
        border: 0;
      }
      .read {
        margin-top: 9px;
      }
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
    .col,
    .col-md-12 {
      margin: 0;
      padding: 0;
      margin: 2px;
    }
    &.player {
      .row {
        .col {
          color: $main-text-color;
        }
      }
    }
  }

  .analyzed_matches {
    margin: 0;
    input,
    select {
      border: none;
      width: 100%;
      height: 100%;
    }
    color: $main-text-color;
    background: white;
    .icon-inner {
      cursor: pointer;
      &:hover {
        color: $secondary-header-color;
      }
    }
  }

  .add-match {
    margin: 10px 0 0 0;
    padding: 4px;
    min-height: 20px;
    font-size: 10px;
    color: white;
    color: $main-text-color;
    border: 1px solid $main-text-color;
    border-radius: 4px;
    background-color: $button-background;
    cursor: pointer;
    &:hover {
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
  import 'vue-awesome/icons/times';
  import Icon from 'vue-awesome/components/Icon';

  export default {
    name: 'MatchAnalyzed',
    props: ['analyzed_matches', 'type', 'mode'],
    data() {
      return {
        readonly: this.mode == 'read'
      };
    },
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
