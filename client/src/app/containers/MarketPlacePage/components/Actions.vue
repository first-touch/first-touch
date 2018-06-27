<template>
  <action-item>
    <button class="timeline-widget-button" @click="toAssignement">
      <span>
        <icon name='search' scale="1.5"></icon>
      </span>
      <a>Create Assignement </a>
    </button>
  </action-item>
</template>
<script>
  import ActionsItem from 'app/components/ActionsItem';
  import Icon from 'vue-awesome/components/Icon';
  import 'vue-awesome/icons/search';

  export default {
    name: 'Actions',
    props: ['toAssignement'],
    components: {
      'action-item': ActionsItem,
      icon: Icon
    }
  };
</script>
