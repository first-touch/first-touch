<template>
  <div class="analyzed_matches">
    <div class="row header" :class="type">
      <div class="remove" v-if="!readonly"></div>
      <div class="col"> Date </div>
      <div class="col"> Opponent </div>
      <div class="col"> Venue </div>
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
    <div class="row mt-1 mb-1" v-for="(match, index) in analyzed_matches" v-bind:key="match.id">
      <div class="remove" v-if="!readonly && analyzed_matches.length > 1" @click="removeRowMatches(index)">
        <icon name='trash'></icon>
      </div>

      <div class="col" :class="match.date != '' ? 'date-selected': ''">
        <ftdatepicker class="form-control" v-if="!readonly" placeholder="Date" :value="match.date " v-on:update:val="match.date = $event" />
        <span class="read" v-if="readonly">
          {{match.date | moment}}
        </span>
      </div>
      <div class="col" :title="match.opponent">
        <input type="text" class="form-control m-field-input" :readonly="readonly" v-model="match.opponent" />
      </div>
      <div class="col" :title="match.venue">
        <input type="text" class="form-control m-field-input" :readonly="readonly" v-model="match.venue" />
      </div>
      <div class="col" v-if="type == 'team'" :title="match.result">
        <input type="text" class="form-control m-field-input" :readonly="readonly" v-model="match.result" />
      </div>
      <div class="col" v-if="type == 'player'" :title="match.training">
        <vselect v-if="!readonly" ref="vSelect" v-model="match.training" :options="['Yes','No']" :clearable="true" />
        <span class="read" v-if="readonly">{{match.training}}</span>
      </div>
      <div class="col" v-if="type == 'player'" :title="match.comment">
        <input type="text" class="form-control m-field-input" :readonly="readonly" v-model="match.comment" />
      </div>
    </div>
    <div class="row">
      <button v-if="!readonly" class="btn btn-secondary col-2" @click="addRowMatches">Add Match</button>
    </div>
  </div>
</template>

<script>
  import Datepicker from 'vuejs-datepicker';
  import vSelect from 'vue-select';
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
      datepicker: Datepicker,
      vselect: vSelect,
      icon: Icon,
      ftdatepicker: FtDatepicker

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
