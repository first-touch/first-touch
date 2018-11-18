<template>
  <div>
    <div class="container-fluid">
      <div class="ft-page messages">
        <h4 class="spaced-title upper-cased main-color">Messages</h4>
        <div class="timeline-widget">
          <div class="arrow"></div>
          <ft-button :on-click="consoleClick" icon="ft-notes">Write Message</ft-button>
        </div>
        <router-view v-if="currentChatWith"></router-view>
      </div>
    </div>
    <messages-sidebar :currentChatWith="currentChatWith" />
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
@import '~stylesheets/common_style';

// FIXME: Move this to a separate component and extract scss to organisms
.timeline-widget {
  display: flex;
  border-left: 7px solid $secondary-header-color;

  .arrow {
    margin-top: 14px;
    border-left-color: $secondary-header-color;
  }
}

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
