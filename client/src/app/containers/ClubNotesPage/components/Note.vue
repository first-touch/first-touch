<template>
  <div class="wrapper">
    <div class="header-wrapper">
      <div class="header">
        <div class="img-container">
          <img class="img-fluid" src="https://static1.squarespace.com/static/543ecc8de4b0a4f2ae6d3908/t/543efb25e4b0faf717591299/1413413671222/"
          />
        </div>
        <div class="info">
          <h2 class="title">LOREM IPSUM</h2>
          <p class="extra">
            <span class="author">Cristiano Ronaldo</span> May 20 6:40pm
          </p>
        </div>
      </div>
      <div class="widget">
        <button class="btn-round" @click="toggleView">View</button>
        <button class="btn-round">Private</button>
      </div>
    </div>
    <div class="body" v-if="show">
      <p class="content">
        Bacon ipsum dolor amet short loin pork beef ribs, frankfurter doner alcatra turducken. Sausage prosciutto pork loin alcatra
        jowl turducken corned beef drumstick. Porchetta beef jowl, cupim ham pork tri-tip rump pig pork chop. Fatback bacon
        ground round jerky chicken pork loin burgdoggen sausage swine tri-tip pork doner ham spare ribs short loin. Shank
        corned beef capicola turducken turkey meatloaf short ribs kevin tri-tip pig pork chop rump. Pork chop capicola flank
        alcatra kielbasa boudin bacon. Corned beef tail leberkas salami.
      </p>
      <div class="widget">
        <button class="btn btn-round btn-green">Edit note</button>
        <button class="btn btn-round btn-green">Open all</button>
        <button class="btn btn-round btn-green">Comment</button>
        <button class="btn btn-round btn-white">Delete</button>
        <button class="btn btn-round btn-white">Close</button>
      </div>
      <div class="comment-section">
        <h3 class="title">Comments</h3>
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
        .btn-round {
          border-radius: 9999px;
          border: 1px solid $secondary-text-color;
          background: #fff;
          width: 100px;
        }
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
        .btn-round {
          border-radius: 9999px;
        }
        .btn-white {
          background: #fff;
          border: 1px solid $secondary-text-color;
        }
        .btn-green {
          background: $main-header-color;
          border: 1px solid $main-header-color;
        }
      }
      .comment-section {
        padding-top: 15px;
        &:before {
          content: '';
          position: absolute;
          left: 150px;
          width: 15%;
          margin-top: -15px;
          border-top: 2px solid $secondary-text-color;
        }
        .title {
          font-weight: 300;
          text-transform: uppercase;
        }
      }
    }
  }
</style>
<script>
  export default {
    name: 'Note',
    data() {
      return {
        show: false
      };
    },
    methods: {
      toggleView() {
        this.$set(this, 'show', !this.show);
      },
    },
  };
</script>
