<template>
  <action-item>
    <div class="timeline-widget-button">
      <img src="/images/landing-page/ft-icons-player.png" alt="club" @click="update('player')" />
      <p @click="update('player')">
        New Player ASSIGNMENT
      </p>
    </div>
    <div class="timeline-widget-button">
      <img src="/images/landing-page/ft-icons-club.png" alt="team" @click="update('team')" />
      <p @click="update('team')">New Team ASSIGNMENT</p>
    </div>
    <div class="timeline-widget-button">
      <img src="/images/landing-page/ft-icons-player.png" alt="club" @click="update('position')" />
      <p @click="update('position')">
        New Position ASSIGNMENT
      </p>
    </div>
  </action-item>
</template>

<style lang="scss" scoped>
  .timeline-widget-button {
    display: inline-block;
    overflow: hidden;
    img:hover {
      filter: invert(40%);
    }
    p:hover + img {
        filter: invert(40%);
    }
    p {
      display: inline;
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
