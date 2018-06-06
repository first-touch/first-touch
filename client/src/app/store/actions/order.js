import * as ActionTypes from '../../constants/ActionTypes';

export const newOrder = (store, order) => {
  store.commit(ActionTypes.ORDER_REPORT_LOADING);
  fetch('/api/v1/orders', {
    method: 'POST',
    headers: {
      Authorization: store.state.token.value,
      ClubAuthorization: store.state.token.clubs[0].token,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(order)
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.ORDER_REPORT_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.ORDER_REPORT_FAILURE, r));
    }
  });
};

export const refundOrder = (store, id) => {
  store.commit(ActionTypes.ORDER_REFUND_LOADING);
  fetch(`/api/v1/reports/refund/${id}`, {
    method: 'POST',
    headers: {
      Authorization: store.state.token.value,
      ClubAuthorization: store.state.token.clubs[0].token,
      'Content-Type': 'application/json'
    }
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.ORDER_REFUND_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.ORDER_REFUND_FAILURE, r));
    }
  });
};
