import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue';

import App from './app/containers/App.vue';
import LandingPage from './app/containers/LandingPage.vue';
import store from './app/store/index';
import VueRouter from 'vue-router';
Vue.use(VueRouter);
Vue.use(BootstrapVue);

function requireAuth(to, from, next) {
  // TODO: Check if we have the user token available
  // if not, redirect to welcome page
  // else keep going
  next({
    path: '/welcome'
  });
}

const router = new VueRouter({
  mode: 'history',
  routes: [
    {path: '/welcome', component: LandingPage},
    {path: '/', component: App, beforeEnter: requireAuth}
  ]
});

export default new Vue({
  el: '#root',
  store,
  router,
  render: h => h('router-view')
});
