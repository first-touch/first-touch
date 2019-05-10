// import tokenReducer, { token, authenticating, clubs } from './token';
import tokenReducer, { token, clubs } from './token';
import clubProfileReducer, { clubProfile } from './club';
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
import requestReducer, { request, searchRequest, searchRequestBids } from './request';
import bidReducer, { bid, bids } from './bid';
import stripeReducer, { stripe, stripeFtouch, stripeRequiredFields, stripeDelete, stripeJs } from './stripe';
import stripePaymentReducer, { stripePayment } from './stripePayment';
import stripeClubReducer, { stripeClubCards } from './stripeClub';

export const initialState = {
  // authenticating,
  clubs,
  token,
  clubProfile,
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
  searchRequestBids,
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
  clubProfileReducer,
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
