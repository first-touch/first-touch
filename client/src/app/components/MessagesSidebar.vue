<template>
  <div class="sidenav-right">
    <div class="container">
      <div class="info-blk">
        <div class="info-blk-header row">
          <span class="col-8 no-padding">
            <span class="info-blk-header-name">
              All Messages
            </span>
          </span>
          <span class="col-3 no-padding">
            <b-btn class="d-block d-lg-none" v-b-toggle.menu-contents>
              <div class="bar">
              </div>
              <div class="bar">
              </div>
              <div class="bar">
              </div>
            </b-btn>
          </span>
        </div>

        <div class="row">
        <b-collapse is-nav visible id="menu-contents" class="d-lg-block">
          <b-card>
            <div class="row">
              <div class="info-blk-body">
                <div class="sidebar-widget">
                  <div class="row d-md-flex flex-md-row">
                    <div class="col no-padding">
                      <input v-model="searchTerm" type="text" class="search" placeholder="Type a name" />
                    </div>
                    <div class="col no-padding">
                      <select class="sort" v-model="sortTerm">
                        <option disabled>Sort</option>
                        <option>Name</option>
                        <option>Club</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </b-card>
        </b-collapse>
        </div>

        <div class="inbox">
          <inbox-entry v-for="chat in chats" :chat="chat" :active="active(chat.chat_with.id)" :id="chat.chat_with.id" :key="chat.id"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  .sidenav-right {
    margin-top: 119px;
    padding-top: 5px;
    height: calc(100vh - 119px);
    box-shadow: -2px 2px 2px #555;
  }
  .bar {
    box-sizing: border-box;
    border-top: 1px solid white;
    width: 15px;
    margin: 3px;
  }

  .btn-secondary,
  .btn-secondary:active,
  .btn-secondary:focus,
  .btn-secondary:not([disabled]):not(.disabled).active,
  .btn-secondary:not([disabled]):not(.disabled):active,
  .show>.btn-secondary.dropdown-toggle {
    padding: 5px;
    background-color: transparent;
  }
  .card {
    background: transparent;
    .card-body {
      padding: 0;
      .info-blk-body {
        margin-left: 15px;
      }
    }
  }
  .sidebar-widget {
    .search,
    .sort {
      margin-bottom: 5%;
      border: 1px solid #fff;
      background-color: transparent;
      color: #fff;
      padding: 2px 7px;
      height: 25px;
      margin-left: 16px;
    }
    .search {
      border-radius: 4px;
      width: 130px;
    }
  }
  .inbox {
    margin-top: 20px;
    height: 420px;
    overflow-y: scroll;
    .inbox-entry:last-child {
      border-bottom: 1px solid #fff;
    }
  }
</style>

<script>
  import {
    mapActions,
    mapGetters
  } from 'vuex';
  import InboxEntry from './InboxEntry.vue';

  export default {
    name: 'MessagesSidebar',
    components: {
      'inbox-entry': InboxEntry,
    },
    props: ['currentChatWith', 'changeConvo'],
    data() {
      return {
        searchTerm: '',
        sortTerm: 'Sort',
      };
    },
    computed: {
      ...mapGetters(['token', 'inbox']),
      chats() {
        if (!this.inbox.value) return [];
        let value = this.inbox.value;
        if (this.searchTerm !== '') {
          value = value.filter(v =>
            v.chat_with.display_name
            .toLowerCase()
            .includes(this.searchTerm.toLowerCase()),
          );
        }
        if (this.sortTerm === 'Name') {
          value = value.sort(
            (a, b) => a.chat_with.display_name > b.chat_with.display_name,
          );
        }
        return value;
      },
    },
    methods: {
      ...mapActions(['getInbox', 'getConversation']),
      active(id) {
        return id === parseInt(this.currentChatWith);
      },
    },
    mounted() {
      this.getInbox({
        token: this.token.value
      });
    },
  };
</script>
