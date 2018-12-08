import * as ActionTypes from '../../constants/ActionTypes';
// import {
//   ASYNC_NONE // ,
//   // ASYNC_SUCCESS,
//   // ASYNC_LOADING,
//   // ASYNC_FAIL
// } from '../../constants/AsyncStatus';

export const token = localStorage.getItem('token', token);

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
  [ActionTypes.TOKEN_CLEAR] (state) {
    state.token = null;
    state.club = null;
  }
};
