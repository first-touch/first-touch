import * as ActionTypes from '../../constants/ActionTypes';

export const createRequest = (store, request) => {
  store.commit(ActionTypes.UPLOADING_REQUEST_LOADING);
  fetch('/api/v1/requests', {
    method: 'POST',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(request)
  }).then(res => {
    if (res.status === 201) {
      res.json().then(r => store.commit(ActionTypes.UPLOADING_REQUEST_SUCCESS, r));
    } else if (res.status === 401) {
      store.commit(ActionTypes.TOKEN_CLEAR);
    } else {
      res.json().then(r => store.commit(ActionTypes.UPLOADING_REQUEST_FAILURE, r));
    }
  });
};

export const getRequest = (store, id) => {
  store.commit(ActionTypes.UPLOADING_REQUEST_LOADING);
  fetch('/api/v1/requests/' + id, {
    method: 'GET',
    headers: {
      Authorization: store.state.token.value
    }
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.UPLOADING_REQUEST_SUCCESS, r));
    } else if (res.status === 401) {
      store.commit(ActionTypes.TOKEN_CLEAR);
    } else {
      res.json().then(r => store.commit(ActionTypes.UPLOADING_REQUEST_FAILURE, r));
    }
  });
};

export const getRequests = (store, params) => {
  fetch('/api/v1/requests?' + params, {
    method: 'GET',
    headers: {
      Authorization: store.state.token.value
    }
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(ActionTypes.SEARCH_REQUEST_SUCCESS, r));
    } else if (res.status === 401) {
      store.commit(ActionTypes.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

export const updateRequest = (store, { id, request }) => {
  store.commit(ActionTypes.UPLOADING_REQUEST_LOADING);
  fetch('/api/v1/requests/' + id, {
    method: 'PUT',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(request)
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.UPLOADING_REQUEST_SUCCESS, r));
    } else if (res.status === 401) {
      store.commit(ActionTypes.TOKEN_CLEAR);
    } else {
      res.json().then(r => store.commit(ActionTypes.UPLOADING_REQUEST_FAILURE, r));
    }
  });
};
