<template>
  <div class="cardList" :class="[loading == true ? 'loading' : '']">
    <loading class="loader" />
    <div class="empty" v-if="!info || !info.cards || info.cards.length == 0">
      You do not have any registered card yet
    </div>
    <div class="row col-lg-12 ft-cards-result" v-if="info && info.cards">
      <div v-for="card in info.cards" :key="card.key" class="col-lg-5 ft-card">
        <div class="content-wrapper">
          <div class="content col-lg-12">
            <div class="row">
              <p class="col-lg-6">Payment Method</p>
              <p class="col-lg-6">{{card.brand}}</p>
            </div>
            <div class="row">
              <p class="col-lg-6">Expery Date</p>
              <p class="col-lg-6">{{card.exp_month | formatNumber(2)}}/{{card.exp_year}}</p>
            </div>
            <div class="row">
              <p class="col-lg-6">Last 4</p>
              <p class="col-lg-6">************{{card.last4}}</p>
            </div>
          </div>
          <div class="buttons-inner col-lg-12" >
            <button class="ft-button ft-button-success" v-if="preferred != card.id " @click="customUpdateCards(card.id)">Make this preferred</button>
            <button class="ft-button ft-button-success" disabled v-if="preferred == card.id ">Preferred</button>
            <button class="ft-button" @click="customDeleteCard(card.id)">Delete</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  @import '~stylesheets/form';
  .cardList {
    .empty {
      color: $main-text-color;
    }
    .loader {
      display: none;
      margin-left: 40%;
    }
    .header {
      display: flex;
      flex-direction: row-reverse;
    }
    &.loading,
    &.success {
      .content {
        display: none;
      }
    }
    &.loading {
      .loader {
        display: block;
      }
      .empty {
        display: none;
      }
    }
    .ft-cards-result {
      display: flex;
      flex-wrap: wrap;
      color: $main-text-color;
      .ft-card {
        padding: 20px;
        border: 2px solid $main-text-color;
        margin-bottom: 20px;
        border-radius: 10px;
        display: inline-block;
        .buttons-inner {
          flex-direction: row !important;
        }
        &:nth-child(even) {
          margin-left: 8%;
        }
        .avatar {
          height: 100px;
          border-radius: 50%;
        }
        .info {
          display: flex;
          flex-direction: column;
          .title {
            a {
              color: $main-header-color;
              font-size: 1.5rem;
              letter-spacing: 2px;
            }
          }
          .price {
            margin-top: auto;
          }
        }
        .buttons-inner {
          display: flex;
          flex-direction: column-reverse;
          button {
            margin-left: auto;
          }
        }
      }
    }
  }
</style>

<script>
  import Loading from 'app/components/Loading';
  import {
    ASYNC_SUCCESS,
    ASYNC_LOADING,
    ASYNC_FAIL
  } from 'app/constants/AsyncStatus';

  export default {
    name: 'CardsList',
    props: ['stripeClubCards','preferredCard','deleteCard','updateCards'],
    components: {
      loading: Loading
    },
    computed: {
      loading() {
        return this.stripeClubCards.status == ASYNC_LOADING;
      },
      success() {
        return this.stripeClubCards.status == ASYNC_SUCCESS;
      },
      failure(){
        return this.stripeClubCards.status == ASYNC_FAIL;
      },
      info() {
        if (this.stripeClubCards.value && !this.loading) return this.stripeClubCards.value;
        return {};
      },
      preferred() {
        if (this.success)
        if (this.info) return this.info.default_source;
        return null
      }
    },
    methods:{
      customDeleteCard(id){
        this.deleteCard({id});
      },
      customUpdateCards(id){
        this.updateCards({id});
      }
    },
  }
</script>
