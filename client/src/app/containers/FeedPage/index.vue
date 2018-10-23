<template>
   <div>
      <div class="ft-page timeline">
<<<<<<< HEAD
         <h4 class="header">Your Profile</h4>
         <b-carousel id="carousel1"
            style="text-shadow: 1px 1px 2px #333;"
            controls
            indicators
            background="#ababab"
            :interval="4000"
            img-width="1024"
            img-height="480" 
            >
            <!-- Text slides with image -->
            <b-carousel-slide
               img-src="../img/slider_img.png"
               >
            </b-carousel-slide>
            <!-- Slides with custom text -->
            <b-carousel-slide img-src="../img/slider_img.png">
            </b-carousel-slide>
         </b-carousel>
=======
        <h4 class="spaced-title">Timeline</h4>
        <widget
          :content="content"
          :posting="posting"
          :handleContentChange="handleContentChange"
          :handleSubmit="handleSubmit" />
        <post v-for="post in posts" :info="post" :key="post.id" />
        <div v-if="loading">
          <h4 class="text-center">Loading...</h4>
        </div>
>>>>>>> [Resolves #151936872] Contact support page
      </div>
      <div class="ft-page timeline">
         <h4 class="header">CAREER STATISTICS</h4>
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
      <sidebar/>
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
       ...mapActions(['postIndex', 'postCreate']),
       handleContentChange(event) {
         this.$set(this, 'content', event.target.value);
       },
       handleSubmit() {
         this.$set(this, 'posting', true);
         let postPromise = this.postCreate({ postData: { content: this.content } });
         postPromise.then(post => {
           this.$set(this, 'posting', false);
           this.$set(this, 'content', '');
         });
       },
     },
     mounted() {
       this.postIndex();
     },
   };
</script>