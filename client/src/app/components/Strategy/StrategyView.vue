<!-- template for the polygraph component. -->
<template>
  <svg width="800px" height="600px">
    <template v-for="item in info">
      <circle :cx=itemX(item) :cy=itemY(item) :r=itemRadius(item) stroke="black" fill="red" v-if="isCircle(item)" />
      <polygon :points=getTriangleCoordinates(item) v-if="isTriangle(item)" fill="blue" />
      <polygon :points=getSquareCoordinates(item) v-if="isSquare(item)" fill="green" />
    </template>
  </svg>
</template>

<script>
  let width = 800;
  let height = 600;
  export default {
    name: 'StrategyView',
    props: ['info'],
    methods: {
      isCircle: function(item){
        return item.type === "circle";
      },
      isTriangle: function(item){
        return item.type === "triangle";
      },
      isSquare: function(item){
        return item.type === "square";
      },
      itemRadius: function(item){
        return item.size / 2;
      },
      getTriangleCoordinates: function(item){
        let scale = item.size / 2;
        return `${this.itemX(item) - scale},${this.itemY(item) - scale} `
             + `${this.itemX(item) + scale},${this.itemY(item) - scale} `
             + `${this.itemX(item)},${this.itemY(item) + scale}`
      },
      itemX: function(item){
        return item.x * width;
      },
      itemY: function(item){
        return item.y * height;
      }
    }
  };

</script>