<template>
  <div class="network-item">
    <img class="network-item-img" src="https://unsplash.it/300/300" />
    <div class="network-item-info">
      <h4 class="name">{{ info.display_name }}</h4>
      <p class="role">Football Player</p>
      <p class="club">Barca, Spain</p>
    </div>
    <button @click="toggleUnfollow" class="network-item-option-trigger"></button>
    <div v-if="unfollowOpen" class="network-item-options">
      <button @click="this.unfollow">Unfollow</button>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '../../../../stylesheets/variables';



.network-item {
  margin-top: 20px;
  background-color: #fff;
  border-radius: 4px;
  display: flex;
  align-items: center;
  position: relative;
  padding: 20px;
  flex: 0 0 48%;
  height: 150px;
  .network-item-img {
    max-height: 100%;
    border-radius: 50%;
  }
  .network-item-info {
    margin-left: 20px;
    .name,
    .club,
    .role {
      font-weight: 300;
      margin-bottom: 2px;
    }
    .name {
      color: $main-header-color;
      text-transform: uppercase;
    }
    .club,
    .role {
      color: $main-text-color;
    }
  }
  .network-item-option-trigger {
    height: 20px;
    width: 20px;
    position: absolute;
    bottom: 10px;
    right: 10px;
    background: url('https://d30y9cdsu7xlg0.cloudfront.net/png/61783-200.png')
      no-repeat center center;
    background-size: cover;
    border: none;
  }
  .network-item-options {
    display: flex;
    position: absolute;
    flex-direction: column;
    top: 140px;
    left: calc(100% - 30px);
    z-index: 4;
    &:hover {
      display: flex;
    }
    button {
      background: #fff;
      border: 1px solid #000;
      border-top: none;
      height: 30px;
    }
    button:first-child {
      border-top: 1px solid #000;
    }
  }
}
</style>

<script>
export default {
  name: 'NetworkItem',
  props: ['info', 'unfollow'],
  data() {
    return {
      unfollowOpen: false,
    };
  },
  methods: {
    toggleUnfollow() {
      this.$set(this, 'unfollowOpen', !this.unfollowOpen);
    },
  },
};
</script>
