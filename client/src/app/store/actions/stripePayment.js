import * as ActionTypes from '../../constants/ActionTypes';

export const StripeCardToken = (store, card) => {
  store.commit(ActionTypes.STRIPE_CARD_LOADING);
  var stripe = store.getters.stripeJs;
  stripe.createToken(card).then(function (result) {
    if (result.token) {
      store.commit(ActionTypes.STRIPE_CARD_SUCCESS, result);
    } else {
      store.commit(ActionTypes.STRIPE_CARD_FAILURE, result);
    }
  });
};

export const flushStripeCardToken = (store) => {
  store.commit(ActionTypes.FLUSH_STRIPE_CARD_TOKEN);
};
