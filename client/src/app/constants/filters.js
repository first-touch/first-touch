import Vue from 'vue';
import moment from 'moment';
import countrydata from 'country-data';

Vue.filter('moment', str => {
  var date = moment(str);
  if (date.isValid()) {
    return date.format('Do,\ MMM YYYY');
  }
  return '';
});
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
Vue.filter('country', str => {
  var array = countrydata.countries;
  var r = str;
  if (array[str]) {
    r = array[str].name;
  }
  return r;
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

Vue.filter('vueSelect2Val', (selected) => {
  if (selected.constructor === Array) {
    var arr = [];
    for (var obj in selected) {
      arr.push(selected[obj].value);
    }
    return arr;
  } else if (selected.value) return selected.value;
  return '';
});

Vue.filter('searchInObj', (array, conditionFn) => {
  const item = array.find(conditionFn);
  return array.indexOf(item);
});

Vue.filter('currency', (str) => {
  switch (str) {
  case 'USD':
    str = '$';
    break;
  case 'SGD':
    str = 'S$';
    break;
  case 'EUR':
    str = '€';
    break;
  case 'GBP':
    str = '£';
    break;
  }
  return str;
});

Vue.filter('preferredFoot', (str) => {
  switch (str) {
  case 'R':
    str = 'Right';
    break;
  case 'L':
    str = 'Left';
    break;
  case 'B':
    str = 'Both';
    break;
  }
  return str;
});

Vue.filter('formatNumber', (str, limit) => {
  str = str.toString();
  while (str.length < limit) {
    str = '0' + str;
  }
  return str;
});
