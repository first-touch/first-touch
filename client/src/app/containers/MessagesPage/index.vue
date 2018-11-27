<template>
  <div>
    <div class="container-fluid">
      <div class="ft-page messages">
        <h4 class="spaced-title upper-cased main-color">Messages</h4>
        <div class="a-side-indicator primary">
          <div class="arrow"></div>
          <ft-button :on-click="writeNewMessage" icon="ft-notes">Write Message</ft-button>
        </div>
        <router-view v-if="currentChatWith"></router-view>
        <div v-else class="new-message">
          Write a new message
        </div>
      </div>
    </div>
    <messages-sidebar :currentChatWith="currentChatWith" />
  </div>
</template>

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
    writeNewMessage() {
      this.$router.push({ path: '/messages' });
    }
  },
};
</script>
