<template>
  <timeline-item>
    <div class="sub-container">
      <div class="header">
        <img class="avatar" src="https://unsplash.it/200/200" />
        <div class="info">
          <h5 class="name">{{ name }}</h5>
          <p class="role">Football Player at FC Barcelona</p>
        </div>
      </div>
      <div class="body">
        <convo-entry
          v-for="entry in entries"
          :info="entry"
          :author="authorName(entry.creator_id)"
          :time="entry.updated_at"
          :mine="mine(entry.creator_id)"
          :key="entry.id" />
      </div>
      <div class="footer">
        <form @submit.prevent="send">
          <button type="button" class="btn btn-upload">
            <span>+</span>
          </button>
          <input v-model="content" type="text" class="form-input" placeholder="Write a message..." />
          <button type="submit" class="btn btn-send">
            <span>&gt;</span>
          </button>
        </form>
      </div>
    </div>
  </timeline-item>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables.scss';

.body {
  display: flex;
  flex-direction: column;
  height: calc(100vh - 420px);
  min-height: 150px;
  overflow-y: scroll;
}
.footer form {
  display: flex;
  width: 100%;
  justify-content: space-between;
  align-items: center;
  .btn {
    flex: 0 0 40px;
    height: 50px;
    border-radius: 50%;
    border: none;
    background: $main-header-color;
    font-weight: bold;
    color: #fff;
    margin: 0 10px;
  }
  .form-input {
    flex: 1 1 100%;
    padding: 10px;
    border-radius: 4px;
    border: 1px solid $main-text-color;
    color: $main-text-color;
    height: 40px;
  }
}
</style>

<script>
import TimelineItem from 'app/components/TimelineItem';
import ConvoEntry from './ConvoEntry';
export default {
  name: 'Conversation',
  props: ['currentUser', 'messages', 'reloadConversation', 'sendMessage'],
  components: {
    'convo-entry': ConvoEntry,
    'timeline-item': TimelineItem,
  },
  data() {
    return {
      content: '',
    };
  },
  computed: {
    name() {
      return this.messages.value.chat_with.display_name;
    },
    entries() {
      return this.messages.value.messages;
    },
  },
  methods: {
    mine(id) {
      return this.currentUser.id === id;
    },
    authorName(id) {
      return this.currentUser.id === id
        ? `${this.currentUser.personal_profile.first_name} ${this.currentUser
            .personal_profile.last_name}`
        : this.name;
    },
    send() {
      this.sendMessage({ content: this.content });
      this.$set(this, 'content', '');
    },
  },
  mounted() {
    this.reloadInterval = setInterval(this.reloadConversation, 5000);
  },
  beforeDestroy() {
    clearInterval(this.reloadInterval);
  },
};
</script>