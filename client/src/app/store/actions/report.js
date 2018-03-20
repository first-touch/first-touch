import * as types from '../../constants/ActionTypes';

export const createReport = (store, report) => {
  fetch('/api/v1/reports', {
    method: 'POST',
    headers: {
      'Authorization': store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(report)
  }).then((res) => {
    if (res.status === 200) {
      store.commit(types.TOKEN_CLEAR);
    } else if (res.status === 401) {
      store.commit(types.TOKEN_CLEAR);
    } else {
      res.json().then((r) => store.commit(types.NEW_REPORT_FAILURE, r));
    }
  });
};