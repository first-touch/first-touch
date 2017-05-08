<template>
  <div class="timeline-post">
    <div class="arrow"></div>
    <div class="sub-container">
      <div class="header">
        <img class="avatar" src="https://unsplash.it/200/200" />
        <div class="info">
          <h5 class="name">{{ info.author_name }}</h5>
          <p class="role">{{ info.author_status }}</p>
        </div>
      </div>
      <div class="timeline-post-body">
        <!-- <img class="img-fluid" src="https://unsplash.it/1000/600" /> -->
        <p class="timeline-post-content">
          {{ info.content }}
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
    .container {
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
    props: ['info']
  }
</script>