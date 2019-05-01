<template>
  <div>
    <div class="container-fluid">
      <div class="ft-page messages">
        <h4 class="spaced-title upper-cased main-color">Messages</h4>
        <div class="a-side-indicator primary">
          <div class="arrow"></div>
          <ft-button :on-click="openNewMessageModal" icon="regular/edit">Write Message</ft-button>
        </div>
        <div v-if="successMessage">
          <em>{{ successMessage }}</em>
        </div>
        <b-modal ref="newMessageModal" id="new-message-modal" size="lg" hide-footer hide-header centered>
          <new-message-popup @closeModal="closeNewMessageModal" @updateSuccessMessage="updateSuccessMessage"/>
        </b-modal>
        <router-view></router-view>
      </div>
    </div>
    <messages-sidebar :currentChatWith="currentChatWith" />
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import TimelineItem from 'app/components/TimelineItem';
import MessagesSidebar from 'app/components/MessagesSidebar';
import FtButton from 'app/components/Button/Button';
import NewMessagePopup from 'app/components/NewMessage/NewMessageFormPopup'

export default {
  name: 'Messages',
  components: {
    MessagesSidebar,
    FtButton,
    TimelineItem,
    NewMessagePopup
  },
  data() {
    return {
      successMessage: ''
    }
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
    },
    openNewMessageModal() {
      this.$refs.newMessageModal.show()
      this.$set(this, 'successMessage', '');
    },
    closeNewMessageModal() {
      this.$refs.newMessageModal.hide()
    },
    updateSuccessMessage() {
      this.$set(this, 'successMessage', 'Message was successfully sent to all recipients');
    }
  }
};
</script>
