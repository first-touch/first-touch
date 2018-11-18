<template>
  <div>
    <div class="container-fluid">
      <div class="ft-page messages">
        <h4 class="spaced-title upper-cased main-color">Messages</h4>
        <ft-button :on-click="consoleClick">
          <span class="fa fa-notes"></span>
          Write Message
        </ft-button>
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
import { mapGetters, mapActions } from 'vuex';
import MessagesSidebar from 'app/components/MessagesSidebar';
import Button from 'app/components/Button/Button';

export default {
  name: 'Messages',
  components: {
    'messages-sidebar': MessagesSidebar,
    'ft-button': Button,
  },
  computed: {
    ...mapGetters(['messages', 'user', 'token']),
    currentChatWith() {
      return this.$route.params.id;
    },
  },
  methods: {
    ...mapActions(['reloadConversation', 'sendMessage']),
    consoleClick() {
      console.log('Button clicked')
    }
  },
};
</script>
