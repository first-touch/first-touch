<template>
<div>
  <sidebar/>
  <div class="container-fluid">
    <match-result/>
    <div class="ft-page timeline">
<<<<<<< HEAD
      <h4 class="header">Timeline</h4>
=======
      <h4 class="spaced-title upper-cased main-color">Timeline</h4>
>>>>>>> [Chore] cleaning up some more styling

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

