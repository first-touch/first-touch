import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE // ,
  // ASYNC_SUCCESS,
  // ASYNC_LOADING,
  // ASYNC_FAIL
} from '../../constants/AsyncStatus';

export const token = {
  status: ASYNC_NONE,
  value: null,
  clubs: null,
  err: null
};

export default {
  'USER_TOKEN' (state, payload) {
    state.token = payload;
  },
  'CLUB_INFO' (state, payload) {
    state.club = payload;
  },
  'AUTHENTICATING' (state) {
    state.authenticating = true;
  },
  'AUTHENTICATION_COMPLETE' (state) {
    state.authenticating = false;
  },
  // [ActionTypes.TOKEN_LOADING] (state) {
  //   state.token = Object.assign({}, state.token, { status: ASYNC_LOADING });
  // },
  // [ActionTypes.TOKEN_FAILURE] (state, err) {
  //   state.token = Object.assign({}, state.token, {
  //     status: ASYNC_FAIL,
  //     err
  //   });
  // },
  // [ActionTypes.TOKEN_SUCCESS] (state, value) {
  //   state.token = Object.assign({}, state.token, {
  //     status: ASYNC_SUCCESS,
  //     value: value.auth_token,
  //     clubs: value.clubs_token
  //   });
  // },
  [ActionTypes.TOKEN_CLEAR] (state) {
    state.token = { status: ASYNC_NONE, value: null, err: null };
  }
};
