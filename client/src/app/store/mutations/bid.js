import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE, ASYNC_FAIL, ASYNC_SUCCESS, ASYNC_LOADING
} from '../../constants/AsyncStatus';

export const bid = {
  status: ASYNC_NONE,
  value: null,
  errors: null
};

export const bids = {
  status: ASYNC_NONE,
  value: null,
  errors: null
};

export default {
  [ActionTypes.BID_CLEAR] (state, bid) {
    state.bid = Object.assign(
      {},
      state.bid,
      { status: ASYNC_NONE, value: null, errors: null }
    );
  },
  [ActionTypes.BID_LOADING] (state, bid) {
    state.bid = Object.assign(
      {},
      state.bid,
      { status: ASYNC_LOADING, value: bid }
    );
  },
  [ActionTypes.BID_SUCCESS] (state, bid) {
    state.bid = Object.assign(
      {},
      state.bid,
      { status: ASYNC_SUCCESS, value: bid }
    );
  },
  [ActionTypes.BID_FAILURE] (state, errors) {
    state.bid = Object.assign(
      {},
      state.bid,
      { status: ASYNC_FAIL, errors: errors }
    );
  },
  [ActionTypes.BIDS_REQUEST_LOADING] (state, bids) {
    state.bids = Object.assign(
      {},
      state.bids,
      { status: ASYNC_LOADING, value: bids }
    );
  },
  [ActionTypes.BIDS_REQUEST_SUCCESS] (state, bids) {
    state.bids = Object.assign(
      {},
      state.bids,
      { status: ASYNC_SUCCESS, value: bids }
    );
  },
  [ActionTypes.BIDS_REQUEST_FAILURE] (state, errors) {
    state.bids = Object.assign(
      {},
      state.bids,
      { status: ASYNC_FAIL, errors: errors }
    );
  },
  [ActionTypes.BID_DELETE_SUCCESS] (state, bid) {
    state.bid = Object.assign(
      {},
      state.bid,
      { status: ASYNC_SUCCESS, value: bid }
    );
  },
  [ActionTypes.BID_DELETE_FAILURE] (state, errors) {
    state.bid = Object.assign(
      {},
      state.bid,
      { status: ASYNC_FAIL, errors: errors }
    );
  }
};
