import * as ActionTypes from '../../constants/ActionTypes';
import RequestBidService from 'app/services/RequestBidService';
import { authedRequest } from 'app/services/ApiRequest';

export const clearBid = store => store.commit(ActionTypes.BID_CLEAR);
export const createBid = (store, bid) => {
  return new Promise((resolve, reject) => {
    store.commit(ActionTypes.BID_LOADING);
    RequestBidService.create(bid).then(res => {
      store.commit(ActionTypes.BID_SUCCESS, res);
      resolve(res);
    }).catch(err => {
      console.log(err);
      store.commit(ActionTypes.BID_FAILURE, err);
      reject(err);
    });
  });
};

export const updateBid = async (store, { requestId, id, price }) => {
  store.commit(ActionTypes.BID_LOADING);
  const userRole = store.state.user.value.role_name;
  const res = await authedRequest(store, 'PUT', `/api/v1/${userRole}/request_bids/${id}`, { price });
  const data = await res.json();
  if (res.status === 200) {
    store.commit(ActionTypes.BID_SUCCESS, data);
    return data;
  } else {
    store.commit(ActionTypes.BID_FAILURE, data);
    return data;
  };
};

export const getBids = (store, { id, params }) => {
  fetch(`/api/v1/requests/bids/${id}?${params}`, {
    method: 'GET',
    headers: {
      Authorization: store.state.token.value
      // ClubAuthorization: store.state.token.clubs[0] ? store.state.token.clubs[0].token : null
    }
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.BIDS_REQUEST_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.BIDS_REQUEST_FAILURE, r));
    }
  });
};

export const acceptBid = (store, { id, params }) => {
  store.commit(ActionTypes.BID_LOADING);
  fetch(`/api/v1/requests/bids/${id}`, {
    method: 'POST',
    headers: {
      Authorization: store.state.token.value,
      // ClubAuthorization: store.state.token.clubs[0] ? store.state.token.clubs[0].token : null,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(params)
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(ActionTypes.BID_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.BID_FAILURE, r));
    }
  });
};

export const cancelBid = (store, { id, params }) => {
  store.commit(ActionTypes.BID_LOADING);
  fetch(`/api/v1/bids/${id}`, {
    method: 'DELETE',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(params)
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(ActionTypes.BID_DELETE_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.BID_DELETE_FAILURE, r));
    }
  });
};
