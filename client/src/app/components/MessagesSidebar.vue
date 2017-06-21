<template>
  <div class="sidenav-right">
    <div class="info-blk">
      <div class="info-blk-header">
        <span class="info-blk-header-name">
          All Messages
        </span>
      </div>
      <div class="info-blk-body">
        <div class="sidebar-widget">
          <input v-model="searchTerm" type="text" class="search" placeholder="Type a name" />
          <select class="sort" v-model="sortTerm">
            <option disabled>Sort</option>
            <option>Name</option>
            <option>Club</option>
          </select>
        </div>
      </div>
      <div class="inbox">
        <inbox-entry v-for="chat in chats"
          :chat="chat"
          :active="active(chat.chat_with.id)"
          :id="chat.chat_with.id" />
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
  .sidenav-right {
    margin-top: 119px;
    padding-top: 5px;
    height: calc(100vh - 119px);
    box-shadow: -2px 2px 2px #555;
  }

  .sidebar-widget {
    display: flex;
    .search, .sort {
      flex: 0 1 40%;
      margin-right: 5%;
      border: 1px solid #fff;
      background-color: transparent;
      color: #fff;
      padding: 2px 7px;
    }
    .search {
      border-radius: 4px;
    }
  }

  .inbox {
    margin-top: 20px;
    height: 420px;
    overflow-y: scroll;
    .inbox-entry:last-child { border-bottom: 1px solid #fff; }
  }
</style>

<script>
  import { mapActions, mapGetters } from 'vuex';
  import store from '../store';
  import InboxEntry from './InboxEntry.vue';

  export default {
    name: 'MessagesSidebar',
    components: {
      'inbox-entry': InboxEntry
    },
    props: ['currentChatWith', 'changeConvo'],
    data() {
      return {
        searchTerm: '',
        sortTerm: 'Sort'
      }
    },
    computed: {
      ...mapGetters(['token', 'inbox']),
      chats() {
        if (!this.inbox.value) return [];
        let value = this.inbox.value;
        if (this.searchTerm !== '') {
          value = value.filter((v) => v.chat_with.display_name.toLowerCase().includes(this.searchTerm.toLowerCase()));
        }
        if (this.sortTerm === 'Name') {
          value = value.sort((a, b) => a.chat_with.display_name > b.chat_with.display_name);
        }
        return value;
      }
    },
    methods: {
      ...mapActions(['getInbox', 'getConversation']),
      active(id) {
        return id === parseInt(this.currentChatWith);
      }
    },
    mounted() {
      this.getInbox({ token: this.token.value })
    }
  }
</script>