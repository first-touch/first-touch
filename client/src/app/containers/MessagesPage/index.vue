<template>
  <div>
    <div class="container-fluid">
      <div class="ft-page messages">
        <h4 class="header">Messages</h4>
        <router-view v-if="currentChatWith"></router-view>
      </div>
    </div>
    <messages-sidebar :currentChatWith="currentChatWith" />
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  @import '~stylesheets/common_style';

  body {
    min-height: 0;
    height: auto;
  }
</style>

<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import MessagesSidebar from 'app/components/MessagesSidebar.vue';

  export default {
    name: 'Messages',
    components: {
      'messages-sidebar': MessagesSidebar,
    },
    computed: {
      ...mapGetters(['messages', 'user', 'token']),
      currentChatWith() {
        return this.$route.params.id;
      },
    },
    methods: {
      ...mapActions(['reloadConversation', 'sendMessage']),
    },
  };
</script>
