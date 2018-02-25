<template>
<div class="col-12 col-md-6">
  <img src={{ info.image }}
  <div class="info" v-on:click="goToNote">
    <h2 class="title">{{ info.name }}</h2>
    <img :src=info.image_url />
  </div>
  <span v-for="tag in info.tags" :key="tag" v-on:click="noteFn(tag)">
    {{ tag }}
  </span>
</div>
</template>
<script>
export default {
  name: 'Note',
  props: ['info', 'noteFn'],
  methods: {
    goToNote(){
      this.$router.push(`/notes/${this.$props.info.id}`);
    }
  },
};
</script>