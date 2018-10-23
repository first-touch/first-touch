<template>
<div>
  <sidebar/>
  <div class="container-fluid">
    <match-result/>
    <div class="ft-page timeline">
      <h4 class="spaced-title">Timeline</h4>

    </div>
  </div>
</div>
</template>
<style lang="sass" scoped>
</style>
<script>
import NotificationSidebar from 'app/components/NotificationSidebar';
import MatchResult from './components/MatchResult';

export default {
  name: 'StreamPage',
  components: {
    sidebar: NotificationSidebar,
    'match-result': MatchResult,
  },
};
</script>
