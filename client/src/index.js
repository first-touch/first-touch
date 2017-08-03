import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue';

import LandingPage from './app/LandingPage';
import PreRegistration from './app/PreRegistrationPage';
import Layout from './app/shared/components/Layout';
import SignupPage from './app/SignupPage';
import LoginPage from './app/LoginPage';
import Feed from './app/FeedPage';
import ProfilePage from './app/ProfilePage';
import Network from './app/NetworkPage';
import Messages from './app/MessagesPage';
import ConvoContainer from './app/MessagesPage/components/ConvoContainer.vue';
import EditProfilePage from './app/EditProfilePage';

import store from './app/shared/store';
import VueRouter from 'vue-router';
Vue.use(VueRouter);
Vue.use(BootstrapVue);

// delete once registration is allowed
function redirectToPrereg (to, from, next) {
  next({ path: '/pre_registration' });
}

function requireAuth (to, from, next) {
  store.state.token.value = store.state.token.value || localStorage.getItem('auth_token');
  if (!store.state.token.value) next({ path: '/welcome' });
  else next();
}

function checkIfLoggedIn (to, from, next) {
  store.state.token.value = store.state.token.value || localStorage.getItem('auth_token');
  if (store.state.token.value) next({ path: '/' });
  else next();
}

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/welcome', component: LandingPage },
    { path: '/users/sign_in', component: LoginPage, beforeEnter: checkIfLoggedIn },
    { path: '/users/sign_up', component: SignupPage, beforeEnter: redirectToPrereg },
    { path: '/', component: Layout, beforeEnter: requireAuth,
      children: [
        { path: '', component: Feed },
        { path: '/profile/edit', component: EditProfilePage },
        { path: '/profile', component: ProfilePage, props: { mine: true }},
        { path: '/network', component: Network },
        { path: '/users/:id/profile', component: ProfilePage, props: { mine: false }, meta: { reuse: false }},
        {
          path: '/messages', component: Messages,
          children: [
            { path: '', component: ConvoContainer },
            { path: '/messages/:id', component: ConvoContainer }
          ]
        }
      ]
    },
    // Delete once registration is allowed
    { path: '/pre_registration', component: PreRegistration, beforeEnter: checkIfLoggedIn }
  ]
});

export default new Vue({
  el: '#root',
  store,
  router,
  render: h => h('router-view')
});