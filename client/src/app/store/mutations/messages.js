import * as ActionTypes from 'app/constants/ActionTypes';
import {
  ASYNC_NONE,
  ASYNC_LOADING,
  ASYNC_SUCCESS
} from 'app/constants/AsyncStatus';

export const messages = {
  status: ASYNC_NONE,
  value: {}
};

export default {
  [ActionTypes.CONVO_LOADING] (state) {
    state.messages = Object.assign({}, state.messages, {
      status: ASYNC_LOADING
    });
  },
  [ActionTypes.CONVO_SUCCESS] (state, messages) {
    state.messages = Object.assign({}, state.messages, {
      status: ASYNC_SUCCESS,
      value: messages
    });
  },
  [ActionTypes.CONVO_RELOAD] (state, messages) {
    state.messages = Object.assign({}, state.messages, { value: messages });
  }
};
