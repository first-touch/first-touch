<template>
  <div class="ft-page container">
    <h4 class="spaced-title upper-cased main-color page-title mb-5">My Pending Bids</h4>
    <div class="a-side-indicator primary">
      <div class="arrow"></div>
      <ft-button :linkTo="{ name: 'scoutJobsBank'}" icon="search">Find Work</ft-button>
      <ft-button :linkTo="{ name: 'scoutJobsList'}" icon="handshake">My Assignments</ft-button>
    </div>
    <bids-list bid_status="pending" class="mt-2 mb-2">
      <button class="btn btn-primary" @click="viewReport">Update Bid</button>
      <button class="btn btn-primary" @click="createReport">Cancel Bid</button>
    </bids-list>
  </div>
</template>

<script>
import BidsList from '../JobsListPage/components/BidsList';
import FtButton from 'app/components/Button/Button';

export default {
  name: 'JobList',
  components: {
    BidsList,
    FtButton
  },
  methods: {
    createReport () {
      console.log('start writing report for this request');
    },
    viewReport () {
      console.log('navigate to associated report')
    },
  }
};
</script>
