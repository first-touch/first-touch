<template>
  <action-item>
    <button class="timeline-widget-button" @click="AddPayment">
      <span>
        <icon name='edit' scale="1.5"></icon>
      </span>
      <a>Add Bank Account</a>
    </button>
    <button class="timeline-widget-button button-right" @click="PersonalInformation">
      <span>
        <icon name='edit' scale="1.5"></icon>
      </span>
      <a> Personnal informations </a>
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
  props: ['AddPayment','PersonalInformation'],
  components: {
    'action-item': ActionsItem,
    icon: Icon
  }
};
</script>
