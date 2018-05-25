<template>
  <div>
    <loading class="loader" v-if="loading" />
    <div class="diverrors" v-if="errors">
      <ul class="errors">
        <li >
          {{errors}}
        </li>
      </ul>
    </div>
    <div class="divSuccess" v-if="success">
      <ul class="success">
        <li>
          Account successfully deleted !
        </li>
      </ul>
    </div>
    <div class="content">
      <div v-if="none && bankAccount.account_holder_name">
        <div class="row">
          <p class="col-lg-6">Holder name</p>
          <p class="col-lg-6">{{bankAccount.account_holder_name}}</p>
        </div>
        <div class="row">
          <p class="col-lg-6">Country</p>
          <p class="col-lg-6">{{bankAccount.country}}</p>
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
       <div v-if="none">
          <p v-if="!isDeleteAccount">Are you sure you want to delete this bank account ?</p>
          <p v-if="isDeleteAccount">Are you sure you want to delete your account ?</p>
          <p v-if="isDeleteAccount">Please not that all your Report will be unpublished and bids pending canceled</p>
        </div>
      <div class="col-lg-12 buttons-inner">
        <button class="ft-button ft-button-danger" v-if="none" @click="startDelete()">Delete
        </button>
        <button class="ft-button ft-button-right" @click="closeAction()">Close
          <span v-if="success">✓</span>
        </button>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  .loader {
    margin-left: 40%;
  }

  .errors {
    li {
      color: red;
      &:first-letter {
        text-transform: capitalize;
      }
    }
  }
</style>

<script>
  import {
    ASYNC_SUCCESS,
    ASYNC_LOADING,
    ASYNC_FAIL,
    ASYNC_NONE
  } from 'app/constants/AsyncStatus';
  import Loading from 'app/components/Loading';

  export default {
    name: 'confirmDelete',
    props: ['bankAccount', 'deleteAction', 'closeAction', 'stripeFtouch','isDeleteAccount'],
    components: {
      loading: Loading
    },
    data() {
      return {
        start: false,
      }
    },
    computed: {
      loading() {
        return this.stripeFtouch.status == ASYNC_LOADING;
      },
      errors() {
        return this.stripeFtouch.status == ASYNC_FAIL ? this.stripeFtouch.errors.errors : null;
      },
      success() {
        return this.stripeFtouch.status == ASYNC_SUCCESS && this.start == true;
      },
      none() {
        return this.start == false;
      }
    },
    methods: {
      startDelete() {
        this.start = true;
        this.deleteAction();
      }
    }
  };
</script>
