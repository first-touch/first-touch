import * as types from '../../constants/ActionTypes';
import NetworkService from 'app/services/NetworkService';

export const getNetwork = (store, params = {}) => {
  store.commit(types.NETWORK_LOADING);
  NetworkService.index(params).then(r => {
    store.commit(types.NETWORK_SUCCESS, r.network);
  }).catch(response => {
    if (response.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      console.log(response);
    }
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
