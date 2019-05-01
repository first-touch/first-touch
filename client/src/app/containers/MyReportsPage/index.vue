<template>
  <div class="ft-page container">
    <h4 class="spaced-title upper-cased main-color page-title mb-5">My reports</h4>
    <div class="a-side-indicator primary">
      <div class="arrow"></div>
      <ft-button :linkTo="{ name: 'scoutReportCreate' }" icon="regular/edit">Create Report</ft-button>
      <ft-button :linkTo="{ name: 'ScoutJobBidPage' }" icon="regular/handshake">My Bids</ft-button>
    </div>
    <report-list class="mt-2 mb-2" />
  </div>
</template>

<script>
// TODO: Move Reports List to global components
import ReportList from 'app/containers/JobsListPage/components/ReportsList';
import FtButton from 'app/components/Button/Button';

export default {
  name: 'MyReportsPage',
  components: {
    ReportList,
    FtButton
  }
};
</script>
