<template>
  <div class="wrapper">
    <div class="header-wrapper">
      <div class="header col-md-10">
        <div class="img-container">
          <img class="img-fluid avatar" src="https://unsplash.it/500/500" />
        </div>
        <div class="info col-md-8">
          <h2 class="title" :title="report.headline">{{report.headline}}</h2>
          <p class="extra">
            <span class="target" v-if="report.type_report =='player'">{{report.player.first_name}} {{report.player.last_name}} </span>
            <span class="target" v-if="report.type_report =='team'"> Club Name</span>
            <span class="target">{{report.price.value}} {{report.price.currency | currency}}</span>
            <span class="target">{{report.updated_at | moment}}</span>
          </p>
        </div>
      </div>
      <div class="widget">
        <a v-if="report.orders_status == null && typeof BuyAction === 'function'">
          <button class="btn-round" @click="BuyAction(report)">Buy report</button>
        </a>
        <a v-if="typeof summaryAction === 'function'">
            <button class="btn-round"  @click="summaryAction(report)">View Summary</button>
        </a>
        <a v-if="report.orders_status == 'completed'">
          <button class="btn-round" @click="refundAction(report)">Refund</button>
        </a>
        <a v-if="report.orders_status == 'completed'">
          <button class="btn-round" @click="viewAction(report)">View report</button>
        </a>
        <p v-if="report.orders_status == 'pending'">Payment in pending</p>

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
            .target {
              display: block;
            }
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
    name: 'ReportItem',
    props: ['report', 'UpdateReport', 'viewAction', 'summaryAction', 'BuyAction','refundAction']
  };
</script>
