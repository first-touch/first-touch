<template>
  <timeline-item>
    <div class="header">
      <img class="avatar" src="https://unsplash.it/200/200" />
      <div class="info spaced-title">
        <h5 class="name">{{ info.author_name }}</h5>
        <p class="role">{{ info.author_status }}</p>
      </div>
    </div>
    <div class="body">
      <!-- <img class="img-fluid" src="https://unsplash.it/1000/600" /> -->
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
    max-height: 100px;
    width: 100px;
  }
  .info {
    margin-left: 30px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    .name {
      color: $secondary-header-color;
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
import TimelineItem from 'app/components/TimelineItem.vue';

export default {
  name: 'Post',
  props: ['info'],
  components: {
    'timeline-item': TimelineItem,
  },
};
</script>
