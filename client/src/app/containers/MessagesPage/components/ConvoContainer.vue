<template>
  <conversation v-if="loaded"
    :messages="messages"
    :currentUser="user.value"
    :sendMessage="sendMessage"
    :reloadConversation="reloadConversation.bind(this, { token: this.token.value })" />
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import store from 'app/store';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import Conversation from './Conversation';

export default {
  name: 'ConvoContainer',
  components: {
    conversation: Conversation,
  },
  computed: {
    ...mapGetters(['token', 'user', 'messages']),
    loaded() {
      return this.messages.status === ASYNC_SUCCESS;
    },
  },
  methods: {
    ...mapActions(['getConversation', 'reloadConversation', 'sendMessage']),
    onRouteChange() {
      const token = this.token.value;
      const partnerId = this.$route.params.id;
      this.getConversation({ token, partnerId });
    },
  },
  mounted() {
    this.onRouteChange();
    store.watch(() => this.$route.params.id, this.onRouteChange);
  },
};
</script>
