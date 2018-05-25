import * as types from '../../constants/ActionTypes';
import { getNetwork } from './network';

export const fetchUserInfo = (store, { id }) => {
  store.commit(types.PROFILE_LOADING);
  fetch(`/api/v1/users/${id}/profile`, {
    method: 'GET',
    headers: { Authorization: store.state.token.value }
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(types.PROFILE_SUCCESS, r));
    } else if (res.status === 403) {
      this.clearToken();
    } else {
      res.json().then(console.log);
    }
  });
};

export const fetchTeamInfo = (store, { id }) => {
  store.commit(types.TEAM_LOADING);
  fetch(`/api/v1/teams/${id}`, {
    method: 'GET',
    headers: { Authorization: store.state.token.value }
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(types.TEAM_SUCCESS, r));
    } else if (res.status === 403) {
      this.clearToken();
    } else {
      res.json().then(console.log);
    }
  });
};

export const follow = (store, { id }) => {
  fetch('/api/v1/relationships', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      Authorization: store.state.token.value
    },
    body: `followed_id=${id}`
  }).then(res => {
    if (res.status === 200) {
      getNetwork(store, { token: store.state.token.value });
      store.commit(types.PROFILE_FOLLOW);
    } else if (res.status === 403) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

export const connect = (store, { id }) => {
  fetch('/api/v1/connect', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: store.state.token.value
    },
    body: JSON.stringify({ connected_to_id: id }) // eslint-disable-line camelcase
  }).then(res => {
    if (res.status === 200) {
      store.commit(types.PROFILE_CONNECT);
    } else if (res.status === 403) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};
