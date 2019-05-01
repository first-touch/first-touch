<template>
  <div>
    <div class="ft-page">
      <div class="container">
        <actions class="mt-2 mb-2"/>
        <!-- TODO: Move this to a separate page: My Assignments -->
        <!-- <bids-list class="widget" /> -->
        <report-list class="mt-2 mb-2" />
      </div>
    </div>
  </div>
</template>

<script>
import ReportList from './components/ReportsList';
import BidsList from './components/BidsList';
import Actions from './components/Actions';

export default {
  name: 'JobList',
  components: {
    Actions,
    ReportList,
    BidsList
  },
  data() {
    return {
      reportSelected: null
    };
  },
  methods: {}
};
</script>
