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
    value: []
  }
};

export default {
  [ActionTypes.ADD_TODO] (state, text) {
    state.todos.unshift({
      id: state.todos.reduce((maxId, todo) => Math.max(todo.id, maxId), -1) + 1,
      completed: false,
      text
    });
  },
  [ActionTypes.DELETE_TODO] (state, id) {
    state.todos = state.todos.filter(todo => todo.id !== id);
  },
  [ActionTypes.EDIT_TODO] (state, id, text) {
    state.todos = state.todos.map(todo =>
      todo.id === id
      ? Object.assign({}, todo, { text })
      : todo
    );
  },
  [ActionTypes.COMPLETE_TODO] (state, id) {
    state.todos = state.todos.map(todo =>
      todo.id === id
      ? Object.assign({}, todo, { completed: !todo.completed })
      : todo
    );
  },
  [ActionTypes.COMPLETE_ALL] (state) {
    const areAllMarked = state.todos.every(todo => todo.completed);
    state.todos = state.todos.map(todo => Object.assign({}, todo, {
      completed: !areAllMarked
    }));
  },
  [ActionTypes.CLEAR_COMPLETED] (state) {
    state.todos = state.todos.filter(todo => todo.completed === false);
  },
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
      { status: ASYNC_SUCCESS, value: [...state.feed.value, ...posts] }
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
  }
};