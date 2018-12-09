import ClubService from 'app/services/ClubService';

export const getClubProfile = (store, clubId) => {
  return new Promise((resolve, reject) => {
    store.commit('CLUB_LOADING');
    return ClubService.show(clubId).then(res => {
      console.log(res);
      store.commit('CLUB_LOAD_SUCCESS', res);
      resolve(res);
    }).catch(err => {
      console.log(err);
      store.commit('CLUB_LOAD_ERROR', err);
      reject(err);
    });
  });
};
