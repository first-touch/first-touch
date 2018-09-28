import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE,
  ASYNC_LOADING,
  ASYNC_SUCCESS
} from '../../constants/AsyncStatus';

export const profile = {
  status: ASYNC_NONE,
  value: {}
};

export const teamProfile = {
  status: ASYNC_NONE,
  value: {}
};

export default {
  [ActionTypes.PROFILE_LOADING] (state) {
    state.profile = Object.assign({}, state.profile, { status: ASYNC_LOADING });
  },
  [ActionTypes.PROFILE_SUCCESS] (state, profile) {
    state.profile = Object.assign({}, state.profile, {
      status: ASYNC_SUCCESS,
      value: profile
    });
  },
  [ActionTypes.TEAM_LOADING] (state) {
    state.teamProfile = Object.assign({}, state.teamProfile, { status: ASYNC_LOADING });
  },
  [ActionTypes.TEAM_SUCCESS] (state, teamProfile) {
    state.teamProfile = Object.assign({}, state.teamProfile, {
      status: ASYNC_SUCCESS,
      value: teamProfile
    });
  },
  [ActionTypes.PROFILE_FOLLOW] (state) {
    state.profile.value = Object.assign({}, state.profile.value, {
      following: true
    });
  },
  [ActionTypes.PROFILE_CONNECT] (state) {
    state.profile.value = Object.assign({}, state.profile.value, {
      connection_status: 'pending' // eslint-disable-line camelcase
    });
  }
};
