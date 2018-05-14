import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE,
  ASYNC_SUCCESS,
  ASYNC_LOADING,
  ASYNC_FAILURE
} from '../../constants/AsyncStatus';

import { router } from '../../../index';

export const token = {
  status: ASYNC_NONE,
  value: null,
  err: null
};

export default {
  [ActionTypes.TOKEN_LOADING] (state) {
    state.token = Object.assign({}, state.token, { status: ASYNC_LOADING });
  },
  [ActionTypes.TOKEN_FAILURE] (state, err) {
    state.token = Object.assign({}, state.token, {
      status: ASYNC_FAILURE,
      err
    });
  },
  [ActionTypes.TOKEN_SUCCESS] (state, value) {
    state.token = Object.assign({}, state.token, {
      status: ASYNC_SUCCESS,
      value
    });
    localStorage.setItem('auth_token', value);
    router.push('/');
  },
  [ActionTypes.TOKEN_CLEAR] (state) {
    state.token = { status: ASYNC_NONE, value: null, err: null };
    localStorage.removeItem('auth_token');
    router.push('/users/sign_in');
  }
};
