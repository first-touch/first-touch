import * as ActionTypes from '../../constants/ActionTypes';
import { ASYNC_NONE, ASYNC_LOADING, ASYNC_SUCCESS } from '../../constants/AsyncStatus';

export const network = {
  status: ASYNC_NONE,
  value: null
};

export default {
  [ActionTypes.NETWORK_LOADING] (state, network) {
    state.network = Object.assign(
      {},
      state.network,
      { status: ASYNC_LOADING }
    );
  },
  [ActionTypes.NETWORK_SUCCESS] (state, network) {
    state.network = Object.assign(
      {},
      state.network,
      { status: ASYNC_SUCCESS, value: [...network.following] }
    );
  },
  [ActionTypes.NETWORK_UNFOLLOW] (state, id) {
    const idx = state.network.value.findIndex((n) => n.id === id);
    state.network = Object.assign(
      {},
      state.network,
      { value: [
        ...state.network.value.slice(0, idx),
        ...state.network.value.slice(idx + 1)
      ] }
    );
  }
};