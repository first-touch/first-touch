import * as types from '../../constants/ActionTypes';

export const getInitialFeed = (store, { token }) => {
  store.commit(types.FEED_LOADING);
  fetch('/api/v1/users/posts', {
    method: 'GET',
    headers: { Authorization: token }
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => {
        store.commit(types.FEED_SUCCESS, r.posts);
      });
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

export const succeedToPost = (store, { post }) =>
  store.commit(types.FEED_POSTED, post);
