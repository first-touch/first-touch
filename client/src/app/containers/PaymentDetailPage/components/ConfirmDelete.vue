<template>
  <div>
    <loading class="loader" v-if="loading" />
    <div class="diverrors" v-if="errors">
      <ul class="errors">
        <li v-for="error in errors" :key="error.id">
          {{error}}
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
    <div class="content" >
      <div v-if="none">
        <div class="row">
          <p class="col-md-6">Holder name</p>
          <p class="col-md-6">{{bankAccount.account_holder_name}}</p>
        </div>
        <div class="row">
          <p class="col-md-6">Country</p>
          <p class="col-md-6">{{bankAccount.country}}</p>
        </div>
        <div class="row">
          <p class="col-md-6">Bank name</p>
          <p class="col-md-6">{{bankAccount.bank_name}}</p>
        </div>
        <div class="row">
          <p class="col-md-6">Last 4</p>
          <p class="col-md-6">{{bankAccount.last4}}</p>
        </div>
        <div>
          <p>Are you sure you want to delete this bank account ?</p>
        </div>
      </div>
      <div class="col-md-12 buttons-inner">
        <button class="ft-button ft-button-danger" v-if="none" @click="deleteAction()">Delete
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
import { ASYNC_SUCCESS, ASYNC_LOADING, ASYNC_FAIL, ASYNC_NONE } from 'app/constants/AsyncStatus';
import Loading from 'app/components/Loading';

export default {
  name: 'confirmDelete',
  props: ['bankAccount', 'deleteAction', 'closeAction', 'stripeDelete'],
  components: {
    loading: Loading
  },
  computed: {
    loading() {
      return this.stripeDelete.status == ASYNC_LOADING;
    },
    errors() {
      return this.stripeDelete.status == ASYNC_FAIL ? this.stripeDelete.errors.errors : null;
    },
    success() {
      return this.stripeDelete.status == ASYNC_SUCCESS;
    },
    none() {
      return this.stripeDelete.status == ASYNC_NONE;
    }
  }
};
</script>
