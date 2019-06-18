<template>
  <div>
    <div class="container">
      <div class="ft-page messages">
        <h4 class="spaced-title upper-cased main-color page-title mb-5">Messages</h4>
        <div class="a-side-indicator primary">
          <div class="arrow"></div>
          <ft-button :on-click="openNewMessageModal" icon="regular/edit">Write Message</ft-button>
        </div>
        <b-modal ref="newMessageModal" id="new-message-modal" size="lg" hide-footer hide-header centered>
          <new-message-popup @closeModal="closeNewMessageModal" @updateSuccessMessage="updateSuccessMessage"/>
        </b-modal>
        <button class="back-button" v-on:click="showInboxOnMobile">Back to inbox</button>
        <div class="row">
          <messages-sidebar :currentChatWith="currentChatWith" class="col-md-4"/>
          <router-view class="col-md-8"></router-view>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables.scss';

  @media (max-width: $max-mobile-width) {
    .back-button, .current-chat {
      display: block;
      color: white;
    }
  }

  .back-button, .current-chat {
    display: none;
  }
</style>

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
      this.flash("Message was successfully sent to all recipients", "success", { timeout: 3000, important: true });
    },
    showInboxOnMobile() {
      if (window.innerWidth < 1000) {
        $('.back-button').addClass('d-none').removeClass('d-block')
        $('.conversation-box').addClass('d-none').removeClass('d-block')
        $('.sidenav-right').addClass('d-block').removeClass('d-none')
        this.$router.push('/messages');
      }
    },
    showCurrentChatOnMobile() {
      if (window.innerWidth < 1000) {
        if (this.$route.path == "/messages") {
          return
        }
        $('.back-button').addClass('d-block').removeClass('d-none')
        $('.conversation-box').addClass('d-block').removeClass('d-none')
        $('.sidenav-right').addClass('d-none').removeClass('d-block')
      }
    }
  }
};
</script>
