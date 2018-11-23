<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page timeline">
        <h4 class="spaced-title upper-cased main-color">Your Profile
        </h4>
        <pageVisits/>  
        <h4 class="career_sec">CAREER STATISTICS
        </h4>
        <widget
                :content="content"
                :posting="posting"
                :handleContentChange="handleContentChange"
                :handleSubmit="handleSubmit" />
        <post v-for="post in posts" :info="post" :key="post.id" />
        <div v-if="loading">
          <h4 class="text-center">Loading...
          </h4>
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
  .career_sec {
    margin: 42px 0 0 0;
    font-size: 18px;
    letter-spacing: 3px;
    color: #929292;
    font-weight: normal;
    &:before {
      content: '';
      position: absolute;
      margin-top: -15px;
      width: 5%;
      border-top: 5px solid #a8cb5c;
    }
  }
</style>
<script>
  import {
    mapGetters, mapActions }
  from 'vuex';
  import {
    ASYNC_LOADING, ASYNC_SUCCESS }
  from 'app/constants/AsyncStatus';
  import Post from './components/Post';
  import NotificationSidebar from 'app/components/NotificationSidebar';
  import PostWidget from './components/PostWidget';
  import PageVisits from './components/PageVisits';
  export default {
    name: 'Feed',
    components: {
      post: Post,
      sidebar: NotificationSidebar,
      widget: PostWidget,
      pageVisits: PageVisits,
    },
    data() {
      return {
        content: '',
        posting: false,
      };
    }
    ,
    computed: {
      ...mapGetters(['token', 'feed']),
      loading() {
      return this.feed.status === ASYNC_LOADING;
    }
    ,
    posts() {
      return this.feed.value;
    }
    ,
  }
    ,
    methods: {
      ...mapActions(['postIndex', 'postCreate']),
        handleContentChange(event) {
        this.$set(this, 'content', event.target.value);
      }
      ,
        handleSubmit() {
          this.$set(this, 'posting', true);
          let postPromise = this.postCreate({
            postData: {
              content: this.content }
          }
                                           );
          postPromise.then(post => {
            this.$set(this, 'posting', false);
            this.$set(this, 'content', '');
          }
                          );
        }
      ,
    }
  ,
    mounted() {
      this.postIndex();
    }
  ,
  };
</script>
