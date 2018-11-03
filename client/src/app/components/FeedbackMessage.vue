<template>
  <transition name="fade"
              enter-active-class="fadeIn"
              leave-active-class="fadeOut"
              v-on="hooks">
    <div v-if="show" class="m-feedback">
      <div class="text-wrapper">
        {{ messageContent }}
      </div>
    </div>
  </transition>
</template>

<script>
export default {
  name: 'FeedbackMessage',
  data() {
    return {
      show: false
    };
  },
  computed: {
    hooks() {
      return {
        beforeEnter: this.setDuration,
        beforeLeave: this.setDuration,
        afterEnter: this.hideMessage,
        ...this.$listeners
      };
    }
  },
  methods: {
    displayMessage(messageContent) {
      if(messageContent == "") {
        return;
      }
      this.messageContent = messageContent;
      this.show = true;
    },
    setDuration(el) {
      el.style.animationDuration = '1500ms';
    },
    hideMessage() {
      this.show = false;
    }
  },
}
</script>

<style>
  @keyframes fadeIn {
    from {
      opacity: 0;
    }
    to {
      opacity: 1;
    }
  }
  .fadeIn {
    animation-name: fadeIn;
  }

  @keyframes fadeOut {
    from {
      opacity: 1;
    }
    to {
      opacity: 0;
    }
  }
  .fadeOut {
    animation-name: fadeOut;
  }
</style>
