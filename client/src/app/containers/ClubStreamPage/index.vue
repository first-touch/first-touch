<template>
<div>
  <sidebar/>
  <div class="container-fluid">
    <div class="ft-page timeline">
      <h4 class="spaced-title upper-cased main-color">Timeline</h4>
    </div>
  </div>
</div>
</template>
<script>
import NotificationSidebar from 'app/components/NotificationSidebar';

export default {
  name: 'ClubStream',
  components: {
    sidebar: NotificationSidebar
  },
};
</script>
