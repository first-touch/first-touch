import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE, ASYNC_FAIL, ASYNC_SUCCESS, ASYNC_LOADING
} from '../../constants/AsyncStatus';

export const order = {
  status: ASYNC_NONE,
  value: null,
  errors: null
};

export default {
  [ActionTypes.ORDER_REPORT_LOADING] (state, errors) {
    state.order = Object.assign(
      {},
      state.order,
      { status: ASYNC_LOADING, errors: errors }
    );
  },
  [ActionTypes.ORDER_REPORT_SUCCESS] (state, errors) {
    state.order = Object.assign(
      {},
      state.order,
      { status: ASYNC_SUCCESS, errors: errors }
    );
  },
  [ActionTypes.ORDER_REPORT_FAILURE] (state, errors) {
    state.order = Object.assign(
      {},
      state.order,
      { status: ASYNC_FAIL, errors: errors }
    );
  }
};
