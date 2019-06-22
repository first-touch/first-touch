import * as ActionTypes from '../constants/ActionTypes';

export const authedRequest = function (store, method, endpoint, body) {
  const params = {
    method,
    headers: {
      Authorization: store ? store.state.token.value : null,
      'Content-Type': 'application/json'
    }
  };

  if (body) params.body = JSON.stringify(body);
  return fetch(endpoint, params).then((res) => {
    if (res.status === 401) {
      store.commit(ActionTypes.TOKEN_CLEAR);
      throw new Error('Not authorized');
    }
    return res;
  });
};
