import * as ActionTypes from '../../constants/ActionTypes';
import {
  ASYNC_NONE,
  ASYNC_SUCCESS,
  ASYNC_FAIL,
  ASYNC_LOADING
} from '../../constants/AsyncStatus';

export const stripeClubCards = {
  status: ASYNC_NONE,
  value: []
};
export const stripeClubCard = {
  status: ASYNC_NONE,
  value: []
};
export default {
  [ActionTypes.GET_CLUB_STRIPE_ACCOUNT_LOADING] (state) {
    state.stripeClubCards = Object.assign({}, state.stripeClubCards, {
      status: ASYNC_LOADING
    });
  },
  [ActionTypes.GET_CLUB_STRIPE_ACCOUNT_SUCCESS] (state, payload) {
    state.stripeClubCards = Object.assign({}, state.stripeClubCards, {
      status: ASYNC_SUCCESS,
      value: payload
    });
  },
  [ActionTypes.GET_CLUB_STRIPE_ACCOUNT_FAILURE] (state, errors) {
    state.stripeClubCards = Object.assign({}, state.stripeClubCards, {
      status: ASYNC_FAIL,
      errors: errors
    });
  },
  [ActionTypes.CREATE_CLUB_STRIPE_ACCOUNT_LOADING] (state) {
    state.stripeClubCards = Object.assign({}, state.stripeClubCard, {
      status: ASYNC_LOADING
    });
  },
  [ActionTypes.CREATE_CLUB_STRIPE_ACCOUNT_SUCCESS] (state, payload) {
    state.stripeClubCards = Object.assign({}, state.stripeClubCard, {
      status: ASYNC_SUCCESS,
      value: payload
    });
  },
  [ActionTypes.CREATE_CLUB_STRIPE_ACCOUNT_FAILURE] (state, errors) {
    state.stripeClubCards = Object.assign({}, state.stripeClubCard, {
      status: ASYNC_FAIL,
      errors: errors
    });
  },
  [ActionTypes.DELETE_CLUB_STRIPE_CARD_LOADING] (state) {
    state.stripeClubCards = Object.assign({}, state.stripeClubCards, {
      status: ASYNC_LOADING
    });
  },
  [ActionTypes.DELETE_CLUB_STRIPE_CARD_SUCCESS] (state, payload) {
    state.stripeClubCards = Object.assign({}, state.stripeClubCards, {
      status: ASYNC_SUCCESS,
      value: payload
    });
  },
  [ActionTypes.DELETE_CLUB_STRIPE_CARD_FAILURE] (state, errors) {
    state.stripeClubCards = Object.assign({}, state.stripeClubCards, {
      status: ASYNC_FAIL,
      errors: errors
    });
  }
};
