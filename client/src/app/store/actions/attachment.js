import downloadjs from 'downloadjs';

export const getAttachment = (store, { id, filename }) => {
  console.log(id);
  fetch('/api/v1/reports/attachments/download/' + id, {
    method: 'GET',
    headers: {
      'Authorization': store.state.token.value
    }
  }).then((res) => {
    if (res.status === 200) {
      return res.blob();
    } else if (res.status === 401) {
      console.log('no rights');
    } else {
      console.log(res);
    }
  }).then((blob) => {
    downloadjs(blob, filename);
  });
};