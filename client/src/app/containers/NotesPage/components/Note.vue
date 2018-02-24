<template>
<div class="col-12 col-md-6">
  <img src={{ info.image }}
  <div class="info">
    <h2 class="title">{{ info.name }}</h2>
    <span v-for="tag in info.tags">
      {{ tag }}
    </span>
  </div>
</div>
</template>
<script>
export default {
  name: 'Note',
  props: ['info']
};
</script>
