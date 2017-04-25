<template>
  <div class="timeline-post">
    <div class="arrow"></div>
    <div class="timeline-post-container">
      <div class="timeline-post-header">
        <img class="avatar" src="https://unsplash.it/200/200" />
        <div class="info">
          <h5 class="name">{{ info.author_name }}</h5>
          <p class="role">{{ info.author_status }}</p>
        </div>
      </div>
      <div class="timeline-post-body">
        <!-- <img class="img-fluid" src="https://unsplash.it/1000/600" /> -->
        <p class="timeline-post-content">
          {{ content }}
        </p>
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
  @import "~stylesheets/variables";

  .timeline-post {
    display: flex;
    border-left: 7px solid $main-header-color;
    margin-top: 20px;
    .arrow {
      margin-top: 20px;
      border-left-color: $main-header-color;
    }
    .timeline-post-container {
      background-color: #fff;
      border-radius: 5px;
      padding: 20px;
      width: 100%;
      .timeline-post-header {
        display: flex;
        margin-bottom: 20px;
        .avatar {
          border-radius: 50%;
          height: 100px;
        }
        .info {
          display: flex;
          flex-direction: column;
          justify-content: center;
          padding-left: 20px;
          .name {
            text-transform: uppercase;
            color: $secondary-header-color;
          }
          .role { color: $secondary-text-color; }
        }
      }
      .timeline-post-body {
        *:not(:last-child) { margin-bottom: 20px; }
        .timeline-post-content {
          color: $secondary-text-color;
          margin-bottom: 0;
        }
      }
    }
  }
</style>

<script>
  export default {
    name: 'Post',
    props: ['info'],
    computed: {
      content() { return this.info.content }
    }
  }
</script>
