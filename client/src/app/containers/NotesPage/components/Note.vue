<template>
<div class="wrapper">
  <div class="header-wrapper">
    <div class="header">
      <div class="img-container">
        <img class="img-fluid" src={{ info.image }}
      </div>
      <div class="info">
        <h2 class="title">{{ info.name }}</h2>
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
