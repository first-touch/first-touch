<!-- template for the polygraph component. -->
<template>
  <svg width="800px" height="600px" fill="green">
    <template v-for="item in info">
      <circle :cx=itemX(item) :cy=itemY(item) r="10px" stroke="black" fill="red" v-if="isCircle(item)" />
      <polygon :points=getTriangleCoordinates(item) v-if="isTriangle(item)" fill="blue" stroke="black" />
      <rect :x=itemX(item) :y=itemY(item) width="50px" height="50px" v-if="isSquare(item)" fill="green"/>
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
        return item.size * width;
      },
      getTriangleCoordinates: function(item){
        let scale = 20;
        return `${this.itemX(item) + scale},${this.itemY(item) + scale} `
              + `${this.itemX(item)},${this.itemY(item) - scale} `
              + `${this.itemX(item) - scale},${this.itemY(item) + scale} `

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