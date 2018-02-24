<template>
<div class="wrapper">
  <div class="header-wrapper">
    <div class="header">
      <img src={{ info.image }}
      <div class="info">
        <h2 class="title">{{ info.name }}</h2>
        <div v-for="tag in info.tags">
          {{ tag }}
        </div>
      </div>
    </div>
  </div>
</div>
</template>
<script>
export default {
  name: 'Note',
  props: ['info']
};
</script>
