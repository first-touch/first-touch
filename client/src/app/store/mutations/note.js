import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE, ASYNC_SUCCESS, ASYNC_LOADING
} from '../../constants/AsyncStatus';

export const note = {
  status: ASYNC_NONE,
  value: []
};

export default {
  [ActionTypes.NOTE_LOADING] (state) {
    state.note = Object.assign(
      {},
      state.note,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.NOTE_SUCCESS] (state, notes) {
    state.note = Object.assign(
      {},
      state.note,
      { status: ASYNC_SUCCESS, value: [...notes] }
    );
  }
};