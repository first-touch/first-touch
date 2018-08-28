<template>
  <div>
    <div class="timeline-widget">
      <div class="arrow"></div>
      <!-- <button class="timeline-widget-button" @click="toggle">
        <button class="btn-png"></button>
        <span class="btn-text">
          publish a new post
        </span>
      </button> -->
      <button class="timeline-widget-button" @click="toggleWrite">
        <button class="btn-png"></button>
        <span class="btn-text">
          publish a new post
        </span>
      </button>
      <button class="timeline-widget-button" @click="toggleUpload">
        <button class="btn-png"></button>
        <span class="btn-text">
          upload a picture
        </span>
      </button>
    </div>
    <!-- <div class="timeline-widget writer" :class="{ active }">
      <div class="container">
        <form @submit.prevent="handleSubmit">
          <fieldset class="form-group">
            <textarea :value="content" @keyup="handleContentChange" class="form-control" rows="4" placeholder="What's on your mind?"></textarea>
          </fieldset>
          <button v-if="posting" type="button" class="bar-button" disabled>Posting...</button>
          <button v-else type="submit" class="bar-button">Post</button>
        </form>
      </div>
    </div> -->
    <div class="timeline-widget writer" :class="{ active }" v-if="writePost">
      <div class="container">
        <form @submit.prevent="handleSubmit">
          <fieldset class="form-group">
            <textarea :value="content" @keyup="handleContentChange" class="form-control" rows="4" placeholder="What's on your mind?"></textarea>
          </fieldset>
          <button v-if="posting" type="button" class="bar-button" disabled>Posting...</button>
          <button v-else type="submit" class="bar-button">Post</button>
        </form>
      </div>
    </div>
    <div class="timeline-widget writer" :class="{ active }" v-if="postMedia">
      <div class="container">
        <form @submit.prevent="handleSubmit">
          <fieldset class="form-group">
            <textarea :value="content" @keyup="handleContentChange" class="form-control" rows="4" placeholder="What's on your mind?"></textarea>
          </fieldset>
          <button v-if="posting" type="button" class="bar-button" disabled>Posting...</button>
          <button v-else type="submit" class="bar-button">Post</button>
        </form>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables.scss';

.timeline-widget {
  display: flex;
  border-left: 7px solid $secondary-header-color;
  .timeline-widget-button {
    color: $secondary-text-color;
    text-transform: uppercase;
    background-color: $navbar-background-color;
    border: none;
    max-width: 12vw;
    margin-right: 20px;
    &.btn-post {
      padding-left: 50px;
      background-image: url('https://cdn3.iconfinder.com/data/icons/complete-set-icons/512/photo512x512.png');
      background-repeat: no-repeat;
      background-position: left;
      background-size: contain;
    }
    &.btn-upload {
      padding-left: 50px;
      background-image: url('https://cdn3.iconfinder.com/data/icons/complete-set-icons/512/photo512x512.png');
      background-repeat: no-repeat;
      background-position: left;
      background-size: contain;
    }
  }
  .arrow {
    margin-top: 18px;
    border-left-color: $secondary-header-color;
  }
  &.writer {
    height: 0;
    overflow: hidden;
    transition: height 1s;
    &.active {
      height: 180px;
    }
    .container {
      padding: 10px 20px 0;
      &.active {
        height: auto;
      }
      form {
        display: flex;
        flex-direction: column;
        .bar-button {
          align-self: flex-end;
        }
      }
    }
  }
}
</style>

<script>
export default {
  name: 'PostWidget',
  props: ['posting', 'handleContentChange', 'handleSubmit', 'content'],
  data() {
    return {
      active: true,
      writePost: false,
      postMedia: false,
    };
  },
  /*
  methods: {
    toggle() {
      this.$set(this, 'active', !this.active);
    },
  },
  */
  methods: {
    toggleWrite() {
      this.$set(this, 'writePost', !this.writePost);
    },
    toggleUpload() {
      this.$set(this, 'postMedia', !this.postMedia);
    },
  },
};
</script>
