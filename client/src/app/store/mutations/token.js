import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE,
  ASYNC_SUCCESS,
  ASYNC_LOADING,
  ASYNC_FAIL
} from '../../constants/AsyncStatus';

export const token = {
  status: ASYNC_NONE,
  value: localStorage.getItem('token'),
  clubs: null,
  err: null
};
export const clubs = JSON.parse(localStorage.getItem('club_info'));
// export const authenticating = false;

export default {
  // FIXME: Temporary token management to be updated with below methods
  [ActionTypes.TOKEN_LOADING] (state) {
    state.token = Object.assign({}, state.token, {
      status: ASYNC_LOADING,
      value: undefined,
      clubs: undefined
    });
  },
  [ActionTypes.TOKEN_FAILURE] (state, err) {
    state.token = Object.assign({}, state.token, {
      status: ASYNC_FAIL,
      value: undefined,
      clubs: undefined,
      err
    });
  },
  [ActionTypes.TOKEN_SUCCESS] (state, value) {
    state.token = Object.assign({}, state.token, {
      status: ASYNC_SUCCESS,
      value: value.auth_token,
      clubs: value.clubs_token
    });
    localStorage.setItem('auth_token', value.auth_token);
    localStorage.setItem('clubs_token', JSON.stringify(value.clubs_token));
  },
  'USER_TOKEN' (state, payload) {
    state.token = payload;
  },
  'CLUB_INFO' (state, payload) {
    state.clubs = payload;
  },
  'AUTHENTICATING' (state) {
    state.authenticating = true;
  },
  'AUTHENTICATION_COMPLETE' (state) {
    state.authenticating = false;
  },
  [ActionTypes.TOKEN_CLEAR] (state) {
    state.token = null;
    state.clubs = null;
  }
};
