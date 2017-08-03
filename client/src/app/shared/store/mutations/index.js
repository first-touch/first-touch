import tokenReducer, { token } from './token';
import feedReducer, { feed } from './feed';
import userReducer, { user } from './user';
import networkReducer, { network } from './network';
import inboxReducer, { inbox } from './inbox';
import messagesReducer, { messages } from './messages';
import profileReducer, { profile } from './profile';

export const initialState = {
  token,
  feed,
  user,
  network,
  inbox,
  messages,
  profile
};

export default Object.assign({},
  tokenReducer,
  feedReducer,
  userReducer,
  networkReducer,
  inboxReducer,
  messagesReducer,
  profileReducer
);