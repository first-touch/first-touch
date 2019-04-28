import * as ActionTypes from '../../constants/ActionTypes';

const apiRequest = function(store, method, endpoint, body){
  let params = {
    method,
    headers: {
      Authorization: store ? store.state.token.value : null,
      'Content-Type': 'application/json'
    }
  }
  if (body) params.body = JSON.stringify(body);
  return fetch(endpoint, params).then((res) => {
    if (res.status === 401){
      store.commit(ActionTypes.TOKEN_CLEAR);
      throw new Error("Not authorized");
    }
    return res;
  })
}

export const createRequest = async (store, request) => {
  store.commit(ActionTypes.UPLOADING_REQUEST_LOADING);
  try {
    const res = await apiRequest(store, 'POST', '/api/v1/requests',request );

    let data = await res.json()
    if (res.status === 201) {
      store.commit(ActionTypes.UPLOADING_REQUEST_SUCCESS, data);
       return data;
    } else {
      store.commit(ActionTypes.UPLOADING_REQUEST_FAILURE, data);
    }

  } catch(err){
    console.error("failed to create request", err);
  }
  return null;
};

export const getRequest = (store, id) => {
  store.commit(ActionTypes.UPLOADING_REQUEST_LOADING);
  return fetch('/api/v1/requests/' + id, {
    method: 'GET',
    headers: {
      Authorization: store.state.token.value,
      //ClubAuthorization: store.state.token.clubs[0] ? store.state.token.clubs[0].token : null
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

export const getRequests = async (store, params) => {

  try {
    const res = await apiRequest(store, 'GET', '/api/v1/requests?' + params);

    let data = await res.json()
    if (res.status === 200) {
      store.commit(ActionTypes.SEARCH_REQUEST_SUCCESS, data.requests);
      return data.requests
    }

  } catch(err){
    console.error("failed to get requests", err);
  }

  return [];
};

export const updateRequest = async (store, { id, request }) => {
  store.commit(ActionTypes.UPLOADING_REQUEST_LOADING);

  try {
    const res = await apiRequest(store, 'PUT', '/api/v1/requests/' + id, request);

    let data = await res.json()
    if (res.status >= 200 && res.status < 400){
      store.commit(ActionTypes.SEARCH_REQUEST_SUCCESS, data);
      return data;
    } else {
        store.commit(ActionTypes.UPLOADING_REQUEST_FAILURE, data);
        return false
    }

  } catch(err){
    console.error("Failed to update request", err);
  }
};
