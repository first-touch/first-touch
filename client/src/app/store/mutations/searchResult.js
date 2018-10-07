import * as ActionTypes from 'app/constants/ActionTypes';
import {
  ASYNC_NONE,
  ASYNC_SUCCESS,
  ASYNC_LOADING
} from 'app/constants/AsyncStatus';

export const searchResult = {
  status: ASYNC_NONE,
  value: []
};

export default {
  [ActionTypes.SEARCH_RESULT_LOADING] (state) {
    state.searchResult = Object.assign({}, state.searchResult, {
      status: ASYNC_LOADING
    });
  },
  [ActionTypes.SEARCH_RESULT_SUCCESS] (state, payload) {
    state.searchResult = Object.assign({}, state.searchResult, {
      status: ASYNC_SUCCESS,
      value: payload
    });
  },
  [ActionTypes.SEARCH_RESULT_FLUSH] (state) {
    state.searchResult = Object.assign({}, state.searchResult, {
      status: ASYNC_NONE,
      value: []
    });
  }
};
