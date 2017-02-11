<template>
  <div class="flex-col card club">
    <div class="front">
      <h2>{{title}}</h2>
      <a class="bar-button center more">More</a>
    </div>
    <div class="back">
      <h2>
        {{title}}
      </h2>
      <p>
        {{text}}
      </p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ft-board',
  pops: {
    title: {
      type: String,
      default: 'board title'
    },
    text: {
      type: String,
      default: 'board text'
    }
  }
}
</script>
