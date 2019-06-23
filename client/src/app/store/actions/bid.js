import * as ActionTypes from '../../constants/ActionTypes';
import RequestBidService from 'app/services/RequestBidService';
import { authedRequest } from 'app/services/ApiRequest';
import $ from 'jquery';

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

export const updateBid = async (store, { id, price, status }) => {
  store.commit(ActionTypes.BID_LOADING);
  const userRole = store.state.user.value.role_name;
  const res = await authedRequest(
    store,
    'PUT',
    `/api/v1/${userRole}/request_bids/${id}`,
    { price, status }
  );
  const data = await res.json();
  if (res.status === 200) {
    store.commit(ActionTypes.BID_SUCCESS, data);
    return data;
  } else {
    store.commit(ActionTypes.BID_FAILURE, data);
    return data;
  };
};

export const getBids = async (store, { id, params }) => {
  const userRole = store.state.user.value.role_name;
  params = {
    ...params,
    'request_id': id
  };

  const res = await authedRequest(store, 'GET', `/api/v1/${userRole}/request_bids?${$.param(params)}`);

  const data = await res.json();
  if (res.status >= 200 && res.status < 400) {
    store.commit(ActionTypes.BIDS_REQUEST_SUCCESS, data.request_bids);
    return data;
  } else {
    store.commit(ActionTypes.BIDS_REQUEST_FAILURE, data);
    return [];
  }
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
