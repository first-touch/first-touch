import tokenReducer, { token } from './token';
import feedReducer, { feed } from './feed';
import userReducer, { user, newUser } from './user';
import networkReducer, { network } from './network';
import inboxReducer, { inbox } from './inbox';
import messagesReducer, { messages } from './messages';
import profileReducer, { profile, teamProfile } from './profile';
import searchResultReducer, { searchResult } from './searchResult';
import noteReducer, { note } from './note';
import reportReducer, { report, searchReport, filesUpload } from './report';
import orderReducer, { order, refund } from './order';
import requestReducer, { request, searchRequest } from './request';
import bidReducer, { bid, bids } from './bid';
import stripeReducer, { stripe, stripeFtouch, stripeRequiredFields, stripeDelete, stripeJs } from './stripe';
import stripePaymentReducer, { stripePayment } from './stripePayment';
import stripeClubReducer, { stripeClubCards } from './stripeClub';

export const initialState = {
  token,
  feed,
  note,
  user,
  newUser,
  network,
  inbox,
  messages,
  profile,
  teamProfile,
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
  stripeDelete,
  stripePayment,
  stripeJs,
  stripeClubCards,
  refund
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
  noteReducer,
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
