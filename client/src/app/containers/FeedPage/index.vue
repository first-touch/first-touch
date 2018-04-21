<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page timeline">
        <h4 class="header">Timeline</h4>
        <widget
          :content="content"
          :posting="posting"
          :handleContentChange="handleContentChange"
          :handleSubmit="handleSubmit" />
        <post v-for="post in posts" :info="post" :key="post.id" />
        <div v-if="loading">
          <h4 class="text-center">Loading...</h4>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.timeline {
  .text-center {
    color: $secondary-text-color;
    font-weight: 300;
  }
}
</style>

<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_LOADING, ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import Post from './components/Post.vue';
import NotificationSidebar from 'app/components/NotificationSidebar';
import PostWidget from './components/PostWidget.vue';

export default {
  name: 'Feed',
  components: {
    post: Post,
    sidebar: NotificationSidebar,
    widget: PostWidget,
  },
  data() {
    return {
      content: '',
      posting: false,
    };
  },
  computed: {
    ...mapGetters(['token', 'feed']),
    loading() {
      return this.feed.status === ASYNC_LOADING;
    },
    posts() {
      return this.feed.value;
    },
  },
  methods: {
    ...mapActions(['getInitialFeed', 'clearToken', 'succeedToPost']),
    handleContentChange(event) {
      this.$set(this, 'content', event.target.value);
    },
    handleSubmit() {
      this.$set(this, 'posting', true);
      fetch('/api/v1/users/posts', {
        method: 'POST',
        headers: {
          Authorization: this.token.value,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ content: this.content }),
      }).then(res => {
        if (res.status === 200 || res.status === 201) {
          this.$set(this, 'content', '');
          res.json().then(post => this.succeedToPost({ post }));
        } else if (res.status === 401) {
          this.clearToken();
        } else {
          res.json().then(console.log);
        }
        this.$set(this, 'posting', false);
      });
    },
  },
  mounted() {
    this.getInitialFeed({ token: this.token.value });
  },
};
</script>