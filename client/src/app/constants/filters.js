import Vue from 'vue';
import moment from 'moment';

Vue.filter('moment', str => moment(str).format('MM/DD/YYYY'));
Vue.filter('railsdate', str => moment(str).format('YYYY-MM-DD'));
Vue.filter('reportId', (str, type) => {
  str = str.toString();
  while (str.length < (5 || 2)) {
    str = '0' + str;
  }
  if (type === 'player') {
    str = 'PR' + str;
  } else {
    str = 'TR' + str;
  }
  return str;
});

Vue.filter('requestId', (str, type) => {
  str = str.toString();
  while (str.length < (5 || 2)) {
    str = '0' + str;
  }
  switch (type) {
  case 'player':
    str = 'PJR' + str;
    break;
  case 'position':
    str = 'SJR' + str;
    break;
  case 'team':
    str = 'TJR' + str;
    break;
  }
  return str;
});
