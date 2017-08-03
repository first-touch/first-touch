<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page timeline">
        <h4 class="header">Timeline</h4>
        <widget
          :posting="posting"
          :handleContentChange="handleContentChange"
          :handleSubmit="handleSubmit" />
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
    .text-center {
      color: $secondary-text-color;
      font-weight: 300;
    }
  }
</style>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import store from '../store';
  import { ASYNC_LOADING, ASYNC_SUCCESS } from '../shared/constants/AsyncStatus';
  import Post from '../components/Post.vue';
  import NotificationSidebar from '../components/NotificationSidebar.vue';
  import PostWidget from '../components/PostWidget.vue';

  export default {
    name: 'Feed',
    components: {
      'post': Post,
      'sidebar': NotificationSidebar,
      'widget': PostWidget
    },
    data() {
      return {
        content: '',
        posting: false
      }
    },
    computed: {
      ...mapGetters(['token', 'feed']),
      loading() { return this.feed.status === ASYNC_LOADING; },
      posts() { return this.feed.value; }
    },
    methods: {
      ...mapActions(['getInitialFeed', 'clearToken']),
      handleContentChange(event) {
        this.$set(this, 'content', event.target.value);
      },
      handleSubmit() {
        this.$set(this, 'posting', true);
        fetch('/api/v1/posts', {
          method: 'POST',
          headers: {
            'Authorization': this.token.value,
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ content: this.content })
        }).then((res) => {
          if (res.status === 200) {
            this.$set(this, 'content', '');
            res.json().then(console.log);
          } else if (res.status === 401) {
            this.clearToken();
          } else {
            res.json().then(console.log);
          }
          this.$set(this, 'posting', false);
        })
      }
    },
    mounted() {
      this.getInitialFeed({ token: this.token.value });
    }
  }
</script>