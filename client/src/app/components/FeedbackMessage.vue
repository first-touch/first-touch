<template>
  <transition name="fade"
              enter-active-class="fadeIn"
              leave-active-class="fadeOut">
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
  props: [
    'feedbackClass'
  ],
  data() {
    return {
      show: false
    };
  },
  methods: {
    displayMessage() {
      this.messageContent = "Success";
      this.show = true;
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
