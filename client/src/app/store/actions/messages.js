import * as types from '../../constants/ActionTypes';
import { reloadInbox } from './inbox';

export const getConversation = (store, { token, partnerId }) => {
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
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      message: {
        message_body: content, // eslint-disable-line camelcase
        // eslint-disable-next-line camelcase
        message_recipient_attributes: {
          recipient_id: store.state.messages.value.chat_with.id // eslint-disable-line camelcase
        }
      }
    })
  }).then(res => {
    if (res.status === 201) {
      reloadConversation(store, { token: store.state.token.value });
      reloadInbox(store);
    } else if (res.status === 403) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};
