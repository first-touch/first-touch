<template>
<div class="col-12 col-md-6">
  <img src={{ info.image }}
  <div class="info">
    <h2 class="title">{{ info.name }}</h2>
    <img :src=info.image_url />
    <span v-for="tag in info.tags"  :key="tag" v-on:click="noteFn(tag)">
      {{ tag }}
    </span>
  </div>
</div>
</template>
<script>
export default {
  name: 'Note',
  props: ['info', 'noteFn']
};
</script>
