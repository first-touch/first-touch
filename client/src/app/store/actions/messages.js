import * as types from '../../constants/ActionTypes';
import { reloadInbox } from './inbox';

export const getConversation = (store, { token, partnerId }) => {
  if (partnerId) {
    store.commit(types.CONVO_LOADING);
    fetch(`/api/v1/messages/${partnerId}`, {
      method: 'GET',
      headers: { Authorization: token }
    }).then(res => {
      if (res.status === 200) {
        res.json().then(r => store.commit(types.CONVO_SUCCESS, r));
      } else if (res.status === 401) {
        store.commit(types.TOKEN_CLEAR);
      } else {
        res.json().then(console.log);
      }
    });
  } else {
    store.commit(types.CONVO_SUCCESS);
  }
};

export const reloadConversation = (store, { token }) => {
  fetch(`/api/v1/messages/${store.state.messages.value.chat_with.id}`, {
    method: 'GET',
    headers: { Authorization: token }
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(types.CONVO_RELOAD, r));
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

export const sendMessage = (store, { content }) => {
  fetch('/api/v1/messages', {
    method: 'POST',
    headers: {
      Authorization: store.state.token,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      message_body: content, // eslint-disable-line camelcase
      recipient_id: store.state.messages.value.chat_with.id // eslint-disable-line camelcase
    })
  }).then(res => {
    if (res.status === 201) {
      reloadConversation(store, { token: store.state.token });
      reloadInbox(store);
    } else if (res.status === 403) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};
