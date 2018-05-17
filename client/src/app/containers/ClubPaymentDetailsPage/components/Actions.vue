<template>
  <action-item>
    <button class="timeline-widget-button" @click="addPayment">
      <span>
        <icon name='edit' scale="1.5"></icon>
      </span>
      <a >Add New Payment Method</a>
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
    props: ['addPayment'],
    components: {
      'action-item': ActionsItem,
      icon: Icon
    }
  };
</script>
