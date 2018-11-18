<template>
<button @click="onClick">
  <slot>
    <span class="fa fa-camera"></span>
    Button
  </slot>
</button>
</template>

<script>
export default {
  props: {
    onClick: {
      type: Function,
      required: true
    }
  }
}
</script>
