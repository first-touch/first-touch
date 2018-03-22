import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE,
  ASYNC_LOADING,
  ASYNC_SUCCESS
} from '../../constants/AsyncStatus';

export const user = {
  status: ASYNC_NONE,
  value: null
};

export default {
  [ActionTypes.USER_LOADING] (state) {
    state.user = Object.assign({}, state.user, { status: ASYNC_LOADING });
  },
  [ActionTypes.USER_SUCCESS] (state, user) {
    state.user = Object.assign({}, state.user, {
      status: ASYNC_SUCCESS,
      value: user
    });
  }
};
