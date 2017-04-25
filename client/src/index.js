import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue';

import App from './app/containers/App.vue';
import LandingPage from './app/containers/LandingPage.vue';
import LoginPage from './app/containers/LoginPage.vue';
import Feed from './app/containers/Feed.vue';
import Profile from './app/containers/Profile.vue';
import Network from './app/containers/Network.vue';

import store from './app/store/index';
import VueRouter from 'vue-router';
Vue.use(VueRouter);
Vue.use(BootstrapVue);

function requireAuth (to, from, next) {
  store.state.token.value = store.state.token.value || localStorage.getItem('auth_token');
  if (!store.state.token.value) next({ path: '/welcome' });
  else next();
}

function checkIfLoggedIn (to, from, next) {
  if (store.state.token.value) next({ path: '/' });
  else next();
}

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/welcome', component: LandingPage },
    { path: '/', component: Feed, beforeEnter: requireAuth },
    { path: '/users/sign_in', component: LoginPage, beforeEnter: checkIfLoggedIn },
    { path: '/users/sign_up', component: App, beforeEnter: checkIfLoggedIn },
    { path: '/profile', component: Profile, beforeEnter: requireAuth, props: { mine: true }},
    { path: '/network', component: Network, beforeEnter: requireAuth },
    { path: '/users/:id/profile', component: Profile, beforeEnter: requireAuth, props: { mine: false }}
  ]
});

export default new Vue({
  el: '#root',
  store,
  router,
  render: h => h('router-view')
});