<template>
  <div class="ft-page container">
    <h4 class="spaced-title upper-cased main-color page-title mb-5">My Assignments</h4>
    <div class="a-side-indicator primary">
      <div class="arrow"></div>
      <ft-button :linkTo="{ name: 'scoutJobsBank'}" icon="file-contract">Find Work</ft-button>
      <ft-button :linkTo="{ name: 'scoutJobsBank'}" icon="file-contract">My Pending Bids</ft-button>
    </div>
    <bids-list class="mt-2 mb-2" />
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
  }
};
</script>
