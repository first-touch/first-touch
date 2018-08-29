<template>
  <div>
    <div class="timeline-widget">
      <div class="arrow"></div>
      <button class="timeline-widget-button btn-post" @click="toggle">
        publish a new post
      </button>
      <button class="timeline-widget-button btn-upload">
        upload a picture
      </button>
    </div>
    <div class="timeline-widget writer active">
      <div class="container-fluid">
        <form @submit.prevent="handleSubmit">
          <fieldset class="form-group">
            <div :value="content" @keyup="handleContentChange" class="form-control" rows="4">
              <textarea placeholder="Share a thought, link or opinion"></textarea>
              <div class="row justify-content-end">
                <button v-if="posting" type="button" class="bar-button" disabled>Posting...</button>
                <button v-else type="submit" class="bar-button">Post</button>
              </div>
            </div>
          </fieldset>

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
        height: auto;
      }
      .container-fluid {
        padding: 10px 20px 0;
        &.active {
          height: auto;
        }
        form {
          display: flex;
          flex-direction: column;
          margin-bottom: -15px;
          textarea {
            width: 100%;
            color:  #7F8081;
            padding: 10px;
            border: none;
          }
          .bar-button {
            background-color: #B3CB75;
            border: none;
            box-shadow: none;
            margin-right: 10px;
            width: 200px;
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
