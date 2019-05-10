<template>
  <button v-if="onClick" @click="onClick" class="a-button header-button">
    <div class="icon-wrapper">
      <v-icon :name="icon" scale="1.5" class="round-icon"/>
    </div>
    <slot>
      Button
    </slot>
  </button>

  <router-link v-else class="a-button header-button" :to="linkTo">
    <div class="icon-wrapper">
      <v-icon :name="icon" scale="1.5" class="round-icon"/>
    </div>
    <slot>
      Button
    </slot>
  </router-link>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  a {
    &:hover {
      text-decoration: none;
    }
  }

  button, a {
    &:hover {
      .icon-wrapper {
        background-color: lighten($secondary-header-color, 10%);
      }

      color: $first-touch-white;
    }
  }

  .icon-wrapper {
    width: 50px;
    height: 50px;
    text-align: center;
    background-color: $secondary-header-color;
    color: $first-touch-white;
    border-radius: 50%;
    display: inline-block;
    line-height: 45px;
  }

  .header-button {
    color: $secondary-text-color;
    text-transform: uppercase;
    background-color: transparent;
    border: none;
  }
</style>

<script>
  import 'vue-awesome/icons';
  import VIcon from 'vue-awesome/components/Icon'

  export default {
    name: 'FtButton',
    components: {
      VIcon
    },
    props: {
      onClick: {
        type: Function,
        default: undefined
      },
      icon: {
        type: String,
        default: 'clipboard'
      },
      linkTo: {
        type: Object,
        default: function() {
          return {};
        }
      }
    }
  }
</script>
