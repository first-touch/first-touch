import * as ActionTypes from '../../constants/ActionTypes';
import RequestBidService from 'app/services/RequestBidService';

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

export const updateBid = (store, { requestId, id, price }) => {
  store.commit(ActionTypes.BID_LOADING);
  return fetch('/api/v1/bids/' + id, {
    method: 'PUT',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ requestId, price })
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      return res.json().then(r => store.commit(ActionTypes.BID_SUCCESS, r));
    } else {
      return res.json().then(r => store.commit(ActionTypes.BID_FAILURE, r));
    }
  });
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
