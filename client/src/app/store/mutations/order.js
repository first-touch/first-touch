import * as ActionTypes from 'app/constants/ActionTypes';
import {
  ASYNC_NONE, ASYNC_FAIL, ASYNC_SUCCESS, ASYNC_LOADING
} from 'app/constants/AsyncStatus';

export const order = {
  status: ASYNC_NONE,
  value: null,
  errors: null
};

export const refund = {
  status: ASYNC_NONE,
  value: null,
  errors: null
};

export default {
  [ActionTypes.ORDER_REPORT_LOADING] (state, order) {
    state.order = Object.assign(
      {},
      state.order,
      { status: ASYNC_LOADING, value: order }
    );
  },
  [ActionTypes.ORDER_REPORT_SUCCESS] (state, order) {
    state.order = Object.assign(
      {},
      state.order,
      { status: ASYNC_SUCCESS, value: order }
    );
  },
  [ActionTypes.ORDER_REPORT_FAILURE] (state, errors) {
    state.order = Object.assign(
      {},
      state.order,
      { status: ASYNC_FAIL, errors: errors }
    );
  },
  [ActionTypes.ORDER_REFUND_LOADING] (state, refund) {
    state.refund = Object.assign(
      {},
      state.refund,
      { status: ASYNC_LOADING, value: refund }
    );
  },
  [ActionTypes.ORDER_REFUND_SUCCESS] (state, refund) {
    state.refund = Object.assign(
      {},
      state.refund,
      { status: ASYNC_SUCCESS, errors: refund }
    );
  },
  [ActionTypes.ORDER_REFUND_FAILURE] (state, errors) {
    state.refund = Object.assign(
      {},
      state.refund,
      { status: ASYNC_FAIL, errors: errors }
    );
  }
};
