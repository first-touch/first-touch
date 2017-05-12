import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue';

import LandingPage from './app/containers/LandingPage.vue';
import PreRegistration from './app/containers/PreRegistration.vue';
// uncomment this once registration is allowed
// import Layout from './app/containers/Layout.vue';
// import SignupPage from './app/containers/SignupPage.vue';
// import LoginPage from './app/containers/LoginPage.vue';
// import Feed from './app/containers/Feed.vue';
// import ProfilePage from './app/containers/ProfilePage.vue';
// import Network from './app/containers/Network.vue';
// import Messages from './app/containers/Messages.vue';

import store from './app/store/index';
import VueRouter from 'vue-router';
Vue.use(VueRouter);
Vue.use(BootstrapVue);

// remove once registration is allowed
function redirectToPrereg (to, from, next) {
  next({ path: '/preregister' });
}
function redirectToWelcome (to, from, next) {
  next({ path: '/welcome' });
}
// uncomment this once registration is allowed
// function requireAuth (to, from, next) {
//   store.state.token.value = store.state.token.value || localStorage.getItem('auth_token');
//   if (!store.state.token.value) next({ path: '/welcome' });
//   else next();
// }

// function checkIfLoggedIn (to, from, next) {
//   if (store.state.token.value) next({ path: '/' });
//   else next();
// }

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/welcome', component: LandingPage },
    { path: '/preregister', component: PreRegistration },
    { path: '/users/sign_up', beforeEnter: redirectToPrereg },
    { path: '/users/sign_in', beforeEnter: redirectToPrereg },
    { path: '*', beforeEnter: redirectToWelcome }
    // uncomment this for once registration is allowed
    // { path: '/users/sign_in', component: LoginPage, beforeEnter: checkIfLoggedIn },
    // { path: '/users/sign_up', component: SignupPage, beforeEnter: checkIfLoggedIn },
    // { path: '/', component: Layout, beforeEnter: requireAuth,
    //   children: [
    //     { path: '', component: Feed },
    //     { path: '/profile', component: ProfilePage, props: { mine: true }},
    //     { path: '/network', component: Network },
    //     { path: '/users/:id/profile', component: ProfilePage, props: { mine: false }},
    //     { path: '/messages', component: Messages }
    //   ]
    // }
  ]
});

export default new Vue({
  el: '#root',
  store,
  router,
  render: h => h('router-view')
});