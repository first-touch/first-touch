import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE, ASYNC_FAIL, ASYNC_SUCCESS, ASYNC_LOADING
} from '../../constants/AsyncStatus';

export const report = {
  status: ASYNC_NONE,
  value: null,
  errors: null
};

export const searchReport = {
  status: ASYNC_NONE,
  value: {},
  errors: null
};

export const filesUpload = {
  status: ASYNC_NONE,
  value: {},
  errors: null
};

export default {
  [ActionTypes.NEW_REPORT_FAILURE] (state, errors) {
    state.report = Object.assign(
      {},
      state.report,
      { status: ASYNC_FAIL, errors: errors }
    );
  },
  [ActionTypes.NEW_REPORT_LOADING] (state, errors) {
    state.report = Object.assign(
      {},
      state.report,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.NEW_REPORT_SUCCESS] (state, payload) {
    state.report = Object.assign(
      {},
      state.report,
      { status: ASYNC_SUCCESS, value: payload }
    );
  },
  [ActionTypes.SEARCH_REPORT_SUCCESS] (state, payload) {
    state.searchReport = Object.assign(
      {},
      state.searchReport,
      { status: ASYNC_SUCCESS, value: payload }
    );
  },
  [ActionTypes.SEARCH_REPORT_LOADING] (state) {
    state.searchReport = Object.assign(
      {},
      state.searchReport,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.REPORT_FILES_UPLOAD_SUCCESS] (state) {
    state.filesUpload = Object.assign(
      {},
      state.filesUpload,
      { status: ASYNC_SUCCESS }
    );
  },
  [ActionTypes.REPORT_FILES_UPLOAD_FAILURE] (state, errors) {
    state.filesUpload = Object.assign(
      {},
      state.filesUpload,
      { status: ASYNC_FAIL, errors: errors }
    );
  },
  [ActionTypes.REPORT_FILES_UPLOAD_LOADING] (state) {
    state.filesUpload = Object.assign(
      {},
      state.filesUpload,
      { status: ASYNC_LOADING }
    );
  }
};