<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page timeline">
        <h4 class="header">Timeline</h4>
        <div class="timeline-widget">
          <div class="arrow"></div>
          <button class="timeline-widget-button btn-post">
            <span>publish a new post</span>
          </button>
          <button class="timeline-widget-button btn-upload">
            upload a picture
          </button>
        </div>
        <post v-for="post in posts" :info="post" />
        <div v-if="loading">
          <h4 class="text-center">Loading...</h4>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
  @import "~stylesheets/variables";
  .timeline {
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
    }
    .text-center {
      color: $secondary-text-color;
      font-weight: 300;
    }
  }
</style>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import store from '../store';
  import { ASYNC_LOADING, ASYNC_SUCCESS } from '../constants/AsyncStatus';
  import Post from '../components/Post.vue';
  import NotificationSidebar from '../components/NotificationSidebar.vue';

  export default {
    name: 'Feed',
    components: {
      'post': Post,
      'sidebar': NotificationSidebar
    },
    computed: {
      ...mapGetters(['token', 'feed']),
      loading() { return this.feed.status === ASYNC_LOADING; },
      posts() { return this.feed.value; }
    },
    methods: {
      ...mapActions(['getInitialFeed'])
    },
    mounted() {
      this.getInitialFeed({ token: this.token.value });
    }
  }
</script>