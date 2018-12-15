<template>
  <div>
    <div class="a-side-indicator primary">
      <div class="arrow"></div>
      <div class="timeline-widget-button">
        <b-btn v-b-toggle.post-text>
          <div class="row">
            <div class="col no-padding">
              <img src="https://cdn3.iconfinder.com/data/icons/complete-set-icons/512/photo512x512.png">
            </div>
            <div class="col">
              Publish a
              <br>
              new post
            </div>
          </div>
        </b-btn>
      </div>
      <div class="timeline-widget-button">
        <b-btn v-b-toggle.post-media>
          <div class="row">
            <div class="col no-padding">
              <img src="https://cdn3.iconfinder.com/data/icons/complete-set-icons/512/photo512x512.png">
            </div>
            <div class="col">
              Upload
              <br>
              a photo
            </div>
          </div>
        </b-btn>
      </div>
    </div>
    <b-collapse id="post-text" accordion="post-upload">
      <b-card>
        <div class="container">
          <form @submit.prevent="handleSubmit">
            <fieldset class="form-group">
              <textarea :value="content" @keyup="handleContentChange" class="form-control m-field-input" rows="4" placeholder="Share a thought, link or opinion"></textarea>
            </fieldset>
            <div class="row justify-content-end">
              <button v-if="posting" type="button" class="form-control a-bar-button" disabled>Posting...</button>
              <button v-else type="submit" class="form-control a-bar-button">Post</button>
            </div>
          </form>
        </div>
      </b-card>
    </b-collapse>
    <b-collapse id="post-media" accordion="post-upload">
      <b-card>
        <div class="container">
          <form @submit.prevent="handleSubmit">
            <fieldset class="form-group">
              <textarea :value="content" @keyup="handleContentChange" class="form-control m-field-input" rows="4" placeholder="uploadMedia"></textarea>
            </fieldset>
            <div class="row justify-content-end">
              <button v-if="posting" type="button" class="form-control a-bar-button" disabled>Posting...</button>
              <button v-else type="submit" class="form-control a-bar-button">Post</button>
            </div>
          </form>
        </div>
      </b-card>
    </b-collapse>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  #post-text,
  #post-media {
    border-left: 7px solid $secondary-header-color;
    padding-left: 25px;
    textarea {
      border: none;
      color: $main-text-color;
    }
  }

  .timeline-widget-button {
    .btn-secondary {
      border: none; // max-width: 12vw;
      margin-right: 20px;
      margin-bottom: 20px;
      color: $secondary-text-color;
      text-transform: uppercase;
      background-color: $navbar-background-color;
      text-align: left;
    }
    .btn-text-title {
      margin-top: 10px;
    }
    img {
      height: 50px;
    }
  }

</style>

<script>
  export default {
    name: 'PostWidget',
    props: ['posting', 'handleContentChange', 'handleSubmit', 'content'],
    data() {
      return {
        active: false,
      };
    },
    methods: {
      toggle() {
        this.$set(this, 'active', !this.active);
      },
    },
  };
</script>
