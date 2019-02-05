import * as types from '../../constants/ActionTypes';
import UserService from 'app/services/UserService';

export const getUserInfo = (store) => {
  return new Promise((resolve, reject) => {
    store.commit(types.USER_LOADING);
    UserService.getUser().then(res => {
      store.commit(types.USER_SUCCESS, res);
      resolve(res);
    }).catch(err => {
      console.log(err);
      store.commit(types.TOKEN_CLEAR);
      reject(err);
    });
  });
};

export const updateUserInfo = (store, userInfo) => {
  console.warn('[Actions/User] Migrate to User service');
  fetch('/api/v1/user', {
    method: 'PUT',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      id: store.state.user.value.id,
      personal_profile: userInfo // eslint-disable-line camelcase
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
  console.warn('[Actions/User] Migrate to User service');
  fetch('/api/v1/users/import', {
    method: 'POST',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(userInfo)
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(types.USER_IMPORT_SUCCESS, r));
    } else {
      res.json().then(console.log);
    }
  });
};
