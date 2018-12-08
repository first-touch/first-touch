import * as types from '../../constants/ActionTypes';
import AuthenticateService from 'app/services/AuthenticateService';

export const attemptLogIn = (store, { email, password }) => {
  store.commit('AUTHENTICATING');
  return AuthenticateService.login({ email: email, password: password }).then(res => {
    const userToken = res.auth_token;
    const clubInfo = res.clubs_token;
    store.commit('USER_TOKEN', userToken);
    localStorage.setItem('token', userToken);
    store.commit('CLUB_INFO', clubInfo);
    store.commit('AUTHENTICATION_COMPLETE');
    return Promise.resolve(res);
  }).catch(err => {
    localStorage.removeItem('token');
    store.commit(types.TOKEN_CLEAR);
    return Promise.reject(err);
  });
};

export const logout = (store) => {
  localStorage.removeItem('token');
  store.commit(types.TOKEN_CLEAR);
};
