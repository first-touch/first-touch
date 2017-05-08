import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue';

import App from './app/containers/App.vue';
import Layout from './app/containers/Layout.vue';
import LandingPage from './app/containers/LandingPage.vue';
import LoginPage from './app/containers/LoginPage.vue';
import Feed from './app/containers/Feed.vue';
import Profile from './app/containers/Profile.vue';
import Network from './app/containers/Network.vue';
import Messages from './app/containers/Messages.vue';

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
    { path: '/users/sign_in', component: LoginPage, beforeEnter: checkIfLoggedIn },
    { path: '/users/sign_up', component: App, beforeEnter: checkIfLoggedIn },
    { path: '/', component: Layout, beforeEnter: requireAuth,
      children: [
        { path: '', component: Feed },
        { path: '/profile', component: Profile, props: { mine: true }},
        { path: '/network', component: Network },
        { path: '/users/:id/profile', component: Profile, props: { mine: false }},
        { path: '/messages', component: Messages }
      ]
    }
    // { path: '/profile', component: Profile, beforeEnter: requireAuth, props: { mine: true }},
    // { path: '/network', component: Network, beforeEnter: requireAuth },
    // { path: '/users/:id/profile', component: Profile, beforeEnter: requireAuth, props: { mine: false }},
    // { path: '/messages', component: Messages, beforeEnter: requireAuth }
  ]
});

export default new Vue({
  el: '#root',
  store,
  router,
  render: h => h('router-view')
});