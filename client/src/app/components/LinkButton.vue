<template>
  <router-link class="form-control a-bar-button center" :to="url">
    <slot></slot>
  </router-link>
</template>

<script>
export default {
  name: 'v-linkbutton',
  props: {
    url: {
      type: String,
      default: '#'
    }
  }
}
</script>
