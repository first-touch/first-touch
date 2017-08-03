<template>
  <div class="message" :class="{ mine }">
    <div class="message-container">
      <div class="content">
        <p>{{ info.message_body }}</p>
      </div>
      <div class="author">
        <span class="name">{{ author }}</span> at {{ niceDate }}
      </div>
    </div>
  </div>
</template>

<style lang="sass" scoped>
  @import "~stylesheets/variables.scss";

  .message {
    width: 80%;
    margin-bottom: 20px;
    &.mine {
      align-self: flex-end;
      .message-container {
        display: flex;
        flex-direction: column;
        .content {
          border-color: $secondary-header-color;
        }
        .author {
          align-self: flex-end;
        }
      }
    }
    .message-container {
      .content {
        padding: 10px 20px;
        border: 2px solid $main-header-color;
        border-radius: 4px;
        p {
          color: $main-text-color;
          font-weight: 300;
          margin: 0;
        }
      }
      .author {
        color: $main-text-color;
        .name { color: #000; }
      }
    }

  }
</style>

<script>
  export default {
    name: 'ConvoEntry',
    props: ['mine', 'info', 'author', 'time'],
    computed: {
      niceDate() { return (new Date(this.time)).toLocaleString(); }
    },
    mounted() {
      $('.conversation .body').animate({
        scrollTop: $('.conversation .body .message:last-child').offset().top
      });
    }
  }
</script>