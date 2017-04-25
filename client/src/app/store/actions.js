import * as types from '../constants/ActionTypes';

const makeAction = type => ({ commit }, ...args) => commit(type, ...args);

export const addTodo = makeAction(types.ADD_TODO);
export const deleteTodo = makeAction(types.DELETE_TODO);
export const editTodo = makeAction(types.EDIT_TODO);
export const completeTodo = makeAction(types.COMPLETE_TODO);
export const completeAll = makeAction(types.COMPLETE_ALL);
export const clearCompleted = makeAction(types.CLEAR_COMPLETED);

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
      res.json().then(console.log);
      res.json()
        .then((r) => store.commit(types.TOKEN_FAILURE, JSON.stringify(r)));
    }
  });
};

export const getFeed = (store, { token }) => {
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
      getUserInfo(store, { token });
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
      getNetwork(store, { token });
    }
  });
};