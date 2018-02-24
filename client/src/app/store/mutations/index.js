import tokenReducer, { token } from './token';
import feedReducer, { feed } from './feed';
import userReducer, { user } from './user';
import networkReducer, { network } from './network';
import inboxReducer, { inbox } from './inbox';
import messagesReducer, { messages } from './messages';
import profileReducer, { profile } from './profile';
import searchResultReducer, { searchResult } from './searchResult';
import noteReducer, { note } from './note';

export const initialState = {
  token,
  feed,
  note,
  user,
  network,
  inbox,
  messages,
  profile,
  searchResult
};

export default Object.assign(
  {},
  tokenReducer,
  feedReducer,
  userReducer,
  networkReducer,
  inboxReducer,
  messagesReducer,
  profileReducer,
  searchResultReducer,
  noteReducer
);
