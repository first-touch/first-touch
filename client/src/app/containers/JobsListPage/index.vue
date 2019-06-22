<template>
  <div class="ft-page container">
    <h4 class="spaced-title upper-cased main-color page-title mb-5">My Assignments</h4>
    <div class="a-side-indicator primary">
      <div class="arrow"></div>
      <ft-button :linkTo="{ name: 'scoutJobsBank'}" icon="search">Find Work</ft-button>
      <ft-button :linkTo="{ name: 'scoutJobBidPage'}" icon="hand-holding-usd">My Pending Bids</ft-button>
    </div>
    <bids-list bid_status="accepted" class="mt-2 mb-2">
      <template v-slot:actions="slotProps">
        <button class="btn btn-primary" @click="createReport(slotProps.bid)">Write report</button>
        <button class="btn btn-primary" @click="viewReport(slotProps.bid)">View final report</button>
      </template>
    </bids-list>
  </div>
</template>

<script>
import BidsList from './components/BidsList';
import FtButton from 'app/components/Button/Button';

export default {
  name: 'JobList',
  components: {
    BidsList,
    FtButton
  },
  methods: {
    createReport (bid) {
      console.log('start writing report for this request');
    },
    viewReport (bid) {
      console.log('navigate to associated report')
    },
  }
};
</script>
