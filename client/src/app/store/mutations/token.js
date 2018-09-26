import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE,
  ASYNC_SUCCESS,
  ASYNC_LOADING,
  ASYNC_FAIL
} from '../../constants/AsyncStatus';

import { router } from '../../../index';

export const token = {
  status: ASYNC_NONE,
  value: null,
  clubs: null,
  err: null
};

export default {
  [ActionTypes.TOKEN_LOADING] (state) {
    state.token = Object.assign({}, state.token, { status: ASYNC_LOADING });
  },
  [ActionTypes.TOKEN_FAILURE] (state, err) {
    state.token = Object.assign({}, state.token, {
      status: ASYNC_FAIL,
      err
    });
  },
  [ActionTypes.TOKEN_SUCCESS] (state, value) {
    state.token = Object.assign({}, state.token, {
      status: ASYNC_SUCCESS,
      value: value.user,
      clubs: value.clubs
    });
    localStorage.setItem('auth_token', value);
    localStorage.setItem('club_token', JSON.stringify(value.clubs));
    router.push('/');
  },
  [ActionTypes.TOKEN_CLEAR] (state) {
    state.token = { status: ASYNC_NONE, value: null, err: null };
    localStorage.removeItem('auth_token');
    localStorage.removeItem('club_token');
    router.push('/users/sign_in');
  }
};
