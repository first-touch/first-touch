import * as ActionTypes from '../../constants/ActionTypes';

export const createBid = (store, bids) => {
  store.commit(ActionTypes.BIDS_REQUEST_LOADING);
  fetch('/api/v1/bids', {
    method: 'POST',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(bids)
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(ActionTypes.BIDS_REQUEST_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.BIDS_REQUEST_FAILURE, r));
    }
  });
};
