import * as types from '../../constants/ActionTypes';
import NetworkService from 'app/services/NetworkService';

export const getNetwork = (store, params = {}) => {
  store.commit(types.NETWORK_LOADING);
  const role = params.role;
  NetworkService.index(role).then(r => {
    store.commit(types.NETWORK_SUCCESS, r.network);
  }).catch(response => {
    console.log(response);
  });
};

export const unfollow = (store, { id }) => {
  fetch(`/api/v1/relationships/${id}`, {
    method: 'DELETE',
    headers: { Authorization: store.state.token.value }
  }).then(res => {
    if (res.status === 200) {
      store.commit(types.NETWORK_UNFOLLOW, id);
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};
