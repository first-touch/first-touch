<template>
  <timeline-item>
    <div v-if="!msHidden" class="career-statistics-section">
      <h4 class="title">Match Statistics</h4>
      <div class="section">
        <b-table striped hover :items="items" :fields="fields"></b-table>
      </div>
      <div class="btn-holder">
        <a v-on:click="isHidden = !isHidden; csHidden = true" class="btn btn-bright">GO TO CAREER HISTORY</a>
        <a class="btn btn-bright">GO TO MATCH STATISTICS</a>
      </div>
    </div>
    <div v-if="!csHidden" class="career-statistics-section">
      <h4 class="title">Career Statistics</h4>
      <div class="section">
        <b-table striped hover :items="items" :fields="fields"></b-table>
      </div>
      <div class="btn-holder">
        <a v-on:click="isHidden = !isHidden; csHidden = true" class="btn btn-bright">GO TO CAREER HISTORY</a>
        <a class="btn btn-bright">GO TO MATCH STATISTICS</a>
      </div>
    </div>
    <div v-if="!isHidden" class="career-history-section">
      <h4 class="spaced-title upper-cased main-color">Career History</h4>
      <div class="section">
        <career-entry class="career-entry" v-for="careerEntry in careerHistory" :careerEntry="careerEntry"></career-entry>
      </div>
      <div class="btn-holder">
        <a v-on:click="csHidden = !csHidden; isHidden = true" class="btn btn-bright upper-cased">Career Statistics</a>
        <a class="btn btn-bright upper-cased">Match Statistics</a>
      </div>
    </div>
  </timeline-item>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .section {
    &:not(:last-child) {
      margin-bottom: 50px;
    }
    .section-title {
      color: $secondary-text-color;
      text-transform: uppercase;
      font-weight: 300;
    }
  }

  .career-entry {
    margin-bottom: 20px;
  }
</style>

<script>
import TimelineItem from 'app/components/TimelineItem';
import CareerEntry from './CareerEntry';

export default {
  name: 'CareerEvents',
  props: ['careerHistory'],
  data() {
    return {
      isHidden: false,
      csHidden: true,
      msHidden: true,
      items: [{
          isActive: true,
          YEAR: '2002–03',
          CLUB: 'Sporting CP B	',
          COUNTRY: 'Portugal',
          COMPETITION: 'Segunda Divisão	',
          APPS: 'XX',
          GLS: 'XX'
        },
        {
          isActive: true,
          YEAR: '2002–03',
          CLUB: 'Sporting CP B	',
          COUNTRY: 'Portugal',
          COMPETITION: 'Segunda Divisão	',
          APPS: 'XX',
          GLS: 'XX'
        },
        {
          isActive: true,
          YEAR: '2002–03',
          CLUB: 'Sporting CP B	',
          COUNTRY: 'Portugal',
          COMPETITION: 'Segunda Divisão	',
          APPS: 'XX',
          GLS: 'XX'
        },
        {
          isActive: true,
          YEAR: '2002–03',
          CLUB: 'Sporting CP B	',
          COUNTRY: 'Portugal',
          COMPETITION: 'Segunda Divisão	',
          APPS: 'XX',
          GLS: 'XX'
        },
        {
          isActive: true,
          YEAR: 'TOTAL',
          CLUB: '',
          COUNTRY: '',
          COMPETITION: ' ',
          APPS: 'XX',
          GLS: 'XX'
        },
        {
          isActive: true,
          YEAR: 'Career total',
          CLUB: '',
          COUNTRY: '',
          COMPETITION: ' ',
          APPS: 'XX',
          GLS: 'XX'
        },
      ],
      selected: null,
      options: [{
          value: null,
          text: 'Please select an option'
        },
        {
          value: 'a',
          text: 'This is First option'
        },
        {
          value: 'b',
          text: 'Selected Option'
        },
        {
          value: {
            'C': '3PO'
          },
          text: 'This is an option with object value'
        },
        {
          value: 'd',
          text: 'This one is disabled',
          disabled: true
        }
      ],
    };
  },
  components: {
    'timeline-item': TimelineItem,
    'career-entry': CareerEntry
  }
};
</script>
