import * as types from '../../constants/ActionTypes';

export const getUserInfo = (store, { token }) => {
  store.commit(types.USER_LOADING);
  fetch('/api/v1/user', {
    method: 'GET',
    headers: { Authorization: token }
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => {
        store.commit(types.USER_SUCCESS, r.user);
      });
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

export const updateUserInfo = (store, userInfo) => {
  fetch('/api/v1/user', {
    method: 'PUT',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      personal_profile_attributes: userInfo, // eslint-disable-line camelcase
      id: store.state.user.value.id
    })
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(types.USER_SUCCESS, r));
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

export const importUser = (store, userInfo) => {
  fetch('/api/v1/users/import', {
    method: 'POST',
    headers: {
      'Authorization': store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(userInfo)
  }).then((res) => {
    if (res.status === 200) {
      res.json().then((r) => store.commit(types.USER_IMPORT_SUCCESS, r));
    } else {
      res.json().then(console.log);
    }
  });
};
