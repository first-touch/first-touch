<template>
  <div class="report">
    <div class="user col-sm-3" v-if="report.user">
      <img class="rounded-circle img-fluid" src="https://unsplash.it/500/500" />
      <p class="name"> {{report.user.first_name}} {{report.user.last_name}} </p>
    </div>
    <div class="report-info col-sm-6">
      <div class="row">
        <label class="col col-sm-4">Report Name</label>
        <p class="col col-sm-6"> {{report.headline}} </p>
      </div>
      <div class="row">
        <label class="col col-sm-4">Report Type</label>
        <p class="col col-sm-6"> {{report.type_report}} </p>
      </div>
      <div class="row">
        <label class="col col-sm-4">Name</label>
        <p class="col col-sm-6"> What is that </p>
      </div>
      <div class="row">
        <label class="col col-sm-4">Price</label>
        <p class="col col-sm-6"> {{report.price}} </p>
      </div>
      <div class="row" v-if="typeof summaryAction === 'function'">
        <label class="col col-sm-4">Report Summary </label>
        <a class="col col-sm-6" @click="summaryAction(report)" href="#">View Summary</a>
      </div>
    </div>
    <div class="buttons" v-if="typeof viewAction === 'function'">
      <button v-if="report.orders_status == null" class="btn-primary" @click="BuyAction(report)">Buy report</button>
      <button v-if="report.orders_status == 'completed'" class="btn-primary" @click="viewAction(report)">View report</button>
      <p v-if="report.orders_status == 'pending'">Payment in pending</p>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .report {
    font-size: 13px;
    background: white;
    color: black;
    padding: 30px 50px;
    margin-top: 20px;
    .buttons {
      display: flex;
      button {
        align-self: flex-end;
      }
    }
    .user {
      text-align: center;
      .name {
        text-align: center;
        text-transform: capitalize;
        background: #e8e8e8;
        margin-top: 15px;
        padding: 10px;
      }
      img{
        max-height: 180px;
      }
    }
    .report-info {
      margin-left: 30px;
      margin-top: 20px;
      p::first-letter {
        text-transform: capitalize;
      }
    }
  }
</style>

<script>
  export default {
    name: 'ReportItem',
    props: ['report', 'viewAction', 'summaryAction','BuyAction']
  };
</script>
