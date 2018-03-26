import * as ActionTypes from '../../constants/ActionTypes';

export const createReport = (store, report) => {
  store.commit(ActionTypes.NEW_REPORT_LOADING);
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
      store.commit(ActionTypes.TOKEN_CLEAR);
    } else {
      res.json().then((r) => store.commit(ActionTypes.NEW_REPORT_FAILURE, r));
    }
  });
};

export const getReports = (store, { params }) => {
  fetch('/api/v1/reports', {
    method: 'GET',
    headers: {
      'Authorization': store.state.token.value
    }
  }).then((res) => {
    if (res.status === 200) {
      res.json().then((r) => store.commit(ActionTypes.SEARCH_REPORT_SUCCESS, r));
    } else if (res.status === 401) {
      store.commit(ActionTypes.TOKEN_CLEAR);
    } else {
      console.log(res);
    }
  });
};

export const getReport = (store, id) => {
  fetch('/api/v1/reports/' + id, {
    method: 'GET',
    headers: {
      'Authorization': store.state.token.value
    }
  }).then((res) => {
    if (res.status === 200) {
      res.json().then((r) => store.commit(ActionTypes.SEARCH_REPORT_SUCCESS, r));
    } else if (res.status === 401) {
      store.commit(ActionTypes.TOKEN_CLEAR);
    } else {

    }
  });
};

export const uploadFiles = (store, files) => {
  store.commit(ActionTypes.REPORT_FILES_UPLOAD_LOADING);
  fetch('/api/v1/reports/uploadfiles', {
    method: 'POST',
    headers: {
      'Authorization': store.state.token.value
    },
    body: files
  }).then((res) => {
    if (res.status === 200) {
      store.commit(ActionTypes.REPORT_FILES_UPLOAD_SUCCESS);
    } else if (res.status === 401) {
      store.commit(ActionTypes.TOKEN_CLEAR);
    } else {
      res.json().then((r) => store.commit(ActionTypes.REPORT_FILES_UPLOAD_FAILURE, r));
    }
  });
};