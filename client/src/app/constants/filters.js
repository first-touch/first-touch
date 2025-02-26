import Vue from 'vue';
import Moment from 'moment';
import countrydata from 'country-data';

Vue.filter('moment', str => {
  var date = Moment(str);
  if (date.isValid()) {
    return date.format('DD-MMM-YYYY').toUpperCase();
  }
  return '';
});

Vue.filter('age', str => {
  var date = Moment(str);
  if (date.isValid()) {
    return Moment().diff(date, 'years');
  }
  return '';
});

Vue.filter('formatDate', (date, format) => {
  var dateMoment = Moment(date);
  if (dateMoment.isValid()) {
    return dateMoment.format(format);
  }
  return '';
});

Vue.filter('timeDiff', (startDate, endDate) => {
  const start = new Moment(startDate);
  const end = new Moment(endDate);

  const years = end.diff(start, 'years');
  const months = end.diff(start, 'months');

  const mStr = `${months}mo` + (months > 1 ? 's' : '');
  const yStr = `${years}yr` + (years > 1 ? 's' : '');
  if (years > 0) {
    return `${yStr} ${mStr}`;
  } else {
    return `${mStr}`;
  }
});

Vue.filter('railsdate', str => {
  if (str == null) {
    return '';
  }
  var date = Moment(str);
  if (date.isValid()) {
    return date.format('YYYY-MM-DD');
  }
  return '';
});
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

Vue.filter('twoChars', (str) => {
  var arr = str.split(' ');
  if (arr.length > 1) {
    return arr[0][0].toUpperCase() + '.' + arr[arr.length - 1][0].toUpperCase() + '.';
  }
  if (arr.length === 1) {
    return arr[0][0].toUpperCase() + '.';
  }
});
