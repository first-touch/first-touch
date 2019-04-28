<template>
  <div>
    <div class="ft-page">
      <div class="container">
        <actions class="widget"/>
        <bids-list class="widget" />
        <report-list class="widget" />
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
