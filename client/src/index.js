import { $, jQuery } from 'jquery';
import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue';

import LandingPage from 'app/containers/LandingPage';
import ConfirmAccount from 'app/containers/ConfirmAccount';
import ResetPassword from 'app/containers/ResetPassword';
import EditPassword from 'app/containers/EditPassword';
import PreRegistration from 'app/containers/PreRegistrationPage';
import UserLayout from 'app/components/UserLayout';
import SignupPage from 'app/containers/SignupPage';
import LoginPage from 'app/containers/LoginPage';
import FeedPage from 'app/containers/FeedPage';
import ProfilePage from 'app/containers/ProfilePage';
import Network from 'app/containers/NetworkPage';
import Messages from 'app/containers/MessagesPage';
import ConvoContainer from 'app/containers/MessagesPage/components/ConvoContainer.vue';
import EditProfilePage from 'app/containers/EditProfilePage';
import ClubLayout from 'app/components/ClubLayout';
import ClubStream from 'app/containers/ClubStreamPage';
import ClubNotes from 'app/containers/ClubNotesPage';
import TCPage from 'app/containers/LegalPages/TCPage';
import PrivacyPolicy from 'app/containers/LegalPages/PrivacyPolicy';
import CommunityGuidelines from 'app/containers/LegalPages/CommunityGuidelines';
import ContactUs from 'app/containers/LegalPages/ContactUs';
import NotesPage from 'app/containers/NotesPage';
import NotePage from 'app/containers/NotePage';
import TagContainer from 'app/containers/NotesPage/components/TagContainer';
import AboutPage from 'app/containers/AboutPage';

import CreateReportPage from 'app/containers/CreateReportPage';
import EditReportPage from 'app/containers/EditReportPage';
import ReportPage from 'app/containers/ReportPage';
import MarketPlacePage from 'app/containers/MarketPlacePage';
import JobsListPage from 'app/containers/JobsListPage';
import MyPurchasedReportsPage from 'app/containers/MyPurchasedReportsPage';
import JobRequestPage from 'app/containers/JobRequestPage';
import RequestPage from 'app/containers/RequestPage';
import RequestBidsPage from 'app/containers/RequestBidsPage';
import PaymentDetailPage from 'app/containers/PaymentDetailPage';
import ClubPaymentDetails from 'app/containers/ClubPaymentDetailsPage';
import ProposedPlayer from 'app/containers/ProposedPlayerPage';
import JobsBankPage from 'app/containers/JobsBankPage';
import JobBidPage from 'app/containers/JobBidPage';
import store from 'app/store';
import VueAutosize from 'vue-autosize';
import VueRouter from 'vue-router';
import VeeValidate from 'vee-validate';
import './app/constants/filters';
import 'stylesheets/landingpage.scss';

Vue.use(VueAutosize);
Vue.use(VueRouter);
Vue.use(BootstrapVue);
Vue.use(VeeValidate);

window.$ = $;
window.jQuery = jQuery;

// delete once registration is allowed
// function redirectToPrereg (to, from, next) {
//   next({ path: '/pre_registration' });
// }

function requireAuth (to, from, next) {
  store.state.token.value = store.state.token.value || localStorage.getItem('auth_token');
  try {
    store.state.token.clubs = store.state.token.clubs || localStorage.getItem('clubs_token') ? JSON.parse(localStorage.getItem('clubs_token')) : null;
  } catch (e) {
    store.state.token.clubs = null;
  }
  if (!store.state.token.value) {
    next({
      path: '/welcome'
    });
  } else next();
}

function requireClub (to, from, next) {
  store.state.token.value = store.state.token.value || localStorage.getItem('auth_token');
  try {
    store.state.token.clubs = store.state.token.clubs || localStorage.getItem('clubs_token') ? JSON.parse(localStorage.getItem('clubs_token')) : null;
  } catch (e) {
    store.state.token.clubs = null;
  }
  if (!store.state.token.value) {
    next({
      path: '/welcome'
    });
  } else if (store.state.token.clubs.length === 0) {
    next({
      path: '/'
    });
  }

  next();
}

function checkIfLoggedIn (to, from, next) {
  store.state.token.value = store.state.token.value || localStorage.getItem('auth_token');
  if (store.state.token.value) {
    next({
      path: '/'
    });
  } else next();
}

export const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/welcome',
      component: LandingPage
    },
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
        { path: 'notes', component: NotesPage },
        { path: 'notes/:id', component: NotePage, props: true },
        { path: 'notes/tags/:tag', component: TagContainer, props: true },
        {
          path: '',
          component: FeedPage
        },
        {
          path: 'profile/edit',
          component: EditProfilePage
        },
        {
          path: 'profile',
          component: ProfilePage,
          props: {
            mine: true
          }
        },
        {
          path: '/users/:id/profile',
          component: ProfilePage,
          name: 'userProfilePage',
          props: {
            mine: false
          },
          meta: {
            reuse: false
          }
        },
        {
          path: 'network',
          component: Network
        },
        {
          path: '/scouting/report/create',
          component: CreateReportPage,
          name: 'scoutReportCreate',
          props: true
        },
        {
          path: '/scouting/report/view/:id',
          component: ReportPage,
          name: 'scoutReportView'
        },
        {
          path: '/scouting/report/edit/:id',
          component: EditReportPage,
          name: 'scoutReportEdit'
        },
        {
          path: '/scouting/jobs/list',
          component: JobsListPage,
          name: 'scoutJobsList'
        },
        {
          path: '/scouting/jobs/pending',
          component: JobBidPage,
          name: 'ScoutJobBidPage'
        },
        {
          path: '/scouting/jobs/bank',
          component: JobsBankPage,
          name: 'scoutJobsBank'
        },
        {
          path: '/scouting/payment',
          component: PaymentDetailPage,
          name: 'scoutPaymentDetailPage'
        },
        {
          path: '/messages',
          component: Messages,
          children: [
            {
              path: '',
              component: ConvoContainer
            },
            {
              path: ':id',
              component: ConvoContainer
            }
          ]
        }
      ]
    },
    {
      path: '/club',
      component: ClubLayout,
      beforeEnter: requireClub,
      children: [
        {
          path: '',
          component: ClubStream
        },
        {
          path: 'notes',
          component: ClubNotes
        },
        {
          path: '/club/scouting/report/marketplace',
          component: MarketPlacePage,
          name: 'clubReportMarketplace'
        },
        {
          path: '/club/scouting/report/proposed',
          component: ProposedPlayer,
          name: 'clubReportProposed',
          props: true
        },
        {
          path: '/club/scouting/report/list',
          component: MyPurchasedReportsPage,
          name: 'clubReportList'
        },
        {
          path: '/club/scouting/request',
          component: JobRequestPage,
          name: 'clubRequestList',
          props: true
        },
        {
          path: '/club/scouting/report/:id',
          component: ReportPage,
          name: 'clubReport'
        },
        {
          path: '/club/scouting/request/:id',
          component: RequestPage,
          name: 'clubRequest'
        },
        {
          path: '/club/scouting/request/:id/bids',
          component: RequestBidsPage,
          name: 'clubRequestBids'
        },
        {
          path: '/club/scouting/payments',
          component: ClubPaymentDetails,
          name: 'ClubPaymentDetails'
        }
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
