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
// import {
//   StripePublicKey
// } from 'app/constants/StripeConstant';

// export const stripeJs = window.Stripe(StripePublicKey);
export const stripeFtouch = {
  status: ASYNC_NONE,
  value: null,
  errors: null
};

export const stripeDelete = {
  status: ASYNC_NONE,
  value: null,
  errors: null
};

export const stripeRequiredFields = {
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
    state.stripeFtouch = Object.assign(
      {},
      state.stripeFtouch,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.GET_STRIPE_ACCOUNT_SUCCESS] (state, stripe) {
    state.stripeFtouch = Object.assign(
      {},
      state.stripeFtouch,
      { status: ASYNC_SUCCESS, value: stripe }
    );
  },
  [ActionTypes.GET_STRIPE_ACCOUNT_FAILURE] (state, errors) {
    state.stripeFtouch = Object.assign(
      {},
      state.stripeFtouch,
      { status: ASYNC_FAIL, errors: errors }
    );
  },
  [ActionTypes.STRIPE_REQUIRED_FIELDS_LOADING] (state) {
    state.stripeRequiredFields = Object.assign(
      {},
      state.stripeRequiredFields,
      { status: ASYNC_LOADING, saving: false }
    );
  },
  [ActionTypes.STRIPE_REQUIRED_FIELDS_SUCCESS] (state, stripe) {
    state.stripeRequiredFields = Object.assign(
      {},
      state.stripeRequiredFields,
      { status: ASYNC_SUCCESS, value: stripe, saving: false }
    );
  },
  [ActionTypes.STRIPE_REQUIRED_FIELDS_FAILURE] (state, errors) {
    state.stripeRequiredFields = Object.assign(
      {},
      state.stripeRequiredFields,
      { status: ASYNC_FAIL, errors: errors, saving: false }
    );
  },
  [ActionTypes.DELETE_STRIPE_LOADING] (state) {
    state.stripeFtouch = Object.assign(
      {},
      state.stripeFtouch,
      { status: ASYNC_LOADING, saving: false }
    );
  },
  [ActionTypes.DELETE_STRIPE_SUCCESS] (state, stripe) {
    state.stripeFtouch = Object.assign(
      {},
      state.stripeFtouch,
      { status: ASYNC_SUCCESS, value: stripe, saving: false }
    );
  },
  [ActionTypes.DELETE_STRIPE_FAILURE] (state, errors) {
    state.stripeFtouch = Object.assign(
      {},
      state.stripeFtouch,
      { status: ASYNC_FAIL, errors: errors, saving: false }
    );
  },
  [ActionTypes.DELETE_STRIPE_FLUSH] (state) {
    state.stripeDelete = Object.assign({}, state.stripeDelete, {
      status: ASYNC_NONE,
      value: []
    });
  }

};
