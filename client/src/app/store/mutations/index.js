import tokenReducer, { token } from './token';
import feedReducer, { feed } from './feed';
import userReducer, { user, newUser } from './user';
import networkReducer, { network } from './network';
import inboxReducer, { inbox } from './inbox';
import messagesReducer, { messages } from './messages';
import profileReducer, { profile } from './profile';
import searchResultReducer, { searchResult } from './searchResult';
import reportReducer, { report, searchReport, filesUpload } from './report';
import orderReducer, { order } from './order';
import requestReducer, { request, searchRequest } from './request';
import bidReducer, { bid, bids } from './bid';
import stripeReducer, { stripe, stripeFtouch, stripeJs, stripeRequiredFields, stripeDelete  } from './stripe';
import stripePaymentReducer, { stripePayment } from './stripePayment';
import stripeClubReducer, { stripeClubCards } from './stripeClub';
export const initialState = {
  token,
  feed,
  user,
  newUser,
  network,
  inbox,
  messages,
  profile,
  searchResult,
  report,
  searchReport,
  filesUpload,
  order,
  request,
  searchRequest,
  bid,
  bids,
  stripe,
  stripeFtouch,
  stripeRequiredFields,
  stripeDelete
  stripeJs,
  stripePayment,
  stripeClubCards
};

export default Object.assign({},
  tokenReducer,
  feedReducer,
  userReducer,
  networkReducer,
  inboxReducer,
  messagesReducer,
  profileReducer,
  searchResultReducer,
  reportReducer,
  reportReducer,
  reportReducer,
  orderReducer,
  requestReducer,
  requestReducer,
  bidReducer,
  stripeReducer,
  stripePaymentReducer,
  stripeClubReducer
);
