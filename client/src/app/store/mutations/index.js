import tokenReducer, { token } from './token';
import feedReducer, { feed } from './feed';
import userReducer, { user, newUser } from './user';
import networkReducer, { network } from './network';
import inboxReducer, { inbox } from './inbox';
import messagesReducer, { messages } from './messages';
import profileReducer, { profile } from './profile';
import searchResultReducer, { searchResult } from './searchResult';
import reportReducer, { report, searchReport, filesUpload } from './report';

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
  filesUpload
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
  reportReducer
);
