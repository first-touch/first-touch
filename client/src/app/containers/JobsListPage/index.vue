<template>
  <div class="ft-page container">
    <h4 class="spaced-title upper-cased main-color page-title mb-5">My reports</h4>
    <div class="a-side-indicator primary">
      <div class="arrow"></div>
      <ft-button :linkTo="{ name: 'scoutReportCreate' }" icon="regular/edit">Create Report</ft-button>
      <ft-button :linkTo="{ name: 'ScoutJobBidPage' }" icon="regular/handshake">My Bids</ft-button>
    </div>
    <!-- TODO: Move this to a separate page: My Assignments -->
    <!-- <bids-list class="widget" /> -->
    <report-list class="mt-2 mb-2" />
  </div>
</template>

<script>
import ReportList from './components/ReportsList';
import BidsList from './components/BidsList';
import FtButton from 'app/components/Button/Button';

export default {
  name: 'JobList',
  components: {
    ReportList,
    BidsList,
    FtButton
  },
  data() {
    return {
      reportSelected: null
    };
  }
};
</script>
