import * as types from '../constants/ActionTypes';

export const attemptLogIn = (store, { email, password }) => {
  store.commit(types.TOKEN_LOADING);
  fetch('/api/v1/authenticate', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: `email=${email}&password=${password}`
  }).then((res) => {
    if (res.status === 200) {
      res.json()
        .then((r) => { store.commit(types.TOKEN_SUCCESS, r.auth_token); });
    } else {
      res.json()
        .then((r) => store.commit(types.TOKEN_FAILURE, JSON.stringify(r)));
    }
  });
};

export const clearToken = (store) => store.commit(types.TOKEN_CLEAR);

export const getInitialFeed = (store, { token }) => {
  store.commit(types.FEED_LOADING);
  fetch('/api/v1/posts', {
    method: 'GET',
    headers: { 'Authorization': token }
  }).then((res) => {
    if (res.status === 200) {
      res.json()
        .then((r) => { store.commit(types.FEED_SUCCESS, r.posts); });
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

export const succeedToPost = (store, { post }) => store.commit(types.FEED_POSTED, post);

export const getUserInfo = (store, { token }) => {
  store.commit(types.USER_LOADING);
  fetch('/api/v1/user', {
    method: 'GET',
    headers: { 'Authorization': token }
  }).then((res) => {
    if (res.status === 200) {
      res.json()
        .then((r) => { store.commit(types.USER_SUCCESS, r.user); });
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

export const updateUserInfo = (store, userInfo) => {
  console.log('update');
  fetch('/api/v1/user', {
    method: 'PUT',
    headers: {
      'Authorization': store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      'personal_profile_attributes': userInfo,
      id: store.state.user.value.id
    })
  }).then((res) => {
    if (res.status === 200) {
      res.json().then((r) => store.commit(types.USER_SUCCESS, r));
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

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

export const fetchUserInfo = (store, { id }) => {
  store.commit(types.PROFILE_LOADING);
  fetch(`/api/v1/users/${id}/profile`, {
    method: 'GET',
    headers: { 'Authorization': store.state.token.value }
  }).then((res) => {
    if (res.status === 200) {
      res.json().then((r) => store.commit(types.PROFILE_SUCCESS, r));
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
      'Authorization': store.state.token.value
    },
    body: `followed_id=${id}`
  }).then((res) => {
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

export const getConversation = (store, { token, partnerId }) => {
  store.commit(types.CONVO_LOADING);
  fetch(`/api/v1/messages/${partnerId}`, {
    method: 'GET',
    headers: { 'Authorization': token }
  }).then((res) => {
    if (res.status === 200) {
      res.json().then((r) => store.commit(types.CONVO_SUCCESS, r));
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
    headers: { 'Authorization': token }
  }).then((res) => {
    if (res.status === 200) {
      res.json().then((r) => store.commit(types.CONVO_RELOAD, r));
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
      'Authorization': store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      'message': {
        'message_body': content,
        'message_recipient_attributes': {
          'recipient_id': store.state.messages.value.chat_with.id
        }
      }
    })
  }).then((res) => {
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