<template>
  <conversation v-if="loaded"
    :messages="messages"
    :currentUser="user.value"
    :sendMessage="sendMessage"
    :reloadConversation="reloadConversation.bind(this, { token: this.token.value })" />
</template>

<style lang="sass">

</style>

<script>
  import { mapGetters, mapActions } from 'vuex';
  import store from '../store';
  import { ASYNC_SUCCESS } from '../shared/constants/AsyncStatus';
  import Conversation from '../components/Conversation.vue';

  export default {
    name: 'ConvoContainer',
    components: {
      'conversation': Conversation
    },
    computed: {
      ...mapGetters(['token', 'user', 'messages']),
      loaded() {
        return this.messages.status === ASYNC_SUCCESS;
      }
    },
    methods: {
      ...mapActions(['getConversation', 'reloadConversation', 'sendMessage']),
      onRouteChange() {
        const token = this.token.value;
        const partnerId = this.$route.params.id;
        this.getConversation({ token, partnerId });
      }
    },
    mounted() {
      this.onRouteChange();
      store.watch(() => this.$route.params.id, this.onRouteChange);
    }
  }
</script>