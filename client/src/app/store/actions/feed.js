import * as types from 'app/constants/ActionTypes';
import PostService from '../../services/PostService';

export const postIndex = (store) => {
  store.commit(types.FEED_LOADING);
  return PostService.index().then(res => {
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

export const postCreate = (store, { postData }) => {
  return PostService.create(postData).then(res => {
    if (res.status === 201) {
      res.json().then(post => {
        store.commit(types.FEED_POSTED, post);
      });
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};
