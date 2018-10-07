import downloadjs from 'downloadjs';
import * as ActionTypes from 'app/constants/ActionTypes';

export const getAttachment = (store, { url, filename }) => {
  fetch(url, {
    method: 'GET'
  })
    .then(res => {
      if (res.status === 200) {
        return res.blob();
      } else if (res.status === 401) {
        store.commit(ActionTypes.TOKEN_CLEAR);
      } else {
        console.log(res);
      }
    })
    .then(blob => {
      downloadjs(blob, filename);
    });
};
