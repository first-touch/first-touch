<template>
  <action-item>
    <button v-if="hasStripe" class="timeline-widget-button" @click="AddPayment">
      <span>
        <icon name='edit' scale="1.5"></icon>
      </span>
      <a>Add New Payment Method</a>
    </button>
    <button class="timeline-widget-button" :class="{ 'button-right': hasStripe }" @click="PersonalInformation">
      <span>
        <icon name='edit' scale="1.5"></icon>
      </span>
      <a v-if="hasStripe">Edit account</a>
      <a v-if="!hasStripe">Create account</a>
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
    props: ['AddPayment', 'PersonalInformation', 'hasStripe'],
    components: {
      'action-item': ActionsItem,
      icon: Icon
    }
  };
</script>
