import * as ActionTypes from '../../constants/ActionTypes';

export const createReport = (store, report) => {
  fetch('/api/v1/reports', {
    method: 'POST',
    headers: {
      'Authorization': store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(report)
  }).then((res) => {
    if (res.status === 201) {
      res.json().then((r) => store.commit(ActionTypes.NEW_REPORT_SUCCESS, r));
    } else if (res.status === 401) {
      console.log('no rights');
    } else {
      res.json().then((r) => store.commit(ActionTypes.NEW_REPORT_FAILURE, r));
    }
  });
};

export const uploadFiles = (store, files) => {
  console.log(files);
  fetch('/api/v1/reports/uploadfiles', {
    method: 'POST',
    headers: {
      'Authorization': store.state.token.value
    },
    body: files
  }).then((res) => {
    if (res.status === 200) {
      res.json().then((r) => store.commit(ActionTypes.NEW_REPORT_SUCCESS, r));
    } else if (res.status === 401) {
      console.log(res);
    } else {
      res.json().then((r) => store.commit(ActionTypes.REPORT_FILE_FAILURE, r));
    }
  });
};