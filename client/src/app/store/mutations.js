import * as ActionTypes from '../constants/ActionTypes';
import { ASYNC_NONE, ASYNC_LOADING, ASYNC_FAILURE, ASYNC_SUCCESS } from '../constants/AsyncStatus';

export const initialState = {
  todos: [
    {
      text: 'Use Redux',
      completed: false,
      id: 0
    }
  ],
  token: {
    status: ASYNC_NONE,
    value: null,
    err: null
  },
  feed: {
    status: ASYNC_NONE,
    value: []
  },
  user: {
    status: ASYNC_NONE,
    value: null
  },
  network: {
    status: ASYNC_NONE,
    value: null
  },
  inbox: {
    status: ASYNC_NONE,
    value: null
  },
  messages: {
    status: ASYNC_NONE,
    value: {}
  }
};

export default {
  [ActionTypes.TOKEN_LOADING] (state) {
    state.token = Object.assign(
      {},
      state.token,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.TOKEN_FAILURE] (state, err) {
    state.token = Object.assign(
      {},
      state.token,
      { status: ASYNC_FAILURE, err }
    );
  },
  [ActionTypes.TOKEN_SUCCESS] (state, value) {
    state.token = Object.assign(
      {},
      state.token,
      { status: ASYNC_SUCCESS, value }
    );
    localStorage.setItem('auth_token', value);
    window.location = '/';
  },
  [ActionTypes.TOKEN_CLEAR] (state) {
    state.token = { status: ASYNC_NONE, value: null, err: null };
    localStorage.removeItem('auth_token');
    window.location = '/users/sign_in';
  },
  [ActionTypes.FEED_LOADING] (state) {
    state.feed = Object.assign(
      {},
      state.feed,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.FEED_SUCCESS] (state, posts) {
    state.feed = Object.assign(
      {},
      state.feed,
      { status: ASYNC_SUCCESS, value: [...posts] }
    );
  },
  [ActionTypes.USER_LOADING] (state) {
    state.user = Object.assign(
      {},
      state.user,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.USER_SUCCESS] (state, user) {
    state.user = Object.assign(
      {},
      state.user,
      { status: ASYNC_SUCCESS, value: user }
    );
  },
  [ActionTypes.NETWORK_LOADING] (state, network) {
    state.network = Object.assign(
      {},
      state.network,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.NETWORK_SUCCESS] (state, network) {
    state.network = Object.assign(
      {},
      state.network,
      { status: ASYNC_SUCCESS, value: [...network.following] }
    );
  },
  [ActionTypes.NETWORK_UNFOLLOW] (state, id) {
    const idx = state.network.value.findIndex((n) => n.id === id);
    state.network = Object.assign(
      {},
      state.network,
      { value: [
        ...state.network.value.slice(0, idx),
        ...state.network.value.slice(idx + 1)
      ] }
    );
  },
  [ActionTypes.INBOX_LOADING] (state, inbox) {
    state.inbox = Object.assign(
      {},
      state.inbox,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.INBOX_SUCCESS] (state, inbox) {
    state.inbox = Object.assign(
      {},
      state.inbox,
      { status: ASYNC_SUCCESS, value: inbox }
    );
  },
  [ActionTypes.INBOX_RELOAD] (state, inbox) {
    state.inbox = Object.assign(
      {},
      state.inbox,
      { value: inbox }
    );
  },
  [ActionTypes.CONVO_LOADING] (state) {
    state.messages = Object.assign(
      {},
      state.messages,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.CONVO_SUCCESS] (state, messages) {
    state.messages = Object.assign(
      {},
      state.messages,
      { status: ASYNC_SUCCESS, value: messages }
    );
  },
  [ActionTypes.CONVO_RELOAD] (state, messages) {
    state.messages = Object.assign(
      {},
      state.messages,
      { value: messages }
    );
  }
};