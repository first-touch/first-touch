import * as types from '../../constants/ActionTypes';

export const getNetwork = (store, { token }) => {
  store.commit(types.NETWORK_LOADING);
  fetch('/api/v1/network', {
    method: 'GET',
    headers: { 'Authorization': token }
  }).then((res) => {
    if (res.status === 200) {
      res.json()
        .then((r) => { store.commit(types.NETWORK_SUCCESS, r.network); });
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

export const unfollow = (store, { id }) => {
  fetch(`/api/v1/relationships/${id}`, {
    method: 'DELETE',
    headers: { 'Authorization': store.state.token.value }
  }).then((res) => {
    if (res.status === 200) {
      store.commit(types.NETWORK_UNFOLLOW, id);
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};