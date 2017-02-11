<template>
  <a class="bar-button center" :href="url">
    <slot></slot>
  </a>
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
