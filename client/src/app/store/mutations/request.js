import * as ActionTypes from '../../constants/ActionTypes';
import { ASYNC_NONE, ASYNC_FAIL, ASYNC_SUCCESS, ASYNC_LOADING } from '../../constants/AsyncStatus';

export const request = {
  status: ASYNC_NONE,
  value: null,
  errors: null
};

export const searchRequest = {
  status: ASYNC_NONE,
  value: null,
  errors: null
};

export const searchRequestBids = {
  status: ASYNC_NONE,
  value: null,
  errors: null
};

export default {
  [ActionTypes.UPLOADING_REQUEST_FAILURE] (state, errors) {
    state.request = Object.assign({}, state.request, {
      status: ASYNC_FAIL,
      errors: errors
    });
  },
  [ActionTypes.UPLOADING_REQUEST_LOADING] (state, errors) {
    state.request = Object.assign({}, state.request, {
      status: ASYNC_LOADING
    });
  },
  [ActionTypes.UPLOADING_REQUEST_SUCCESS] (state, payload) {
    state.request = Object.assign({}, state.request, {
      status: ASYNC_SUCCESS,
      value: payload
    });
  },
  [ActionTypes.SEARCH_REQUEST_FAILURE] (state, errors) {
    state.searchRequest = Object.assign({}, state.searchRequest, {
      status: ASYNC_FAIL,
      errors: errors
    });
  },
  [ActionTypes.SEARCH_REQUEST_LOADING] (state, errors) {
    state.searchRequest = Object.assign({}, state.searchRequest, {
      status: ASYNC_LOADING
    });
  },
  [ActionTypes.SEARCH_REQUEST_SUCCESS] (state, payload) {
    state.searchRequest = Object.assign({}, state.searchRequest, {
      status: ASYNC_SUCCESS,
      value: payload
    });
  },
  [ActionTypes.SEARCH_REQUEST_BIDS_FAILURE] (state, errors) {
    state.searchRequestBids = Object.assign({}, state.searchRequestBids, {
      status: ASYNC_FAIL,
      errors: errors
    });
  },
  [ActionTypes.SEARCH_REQUEST_BIDS_LOADING] (state, errors) {
    state.searchRequestBids = Object.assign({}, state.searchRequestBids, {
      status: ASYNC_LOADING
    });
  },
  [ActionTypes.SEARCH_REQUEST_BIDS_SUCCESS] (state, payload) {
    state.searchRequestBids = Object.assign({}, state.searchRequestBids, {
      status: ASYNC_SUCCESS,
      value: payload
    });
  }
};
