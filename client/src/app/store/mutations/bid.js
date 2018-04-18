import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE, ASYNC_FAIL, ASYNC_SUCCESS, ASYNC_LOADING
} from '../../constants/AsyncStatus';

export const bid = {
  status: ASYNC_NONE,
  value: null,
  errors: null
};

export default {
  [ActionTypes.BIDS_REQUEST_LOADING] (state, errors) {
    state.order = Object.assign(
      {},
      state.bid,
      { status: ASYNC_LOADING, errors: errors }
    );
  },
  [ActionTypes.BIDS_REQUEST_SUCCESS] (state, errors) {
    state.bid = Object.assign(
      {},
      state.bid,
      { status: ASYNC_SUCCESS, errors: errors }
    );
  },
  [ActionTypes.BIDS_REQUEST_FAILURE] (state, errors) {
    state.bid = Object.assign(
      {},
      state.bid,
      { status: ASYNC_FAIL, errors: errors }
    );
  }
};
