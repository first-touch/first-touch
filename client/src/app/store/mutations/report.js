import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE, ASYNC_FAIL, ASYNC_SUCCESS
} from '../../constants/AsyncStatus';

export const report = {
  status: ASYNC_NONE,
  value: null,
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
  [ActionTypes.NEW_REPORT_SUCCESS] (state, payload) {
    state.report = Object.assign(
      {},
      state.report,
      { status: ASYNC_SUCCESS, value: payload }
    );
  }
};