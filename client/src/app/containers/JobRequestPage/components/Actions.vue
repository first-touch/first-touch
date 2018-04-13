<template>
  <action-item>
    <button class="timeline-widget-button" @click="update('player')">
      <img src="/images/landing-page/ft-icons-player.png" alt="club" />
      New Player Request
    </button>
    <button class="timeline-widget-button" @click="update('team')">
      <img src="/images/landing-page/ft-icons-club.png" alt="team" />
      New Team Request
    </button>
    <button class="timeline-widget-button" @click="update('position')">
      <img src="/images/landing-page/ft-icons-player.png" alt="club" />
      New Position Request
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
  components: {
    'action-item': ActionsItem,
    icon: Icon
  },
  methods: {
    update(val) {
      this.$emit('update:val', val);
    }
  }
};
</script>
