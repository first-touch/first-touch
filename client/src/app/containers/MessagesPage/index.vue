<template>
  <div>
    <div class="ft-page container messages">
      <h4 class="spaced-title upper-cased main-color page-title mb-5">Messages</h4>
      <div class="a-side-indicator primary">
        <div class="arrow"></div>
        <ft-button :on-click="openNewMessageModal" icon="regular/edit">Write Message</ft-button>
      </div>
      <b-modal ref="newMessageModal" id="new-message-modal" size="lg" hide-footer hide-header centered>
        <new-message-popup @closeModal="closeNewMessageModal" @updateSuccessMessage="updateSuccessMessage"/>
      </b-modal>
      <div class="row">
        <messages-sidebar :currentChatWith="currentChatWith" class="col-md-4" v-bind:class="sidebarDisplayClass"/>
        <div class="col-md-8">
          <div class="row">
            <div class="col-12 d-sm-none">
              <router-link v-if="chatLoaded" to="/messages"> Back to inbox </router-link>
            </div>
            <router-view class="col-12" v-bind:class="chatboxDisplayClass"></router-view>
          </div>
        </div>
      </div>
    </div>
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
    chatLoaded() {
      return !_.isUndefined(this.currentChatWith);
    },
    sidebarDisplayClass() {
      return {
        'd-none': this.chatLoaded,
        'd-md-block': this.chatLoaded
      }
    },
    chatboxDisplayClass() {
      return {
        'd-none': !this.chatLoaded,
        'd-md-block': !this.chatLoaded
      }
    }
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
    }
  }
};
</script>
