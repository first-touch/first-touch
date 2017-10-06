import * as types from '../../constants/ActionTypes';

export const getInbox = (store, { token }) => {
  store.commit(types.INBOX_LOADING);
  fetch('/api/v1/messages', {
    method: 'GET',
    headers: { 'Authorization': token }
  }).then((res) => {
    if (res.status === 200) {
      res.json().then(
        (r) => {
          store.commit(types.INBOX_SUCCESS, r.inbox);
        }
      );
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

export const reloadInbox = (store) => {
  fetch('/api/v1/messages', {
    method: 'GET',
    headers: { 'Authorization': store.state.token.value }
  }).then((res) => {
    if (res.status === 200) {
      res.json().then((r) => store.commit(types.INBOX_RELOAD, r.inbox));
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};