<template>
<div class="wrapper">
  <div class="header-wrapper">
    <div class="header">
      <div class="img-container">
        <img class="img-fluid" src="https://static1.squarespace.com/static/543ecc8de4b0a4f2ae6d3908/t/543efb25e4b0faf717591299/1413413671222/"/>
      </div>
      <div class="info">
        <h2 class="title"> {{ note.name }} </h2>
        <p class="extra">
          <span class="author">{{ note.author }}</span> {{ note.updated_at }}
        </p>
      </div>
    </div>
    <div class="widget">
      <button class="form-control a-bar-button reverse" @click="toggleView" >View</button>
    </div>
  </div>
  <div class="body" v-if="show">
    <p class="content">
      {{ note.content }}
    </p>
    <div class="widget row">
      <div class="col-lg-4">
        <button class="form-control a-bar-button">Edit</button>
      </div>
      <div class="col-lg-4">
        <button class="form-control a-bar-button reverse">Delete</button>
      </div>
      <div class="col-lg-4">
        <button class="form-control a-bar-button reverse">Close</button>
      </div>
    </div>
  </div>
</div>
</template>
<style lang="scss" scoped>
@import '~stylesheets/variables';
.wrapper {
  padding: 0 30px;
  border-top: 1px solid $secondary-text-color;
  &:last-child {
    border-bottom: 1px solid $secondary-text-color;
  }

  .header-wrapper {
    display: flex;
    justify-content: space-between;
    .header {
      display: flex;
      .img-container {
        height: 120px;
        max-width: 120px;
        margin-right: 30px;
        .img-fluid {
          max-height: 100%;
        }
      }
      .info {
        display: flex;
        flex-direction: column;
        justify-content: center;
        .extra {
          text-transform: none;
          .author {
            color: #000;
          }
        }
      }
    }
    .widget {
      padding: 20px 0;
      display: flex;
      flex-direction: column;
      justify-content: space-around;
    }
  }

  .body {
    padding-left: 150px;
    color: $secondary-text-color;
    position: relative;
    .widget {
      font-size: 0.7em;
      margin-bottom: 20px;
      display: flex;
      justify-content: space-between;
    }
  }
}
</style>
<script>
export default {
  name: 'Note',
  props: ['note'],
  data() {
    return { show: false };
  },
  methods: {
    toggleView() {
      this.show = !this.show;
    },
  },
};
</script>
