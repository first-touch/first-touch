<template>
  <div>
    <sidebar/>
    <div class="container-fluid">
      <match-result/>
    </div>
  </div>
</template>

<script>
import NotificationSidebar from 'app/components/NotificationSidebar';
import MatchResult from './components/MatchResult';

export default {
  name: 'ClubDashboard',
  components: {
    sidebar: NotificationSidebar,
    'match-result': MatchResult,
  },
};
</script>
