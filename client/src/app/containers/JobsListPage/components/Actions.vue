<template>
  <action-item>
    <button class="timeline-widget-button">
      <span>
        <icon name='edit' scale="1.5"></icon>
      </span>
      <router-link :to="{ name: 'scoutReportCreate'}">Create Report</router-link>
    </button>
    <button class="timeline-widget-button">
      <span>
        <icon name='handshake' scale="1.5"></icon>
      </span>
      <router-link :to="{ name: 'ScoutJobBidPage'}">My Bids</router-link>
    </button>
  </action-item>
</template>

<style lang="scss" scoped>
</style>

<script>
  import ActionsItem from 'app/components/ActionsItem';
  import Icon from 'vue-awesome/components/Icon';
  import 'vue-awesome/icons/edit';
  import 'vue-awesome/icons/handshake';

  export default {
    name: 'Actions',
    components: {
      'action-item': ActionsItem,
      icon: Icon
    }
  };
</script>
