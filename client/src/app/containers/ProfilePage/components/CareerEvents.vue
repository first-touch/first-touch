<template>
  <div class="career-entry-wrapper">
    <career-entry class="career-entry" v-for="careerEntry in careerHistory" :careerEntry="careerEntry"></career-entry>
  </div>
</template>

<script>
import CareerEntry from './CareerEntry';

export default {
  name: 'CareerEvents',
  props: ['careerHistory'],
  components: {
    'career-entry': CareerEntry
  }
};
</script>
