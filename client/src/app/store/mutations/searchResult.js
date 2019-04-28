import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE,
  ASYNC_SUCCESS,
  ASYNC_LOADING
} from '../../constants/AsyncStatus';

export const searchResult = {
  status: ASYNC_NONE,
  value: []
};

export default {
  [ActionTypes.SEARCH_RESULT_LOADING] (state) {
    state.searchResult = Object.assign({}, state.searchResult, {
      status: ASYNC_LOADING,
      value: []
    });
  },
  [ActionTypes.SEARCH_RESULT_SUCCESS] (state, payload) {
    state.searchResult = Object.assign({}, state.searchResult, {
      status: ASYNC_SUCCESS,
      value: payload
    });
  }
};
