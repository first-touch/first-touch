<template>
  <div class="bankAccountList" :class="[loading == true ? 'loading' : '']">
    <loading class="loader" />
    <div class="empty" v-if="!info || !info.external_accounts || info.external_accounts.length == 0">
      Please add a bank account first.
    </div>
    <div class="row col-lg-12 ft-banks-result" v-if="info && info.external_accounts">
      <div v-for="bankAccount in info.external_accounts" :key="bankAccount.key" class="col-lg-5 ft-bank">
        <div class="content-wrapper">
          <div class="content col-lg-12">
            <div class="row">
              <p class="col-lg-6">Holder name</p>
              <p class="col-lg-6">{{bankAccount.account_holder_name}}</p>
            </div>
            <div class="row">
              <p class="col-lg-6">Country</p>
              <p class="col-lg-6">{{bankAccount.country | country}}</p>
            </div>
            <div class="row">
              <p class="col-lg-6">Bank name</p>
              <p class="col-lg-6">{{bankAccount.bank_name}}</p>
            </div>
            <div class="row">
              <p class="col-lg-6">Last 4</p>
              <p class="col-lg-6">{{bankAccount.last4}}</p>
            </div>
          </div>
          <div class="buttons-inner col-lg-12" v-if="info.external_accounts.length > 1">
            <button class="ft-button ft-button-success" v-if="preferred != bankAccount.id " @click="preferredBank(bankAccount)">Make this preferred</button>
            <button class="ft-button ft-button-success" disabled v-if="preferred == bankAccount.id " @click="preferredBank(bankAccount)">Preferred</button>
            <button class="ft-button" v-if="idNotDelete != bankAccount.id" @click="deleteBank(bankAccount)">Delete</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  @import '~stylesheets/form';

  .bankAccountList {
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
    .ft-banks-result {
      display: flex;
      flex-wrap: wrap;
      color: $main-text-color;
      .ft-bank {
        padding: 20px;
        border: 2px solid $main-text-color;
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
    name: 'BankAccountList',
    props: ['stripe', 'deleteBank', 'preferredBank'],
    components: {
      loading: Loading
    },
    computed: {
      loading() {
        return this.stripe.status == ASYNC_LOADING;
      },
      info() {
        if (this.stripe.value && !this.loading) return this.stripe.value;
        return {};
      },
      preferred() {
        if (this.stripe.value && !this.loading) return this.stripe.value.preferred_account;
      },
      idNotDelete() {
        var id = null;
        for (var i in this.info.external_accounts) {
          if (this.info.default_currency == this.info.external_accounts[i].currency) {
            if (id != null)
              return null;
            id = this.info.external_accounts[i].id;
          }
        }
        return id;
      }
    }
  };
</script>
