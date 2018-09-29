import Vue from 'vue';
import 'bootstrap';
import './stylesheets/app.scss';

import store from './app/store';
import { router } from './app/router';
// import VueAutosize from 'vue-autosize';
import VueRouter from 'vue-router';
// import VeeValidate from 'vee-validate';
// import './app/constants/filters';

// Vue.use(VueAutosize);
Vue.use(VueRouter);
// Vue.use(VeeValidate);

window.$ = require('jquery')
window.JQuery = require('jquery')

export default new Vue({
  el: '#root',
  store,
  router,
  render: h => h('router-view')
});
