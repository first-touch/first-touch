import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE, ASYNC_FAIL, ASYNC_SUCCESS, ASYNC_LOADING
} from '../../constants/AsyncStatus';
export const stripe = {
  status: ASYNC_NONE,
  value: null,
  errors: null,
  saving: false
};

export const stripeFtouch = {
  status: ASYNC_NONE,
  value: null,
  errors: null
};

export default {
  [ActionTypes.SAVE_STRIPE_ACCOUNT_LOADING] (state) {
    state.stripeFtouch = Object.assign(
      {},
      state.stripeFtouch,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.SAVE_STRIPE_ACCOUNT_SUCCESS] (state, stripe) {
    state.stripeFtouch = Object.assign(
      {},
      state.stripeFtouch,
      { status: ASYNC_SUCCESS, value: stripe }
    );
  },
  [ActionTypes.SAVE_STRIPE_ACCOUNT_FAILURE] (state, errors) {
    state.stripeFtouch = Object.assign(
      {},
      state.stripeFtouch,
      { status: ASYNC_FAIL, errors: errors }
    );
  },
  [ActionTypes.STRIPE_CREATE_ACCOUNT_LOADING] (state) {
    state.stripe = Object.assign(
      {},
      state.stripe,
      { status: ASYNC_LOADING, saving: true }
    );
  },
  [ActionTypes.STRIPE_CREATE_ACCOUNT_SUCCESS] (state, stripe) {
    state.stripe = Object.assign(
      {},
      state.stripe,
      { status: ASYNC_SUCCESS, value: stripe, saving: true }
    );
  },
  [ActionTypes.STRIPE_CREATE_ACCOUNT_FAILURE] (state, errors) {
    state.stripe = Object.assign(
      {},
      state.stripe,
      { status: ASYNC_FAIL, errors: errors, saving: true }
    );
  },
  [ActionTypes.GET_STRIPE_ACCOUNT_LOADING] (state) {
    state.stripe = Object.assign(
      {},
      state.stripe,
      { status: ASYNC_LOADING, saving: false }
    );
  },
  [ActionTypes.GET_STRIPE_ACCOUNT_SUCCESS] (state, stripe) {
    state.stripe = Object.assign(
      {},
      state.stripe,
      { status: ASYNC_SUCCESS, value: stripe, saving: false }
    );
  },
  [ActionTypes.GET_STRIPE_ACCOUNT_FAILURE] (state, errors) {
    state.stripe = Object.assign(
      {},
      state.stripe,
      { status: ASYNC_FAIL, errors: errors, saving: false }
    );
  }
};
