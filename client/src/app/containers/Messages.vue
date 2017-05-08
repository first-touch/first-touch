<template>
  <div>
    <div class="container-fluid">
      <div class="ft-page messages">
        <h4 class="header">Messages</h4>
        <conversation v-if="chosen"
          :messages="messages"
          :currentUser="user.value"
          :sendMessage="sendMessage.bind(this)"
          :reloadConversation="reloadConversation.bind(this, { token: token.value })" />
      </div>
    </div>
    <messages-sidebar :currentChatWith="currentChatWith" />
  </div>
</template>

<style lang="sass">
  @import "~stylesheets/variables";
  @import "~stylesheets/common_style";

  body {
    min-height: 0;
    height: auto;
  }
</style>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import { ASYNC_SUCCESS } from '../constants/AsyncStatus';
  import store from '../store';
  import MessagesSidebar from '../components/MessagesSidebar.vue';
  import Conversation from '../components/Conversation.vue';

  export default {
    name: 'Messages',
    components: {
      'messages-sidebar': MessagesSidebar,
      'conversation': Conversation
    },
    computed: {
      ...mapGetters(['messages', 'user', 'token']),
      chosen() {
        return this.messages.status === ASYNC_SUCCESS;
      },
      currentChatWith() {
        return this.chosen
          ? this.messages.value.chat_with.id
          : null;
      }
    },
    methods: {
      ...mapActions(['reloadConversation', 'sendMessage'])
    }
  }
</script>