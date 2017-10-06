<template>
  <router-link class="inbox-entry" :to="`/messages/${id}`" :class="{ active }">
    <img class="profile-pic" src="http://unsplash.it/400/400" />
    <div class="content">
      <div class="name">
        {{ chat.chat_with.display_name }}
      </div>

      <div class="short-message">
        {{ chat.last_message.message_body }}
      </div>
    </div>
  </router-link>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables.scss';
.inbox-entry {
  padding: 5px 10px;
  border-top: 1px solid #fff;
  font-weight: 300;
  display: flex;
  width: 100%;
  align-items: center;
  color: #fff;
  text-decoration: none;
  &:hover {
    cursor: pointer;
  }
  &.active {
    border-left: 7px solid $main-header-color;
    background-color: #000;
  }
  .profile-pic {
    max-height: 50px;
    border-radius: 50%;
  }
  .content {
    padding: 10px;
    white-space: nowrap;
    width: 80%;
    .name {
      font-size: 1em;
    }
    .short-message {
      font-size: 0.8em;
      text-overflow: ellipsis;
      white-space: nowrap;
      overflow: hidden;
    }
  }
}
</style>

<script>
export default {
  name: 'InboxEntry',
  props: ['chat', 'active', 'id'],
};
</script>