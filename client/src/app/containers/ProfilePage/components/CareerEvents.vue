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
        <div class="main-career-events" v-for="careerEntry in careerHistory">
          <div class="career-events-left-logo">
            <img class="logo" :src="careerEntry.club.club_logo" />
          </div>
          <div class="career-events-center">
            <h5 class="career-events-one">{{ careerEntry.club.name }}</h5>
            <h5 class="career-events-two">{{ careerEntry.club.country_code }}</h5>
          </div>
          <div class="career-events_right">
            <h5 class="career-events-one">{{ careerEntry.start_date }} - {{ careerEntry.end_date }}</h5>
            <h5 class="career-events-two">Apps 200 | Scored 30</h5>
          </div>
        </div>
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

  .career-events-left-logo {
    display: inline-block;
    width: 15%;
    vertical-align: top;
    img {
      width: 60%;
    }
  }

  .career-events-center {
    display: inline-block;
    width: 34%;
    vertical-align: top;
  }

  .career-events_right {
    display: inline-block;
    width: 48%;
    vertical-align: top;
    text-align: right;
  }

  .main-career-events {
    display: block;
    width: 100%;
    padding: 14px 14px;
    border-bottom: 1px solid #565656;
  }

  .career-events-center h5,
  .career-events_right h5 {
    font-size: 16px;
    color: #8b8b8b;
    letter-spacing: 1px;
    margin: 8px 0 5px 0;
  }

  .career-events-main-center {
    padding: 50px 0 0 0;
  }

  .main-career-events-info {
    color: #a8a8a8;
    width: 100%;
    padding: 14px 0;
    border-bottom: 1px solid #d5d5d5;
  }

  button.btn.m-1.career-events-hover {
    background-color: #fff;
    border: none;
    color: #565656;
    outline: none;
    box-shadow: none;
  }
</style>

<script>
import TimelineItem from 'app/components/TimelineItem';

export default {
  name: 'CareerEvents',
  props: ['careerHistory'],
  data() {
    return {
      isHidden: false,
      csHidden: true,
      msHidden: true,
      fields: ['YEAR', 'CLUB', 'COUNTRY', 'COMPETITION', 'APPS', 'GLS'],
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
  },
  props: ['careerHistory'],
};
</script>
