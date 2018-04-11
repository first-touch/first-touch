<template>
  <action-item>
    <button class="timeline-widget-button">
      <span>
        <icon name='edit' scale="1.5"></icon>
      </span>
      <router-link :to="`/report/create`">Create Report</router-link>
    </button>
  </action-item>
</template>

<style lang="scss" scoped>
</style>

<script>
  import ActionsItem from 'app/components/ActionsItem';
  import Icon from 'vue-awesome/components/Icon';
  import 'vue-awesome/icons/edit';

  export default {
    name: 'Actions',
    components: {
      'action-item': ActionsItem,
      icon: Icon
    }
  };
</script>
