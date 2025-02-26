import * as ActionTypes from '../../constants/ActionTypes';
import $ from 'jquery';
import { authedRequest } from 'app/services/ApiRequest';

export const createRequest = async (store, request) => {
  store.commit(ActionTypes.UPLOADING_REQUEST_LOADING);
  try {
    const res = await authedRequest(store, 'POST', '/api/v1/requests', request);

    const data = await res.json();
    if (res.status === 201) {
      store.commit(ActionTypes.UPLOADING_REQUEST_SUCCESS, data);
      return data;
    } else {
      store.commit(ActionTypes.UPLOADING_REQUEST_FAILURE, data);
    }
  } catch (err) {
    console.error('failed to create request', err);
  }
  return null;
};

export const getRequest = async (store, id) => {
  store.commit(ActionTypes.UPLOADING_REQUEST_LOADING);
  const res = await authedRequest(store, 'GET', `/api/v1/requests/${id}`);

  if (res.status >= 200 && res.status < 400) {
    const data = await res.json();
    store.commit(ActionTypes.UPLOADING_REQUEST_SUCCESS, data);
  } else if (res.status === 401) {
    store.commit(ActionTypes.TOKEN_CLEAR);
  } else {
    res.json().then(r => store.commit(ActionTypes.UPLOADING_REQUEST_FAILURE, r));
  }
};

export const getRequests = async (store, params) => {
  try {
    const userRole = store.state.user.value.role_name;
    const queryParams = $.param(params);
    const res = await authedRequest(store, 'GET', `/api/v1/${userRole}/requests?${queryParams}`);

    const data = await res.json();
    if (res.status === 200) {
      store.commit(ActionTypes.SEARCH_REQUEST_SUCCESS, data.requests);
      return data.requests;
    }
  } catch (err) {
    console.error('failed to get requests', err);
  }

  return [];
};

// TODO: This should be re-thought on where to put it
// At the moment this is being used to fetch the request bids
// of a specific user. In theory only scouts can make a bid on a request
// but this might change in the future. This is used to show the scout
// which bids have been accepted and which are still being
// analyzed (status: pending). The returned value is expected to have a
// structure with the request bids data and along with it the request itself.
export const getRequestBids = async (store, params) => {
  try {
    const userRole = store.state.user.value.role_name;
    const res = await authedRequest(store, 'GET', `/api/v1/${userRole}/request_bids?${$.param(params)}`);

    const data = await res.json();
    if (res.status === 200) {
      store.commit(ActionTypes.SEARCH_REQUEST_BIDS_SUCCESS, data.request_bids);
      return data.request_bids;
    }
  } catch (err) {
    console.error('failed to get requests', err);
    return [];
  }
};

export const updateRequest = async (store, { id, request }) => {
  store.commit(ActionTypes.UPLOADING_REQUEST_LOADING);

  try {
    const res = await authedRequest(store, 'PUT', '/api/v1/requests/' + id, request);

    const data = await res.json();
    if (res.status >= 200 && res.status < 400) {
      store.commit(ActionTypes.SEARCH_REQUEST_SUCCESS, data);
      return data;
    } else {
      store.commit(ActionTypes.UPLOADING_REQUEST_FAILURE, data);
      return false;
    }
  } catch (err) {
    console.error('Failed to update request', err);
  }
};
