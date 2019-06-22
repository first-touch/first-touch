import * as ActionTypes from '../../constants/ActionTypes';
import { authedRequest } from 'app/services/ApiRequest';

export const createReport = async (store, report) => {
  store.commit(ActionTypes.UPLOADING_REPORT_LOADING);
  const userRole = store.state.user.value.role_name;
  const res = await authedRequest(store, 'POST', `/api/v1/${userRole}/reports`, report);
  const data = await res.json();
  if (res.status === 201) {
    store.commit(ActionTypes.UPLOADING_REPORT_SUCCESS, data);
  } else {
    store.commit(ActionTypes.UPLOADING_REPORT_FAILURE, data);
  }
};

export const getReport = async (store, id) => {
  const userRole = store.state.user.value.role_name;
  const res = await authedRequest(store, 'GET', `/api/v1/${userRole}/reports/${id}`);
  const data = await res.json();
  if (res.status === 200) {
    store.commit(ActionTypes.UPLOADING_REPORT_SUCCESS, data);
  } else {
    store.commit(ActionTypes.UPLOADING_REPORT_FAILURE, data);
  }
};

export const getReports = async (store, params) => {
  const userRole = store.state.user.value.role_name;
  const res = await authedRequest(store, 'GET', `/api/v1/${userRole}/reports?${params}`);
  const data = await res.json();
  if (res.status === 200) {
    store.commit(ActionTypes.SEARCH_REPORT_SUCCESS, data);
  } else {
    store.commit(ActionTypes.SEARCH_REPORT_FAILURE, data);
  };
};

export const updateReport = (store, { report, id }) => {
  store.commit(ActionTypes.UPLOADING_REPORT_LOADING);
  fetch('/api/v1/reports/' + id, {
    method: 'PUT',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(report)
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(ActionTypes.UPLOADING_REPORT_SUCCESS, r));
    } else if (res.status === 401) {
      store.commit(ActionTypes.TOKEN_CLEAR);
    } else {
      store.commit(ActionTypes.UPLOADING_REPORT_FAILURE, res);
    }
  });
};

export const uploadFiles = (store, files) => {
  store.commit(ActionTypes.REPORT_FILES_UPLOAD_LOADING);
  fetch('/api/v1/uploadfiles', {
    method: 'POST',
    headers: {
      Authorization: store.state.token.value
    },
    body: files
  }).then(res => {
    if (res.status === 200) {
      store.commit(ActionTypes.REPORT_FILES_UPLOAD_SUCCESS);
    } else if (res.status === 401) {
      store.commit(ActionTypes.TOKEN_CLEAR);
    } else {
      store.commit(ActionTypes.REPORT_FILES_UPLOAD_FAILURE, res);
    }
  });
};
