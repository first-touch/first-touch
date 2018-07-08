import * as types from '../../constants/ActionTypes';

export const attemptLogIn = (store, { email, password }) => {
  store.commit(types.TOKEN_LOADING);
  fetch('/api/v1/authenticate', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: `email=${email}&password=${password}`
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => {
        store.commit(types.TOKEN_SUCCESS, r.auth_token);
      });
    } else {
      res.json().then(r =>
        store.commit(types.TOKEN_FAILURE, JSON.stringify(r))
      );
    }
  });
};

export const logout = store => store.commit(types.TOKEN_CLEAR);
