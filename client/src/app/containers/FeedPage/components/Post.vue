<template>
  <timeline-item>
    <div class="header">
      <img class="avatar" src="https://unsplash.it/200/200" />
      <div class="info">
        <h5 class="name spaced-title main-color">{{ info.author_name }}</h5>
        <p class="role main-color">{{ info.author_status }}</p>
      </div>
    </div>
    <div class="body">
      <p class="content">
        {{ info.content }}
      </p>
    </div>
  </timeline-item>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.header {
  display: flex;
  margin-bottom: 20px;
  .avatar {
    border-radius: 50%;
    max-height: 70px;
    width: 70px;
  }
  .info {
    margin-left: 30px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    .name {
      margin-bottom: 0;
      text-transform: uppercase;
      color: $secondary-header-color;
    }
    .role {
      text-transform: capitalize;
    }
  }
}

.body {
  *:not(:last-child) {
    margin-bottom: 20px;
  }
  .content {
    color: $main-text-color;
    letter-spacing: 1.3px;
    margin-bottom: 0;
  }
}
</style>

<script>
import TimelineItem from 'app/components/TimelineItem';

export default {
  name: 'Post',
  props: ['info'],
  components: {
    'timeline-item': TimelineItem,
  },
};
</script>
