<template>
<button @click="onClick" class="a-button header-button">
  <div class="icon-wrapper">
    <v-icon :name="icon" scale="1" class="round-icon"/>
  </div>
  <slot>
    Button
  </slot>
</button>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  button {
    &:hover {
      .icon-wrapper {
        background-color: lighten($secondary-header-color, 10%);
      }

      color: $first-touch-white;
    }
  }

  .icon-wrapper {
    width: 30px;
    height: 30px;
    text-align: center;
    background-color: $secondary-header-color;
    color: $first-touch-white;
    border-radius: 50%;
    display: inline-block;
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
    components:{
      VIcon
    },
    props: {
      onClick: {
        type: Function,
        required: true
      },
      icon: {
        type: String,
        default: 'clipboard'
      }
    }
  }
</script>
