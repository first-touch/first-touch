<template>
  <div class="ft-page container">
    <h4 class="spaced-title upper-cased main-color page-title mb-5">My Assignments</h4>
    <bids-list class="mt-2 mb-2" />
  </div>
</template>

<script>
import BidsList from './components/BidsList';

export default {
  name: 'JobList',
  components: {
    BidsList
  }
};
</script>
