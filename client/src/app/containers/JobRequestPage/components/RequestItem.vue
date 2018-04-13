<template>
    <div class="wrapper">
    <div class="header-wrapper">
      <div class="header col-md-10">
        <div class="img-container">
          <img class="img-fluid avatar" src="https://unsplash.it/500/500" />
        </div>
        <div class="info col-md-8">
          <h2 class="title" :title="request.headline">{{request.headline}}</h2>
          <p class="extra">
            <span class="target" v-if="request.type_request =='player'">{{request.player.first_name}} {{request.player.last_name}} </span>
            <span class="target" v-if="request.type_request =='team'"> Club Name</span>
            <span>{{request.updated_at | moment}}</span>
          </p>
        </div>
      </div>
      <div class="widget">
        <router-link :to="`/request/view/${request.id}`">
          <button class="btn-round">View</button>
        </router-link>
        <a v-if="request.status == 'publish'" @click="Updaterequest('private',request.id)">
          <button class="btn-round">Unpublish</button>
        </a>
        <a v-if="request.status == 'private'" @click="Updaterequest('publish',request.id)">
          <button class="btn-round">Publish</button>
        </a>
      </div>
    </div>
    <div class="newResult col col-md-12" v-if="false" v-for="request in listRequest" :key="request.id">
      <p class="col col-md-2">{{request.id | requestId(request.type_request)}} </p>
      <p class="col col-md-2">
        <span class="action col-md-6 ">
          <router-link :to="`/club/request/${request.id}`">Edit</router-link>
        </span>
        <span class="action col-md-6 ">
          <a href='#' @click="updateStatus(request.id,'deleted')">Delete</a>
        </span>
      </p>
      <p class="col col-md-2">{{request.type_request}} Job Request</p>
      <p class="col col-md-2">{{request.created_at | moment}}</p>
      <p class="col col-md-2">
        <span class="action col-md-6 " v-if="request.status == 'publish'">Active</span>
        <span class="action col-md-6 " v-if="request.status == 'private'">Inactive</span>
        <span v-if="request.status == 'private'" class="action col-md-6 ">
          <a href="#" @click="updateStatus(request.id,'publish')">Active</a>
        </span>
        <span v-if="request.status == 'publish'" class="action col-md-6 ">
          <a href="#" @click="updateStatus(request.id,'private')">Desactivate</a>
        </span>
      </p>
      <p class="col col-md-2">WIP</p>
      <p class="col col-md-2">WIP</p>
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

    .avatar {
      height: 300px;
      border-radius: 50%;
    }

    .title {
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
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
          cursor: pointer;
          border-radius: 9999px;
          border: 1px solid $secondary-text-color;
          background: #fff;
          width: 100px;
          &:hover {
            background: $button-background-hover;
          }
        }
      }
    }
  }
</style>
<script>
  export default {
    name: 'RequestItem',
    props: ['request', 'UpdateRequest'],
  };
</script>
