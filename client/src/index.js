import { $, jQuery } from 'jquery';
import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue';

import LandingPage from './app/containers/LandingPage';
import ConfirmAccount from './app/containers/ConfirmAccount';
import ResetPassword from './app/containers/ResetPassword';
import EditPassword from './app/containers/EditPassword';
import PreRegistration from './app/containers/PreRegistrationPage';
import UserLayout from './app/components/UserLayout';
import SignupPage from './app/containers/SignupPage';
import LoginPage from './app/containers/LoginPage';
import FeedPage from './app/containers/FeedPage';
import ProfilePage from './app/containers/ProfilePage';
import Network from './app/containers/NetworkPage';
import Messages from './app/containers/MessagesPage';
import ConvoContainer from './app/containers/MessagesPage/components/ConvoContainer.vue';
import EditProfilePage from './app/containers/EditProfilePage';
import ClubLayout from './app/components/ClubLayout';
import ClubStream from './app/containers/ClubStreamPage';
import ClubNotes from './app/containers/ClubNotesPage';
import TCPage from './app/containers/LegalPages/TCPage';
import PrivacyPolicy from './app/containers/LegalPages/PrivacyPolicy';
import CommunityGuidelines from './app/containers/LegalPages/CommunityGuidelines';
import ContactUs from './app/containers/LegalPages/ContactUs';
import NotesPage from './app/containers/NotesPage';
import NotePage from './app/containers/NotePage';
import TagContainer from './app/containers/NotesPage/components/TagContainer';
import AboutPage from './app/containers/AboutPage';

import store from './app/store';
import VueRouter from 'vue-router';
import './stylesheets/landingpage.scss';
Vue.use(VueRouter);
Vue.use(BootstrapVue);

window.$ = $;
window.jQuery = jQuery;

// delete once registration is allowed
// function redirectToPrereg (to, from, next) {
//   next({ path: '/pre_registration' });
// }

function requireAuth (to, from, next) {
  store.state.token.value =
    store.state.token.value || localStorage.getItem('auth_token');
  if (!store.state.token.value) next({ path: '/welcome' });
  else next();
}

function checkIfLoggedIn (to, from, next) {
  store.state.token.value =
    store.state.token.value || localStorage.getItem('auth_token');
  if (store.state.token.value) next({ path: '/' });
  else next();
}

export const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/welcome', component: LandingPage },
    {
      path: '/users/sign_in',
      component: LoginPage,
      beforeEnter: checkIfLoggedIn
    },
    {
      path: '/users/sign_up',
      component: SignupPage
      // beforeEnter: redirectToPrereg
    },
    {
      path: '/users/confirmation',
      component: ConfirmAccount
    },
    {
      path: '/users/reset_password',
      component: ResetPassword
    },
    {
      path: '/users/new_password',
      component: EditPassword
    },
    {
      path: '/',
      component: UserLayout,
      beforeEnter: requireAuth,
      children: [
        { path: '', component: FeedPage },
        { path: 'profile/edit', component: EditProfilePage },
        { path: 'profile', component: ProfilePage, props: { mine: true }},
        { path: 'network', component: Network },
        { path: 'notes', component: NotesPage },
        { path: 'notes/:id', component: NotePage, props: true },
        { path: 'notes/tags/:tag', component: TagContainer, props: true },
        {
          path: '/users/:id/profile',
          component: ProfilePage,
          props: { mine: false },
          meta: { reuse: false }
        },
        {
          path: '/messages',
          component: Messages,
          children: [
            { path: '', component: ConvoContainer },
            { path: ':id', component: ConvoContainer }
          ]
        }
      ]
    },
    {
      path: '/club',
      component: ClubLayout,
      beforeEnter: requireAuth,
      children: [
        { path: '', component: ClubStream },
        { path: 'notes', component: ClubNotes }
      ]
    },
    // Delete once registration is allowed
    {
      path: '/pre_registration',
      component: PreRegistration,
      beforeEnter: checkIfLoggedIn
    },
    {
      path: '/terms_conditions',
      component: TCPage
    },
    {
      path: '/privacy_policy',
      component: PrivacyPolicy
    },
    {
      path: '/community_guidelines',
      component: CommunityGuidelines
    },
    {
      path: '/contact_us',
      component: ContactUs
    },
    {
      path: '/about',
      component: AboutPage
    }
  ]
});

export default new Vue({
  el: '#root',
  store,
  router,
  render: h => h('router-view')
});
