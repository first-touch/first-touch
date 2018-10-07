import * as types from 'app/constants/ActionTypes';

export const getNotes = (store, { token }) => {
  store.commit(types.NOTE_LOADING);
  fetch('/api/v1/notes', {
    method: 'GET',
    headers: { Authorization: token }
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => {
        store.commit(types.NOTES_SUCCESS, r.notes);
      });
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

export const getNote = (store, { token, id }) => {
  store.commit(types.NOTE_LOADING);
  fetch(`/api/v1/notes/${id}`, {
    method: 'GET',
    headers: { Authorization: token }
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => {
        store.commit(types.NOTE_SUCCESS, r);
      });
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

export const getNotesByTag = (store, { token, tag }) => {
  store.commit(types.NOTE_LOADING);
  fetch(`/api/v1/notes/tag/${tag}`, {
    method: 'GET',
    headers: { Authorization: token }
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => {
        store.commit(types.NOTES_SUCCESS, r.notes);
      });
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};
