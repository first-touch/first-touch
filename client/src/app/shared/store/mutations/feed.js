import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE, ASYNC_SUCCESS, ASYNC_LOADING
} from '../../constants/AsyncStatus';

export const feed = {
  status: ASYNC_NONE,
  value: []
};

export default {
  [ActionTypes.FEED_LOADING] (state) {
    state.feed = Object.assign(
      {},
      state.feed,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.FEED_SUCCESS] (state, posts) {
    state.feed = Object.assign(
      {},
      state.feed,
      { status: ASYNC_SUCCESS, value: [...posts] }
    );
  },
  [ActionTypes.FEED_POSTED] (state, post) {
    state.feed = Object.assign(
      {},
      state.feed,
      { value: [post, ...state.feed.value] }
    );
  }
};