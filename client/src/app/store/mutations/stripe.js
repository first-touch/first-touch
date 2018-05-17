import {
  StripePublicKey
} from 'app/constants/StripeConstant';

export const stripeJs = window.Stripe(StripePublicKey);
