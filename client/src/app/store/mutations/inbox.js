import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE,
  ASYNC_LOADING,
  ASYNC_SUCCESS
} from '../../constants/AsyncStatus';

export const inbox = {
  status: ASYNC_NONE,
  value: null
};

export default {
  [ActionTypes.INBOX_LOADING] (state, inbox) {
    state.inbox = Object.assign({}, state.inbox, { status: ASYNC_LOADING });
  },
  [ActionTypes.INBOX_SUCCESS] (state, inbox) {
    state.inbox = Object.assign({}, state.inbox, {
      status: ASYNC_SUCCESS,
      value: inbox
    });
  },
  [ActionTypes.INBOX_RELOAD] (state, inbox) {
    state.inbox = Object.assign({}, state.inbox, { value: inbox });
  }
};
