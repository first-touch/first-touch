<template>
<div class="timeline-widget-button">
  <button @click="onClick">
    <slot>
      <span class="fa fa-camera"></span>
      Button
    </slot>
  </button>
</div>
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
