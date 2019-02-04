<template>
   <timeline-item>
      <h4 class="title">Career Statistics</h4>
      <div class="section">
         <b-table striped hover :items="items" :fields="fields"></b-table>
      </div>
      <div class="btn-holder">
         <a class="btn btn-bright">Career Statistics</a>
         <a class="btn btn-bright">Match Statistics</a>
      </div>
   </timeline-item>
</template>
<style lang="scss" scoped>
   @import '~stylesheets/variables';
   .title {
   color: $secondary-text-color;
   text-transform: uppercase;
   margin-bottom: 50px;
   }
   .crreer_statistices {
   display: block;
   width: 100%;
   }
   .slect_career_statistics {
   display: inline-block;
   width: 40%;
   }
   .career_statistics_btn .btn-secondary {
   background: none;
   border: 1px solid #a8a8a8;
   text-align: left;
   padding: 5px 44px 5px 4px;
   border-radius: 8px;
   box-shadow: none;
   color: #565656;
   }
</style>
<script>
   import TimelineItem from 'app/components/TimelineItem';

   export default {
     name: 'CareerStatistics',
     data() {
       return {

         fields: [ 'YEAR', 'CLUB', 'COUNTRY','COMPETITION','APPS','GLS' ],
         items: [
           { isActive: true, YEAR: '2002–03', CLUB: 'Sporting CP B	', COUNTRY: 'Portugal',COMPETITION:'Segunda Divisão	',APPS:'XX',GLS:'XX'},
           { isActive: true, YEAR: '2002–03', CLUB: 'Sporting CP B	', COUNTRY: 'Portugal',COMPETITION:'Segunda Divisão	',APPS:'XX',GLS:'XX'},
           { isActive: true, YEAR: '2002–03', CLUB: 'Sporting CP B	', COUNTRY: 'Portugal',COMPETITION:'Segunda Divisão	',APPS:'XX',GLS:'XX'},
           { isActive: true, YEAR: '2002–03', CLUB: 'Sporting CP B	', COUNTRY: 'Portugal',COMPETITION:'Segunda Divisão	',APPS:'XX',GLS:'XX'},
           { isActive: true, YEAR: 'TOTAL',   CLUB: '', COUNTRY: '',COMPETITION:' ',APPS:'XX',GLS:'XX'},
           { isActive: true, YEAR: 'Career total', CLUB: '', COUNTRY: '',COMPETITION:' ',APPS:'XX',GLS:'XX'},
         ],
           selected: null,
         options: [
           { value: null, text: 'Please select an option' },
           { value: 'a', text: 'This is First option' },
           { value: 'b', text: 'Selected Option' },
           { value: {'C': '3PO'}, text: 'This is an option with object value' },
           { value: 'd', text: 'This one is disabled', disabled: true }
         ]
       };
     },
     components: {
       'timeline-item': TimelineItem,
     },
     props: ['careerHistory'],
   };
</script>
