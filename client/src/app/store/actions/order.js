import * as ActionTypes from '../../constants/ActionTypes';

export const newOrder = (store, order) => {
  store.commit(ActionTypes.ORDER_REPORT_LOADING);
  fetch('/api/v1/orders', {
    method: 'POST',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(order)
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(ActionTypes.ORDER_REPORT_SUCCESS, r));
    } else {
      res.json().then(r => store.commit(ActionTypes.ORDER_REPORT_FAILURE, r));
    }
  });
};
