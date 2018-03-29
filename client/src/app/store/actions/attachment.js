import downloadjs from 'downloadjs';
import * as ActionTypes from '../../constants/ActionTypes';

export const getAttachment = (store, { id, filename }) => {
  fetch('/api/v1/reports/attachments/download/' + id, {
    method: 'GET',
    headers: {
      Authorization: store.state.token.value
    }
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
