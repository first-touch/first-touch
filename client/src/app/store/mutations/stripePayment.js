import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE, ASYNC_FAIL, ASYNC_SUCCESS, ASYNC_LOADING
} from '../../constants/AsyncStatus';
export const stripePayment = {
  status: ASYNC_NONE,
  value: null,
  errors: null,
  saving: false
};

export default {
  [ActionTypes.STRIPE_CARD_LOADING] (state) {
    state.stripePayment = Object.assign(
      {},
      state.stripePayment,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.STRIPE_CARD_SUCCESS] (state, stripe) {
    state.stripePayment = Object.assign(
      {},
      state.stripePayment,
      { status: ASYNC_SUCCESS, value: stripe }
    );
  },
  [ActionTypes.STRIPE_CARD_FAILURE] (state, errors) {
    state.stripePayment = Object.assign(
      {},
      state.stripePayment,
      { status: ASYNC_FAIL, errors: errors }
    );
  },
  [ActionTypes.FLUSH_STRIPE_CARD_TOKEN] (state) {
    state.stripePayment = Object.assign(
      {},
      state.stripePayment,
      { status: ASYNC_NONE }
    );
  }

};
