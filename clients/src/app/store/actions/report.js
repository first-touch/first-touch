import * as ActionTypes from '../../constants/ActionTypes';

export const createReport = (store, report) => {
  store.commit(ActionTypes.UPLOADING_REPORT_LOADING);
  fetch('/api/v1/reports', {
    method: 'POST',
    headers: {
      Authorization: store.state.token.value,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(report)
  }).then(res => {
    if (res.status >= 200 && res.status < 400) {
      res.json().then(r => store.commit(ActionTypes.UPLOADING_REPORT_SUCCESS, r));
    } else if (res.status === 401) {
      store.commit(ActionTypes.TOKEN_CLEAR);
    } else {
      res.json().then(r => store.commit(ActionTypes.UPLOADING_REPORT_FAILURE, r));
    }
  });
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

export const getReports = (store, params) => {
  fetch('/api/v1/reports?' + params, {
    method: 'GET',
    headers: {
      Authorization: store.state.token.value,
      ClubAuthorization: store.state.token.clubs[0] ? store.state.token.clubs[0].token : null
    }
  }).then(res => {
    if (res.status === 200) {
      res.json().then(r => store.commit(ActionTypes.SEARCH_REPORT_SUCCESS, r));
    } else if (res.status === 401) {
      store.commit(ActionTypes.TOKEN_CLEAR);
    } else {
      res.json().then(console.log);
    }
  });
};

export const getReport = (store, id) => {
  fetch('/api/v1/reports/' + id, {
    method: 'GET',
    headers: {
      Authorization: store.state.token.value,
      ClubAuthorization: store.state.token.clubs[0] ? store.state.token.clubs[0].token : null
    }
  })
    .then(res => {
      if (res.status === 200) {
        res.json().then(r => store.commit(ActionTypes.UPLOADING_REPORT_SUCCESS, r));
      } else if (res.status === 401) {
        store.commit(ActionTypes.TOKEN_CLEAR);
      } else {
        res.json().then(r => store.commit(ActionTypes.UPLOADING_REPORT_FAILURE, r));
      }
    })
    .catch(function (error) {
      store.commit(ActionTypes.UPLOADING_REPORT_FAILURE, error);
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
