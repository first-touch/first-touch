import * as ActionTypes from '../../constants/ActionTypes';
import { ASYNC_NONE, ASYNC_LOADING, ASYNC_SUCCESS } from '../../constants/AsyncStatus';

export const profile = {
  status: ASYNC_NONE,
  value: {}
};

export default {
  [ActionTypes.PROFILE_LOADING] (state) {
    state.profile = Object.assign(
      {},
      state.profile,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.PROFILE_SUCCESS] (state, profile) {
    state.profile = Object.assign(
      {},
      state.profile,
      { status: ASYNC_SUCCESS, value: profile }
    );
  },
  [ActionTypes.PROFILE_FOLLOW] (state) {
    state.profile.value = Object.assign(
      {},
      state.profile.value,
      { following: true }
    );
  },
  [ActionTypes.PROFILE_CONNECT] (state) {
    state.profile.value = Object.assign(
      {},
      state.profile.value,
      { 'connection_status': 'pending' }
    );
  }
};