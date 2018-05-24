<template>
  <action-item>
    <button class="timeline-widget-button">
      <span>
        <icon name='eye' scale="1.5"></icon>
      </span>
      <router-link :to="{ name: 'clubRequestList'}">Return To jobs list</router-link>
    </button>
    <button class="timeline-widget-button">
      <span>
        <icon name='edit' scale="1.5"></icon>
      </span>
      <router-link :to="{ name: 'clubRequest', params: { id: id }}" class="active">Edit</router-link>
    </button>
    <button class="timeline-widget-button button-right" v-if="status == 'publish'" @click="updateStatus('private')">
      <span class="unpublish">
        <icon name="eye-slash" scale="1.5"></icon>
      </span>
      <a>Unpublish Request</a>
    </button>
    <button class="timeline-widget-button button-right" v-if="status == 'private'" @click="updateStatus('publish')">
      <span class="publish">
        <icon name="eye" scale="1.5"></icon>
      </span>
      <a>Publish Request</a>
    </button>
  </action-item>
</template>

<style lang="scss" scoped>
.timeline-widget-button {
  cursor: pointer;
  overflow: hidden;
  &:hover {
    img {
      // position: absolute;
      filter: invert(40%);
    }
  }
  img {
    width: 3.5em;
  }
}
</style>

<script>
import ActionsItem from 'app/components/ActionsItem';
import Icon from 'vue-awesome/components/Icon';
import 'vue-awesome/icons/edit';

export default {
  name: 'Actions',
  props:['id','status','updateStatus'],
  components: {
    'action-item': ActionsItem,
    icon: Icon
  },
};
</script>
