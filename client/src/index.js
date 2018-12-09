import Vue from 'vue';
import 'bootstrap';
import './stylesheets/app.scss';
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
import ClubDashboard from 'app/containers/ClubDashboardPage';
import ClubStream from 'app/containers/ClubStreamPage';
import ClubNotes from 'app/containers/ClubNotesPage';
import ClubProfile from 'app/containers/ClubProfilePage';
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
import VueFormWizard from 'vue-form-wizard';
import VueFlashMessage from 'vue-flash-message';
// TODO: Customize with FT color scheme and remove this
require('vue-flash-message/dist/vue-flash-message.min.css');

Vue.use(VueAutosize);
Vue.use(VueRouter);
Vue.use(BootstrapVue);
Vue.use(VeeValidate);
Vue.use(VueFlashMessage);
Vue.use(VueFormWizard);

window.$ = require('jquery');
window.JQuery = require('jquery');
window._ = require('lodash');

function requireAuth (to, from, next) {
  if (!store.state.token) {
    next({ path: '/welcome' });
  } else next();
}

function requireClub (to, from, next) {
  if (!store.state.token) {
    next({ path: '/welcome' });
  } else if (store.state.clubs.length === 0) {
    next({ path: '/' });
  }
  next();
}

function checkIfLoggedIn (to, from, next) {
  if (store.state.token) {
    next({ path: '/' });
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
      path: '/users/sign_up/:role?',
      component: SignupPage
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
          component: ClubDashboard
        },
        {
          path: 'feed',
          component: ClubStream
        },
        {
          path: 'profile',
          component: ClubProfile
        },
        {
          path: ':id/profile',
          component: ClubProfile
        },
        {
          path: 'notes',
          component: ClubNotes
        },
        {
          path: 'scouting/report/marketplace',
          component: MarketPlacePage,
          name: 'clubReportMarketplace'
        },
        {
          path: 'scouting/report/proposed',
          component: ProposedPlayer,
          name: 'clubReportProposed',
          props: true
        },
        {
          path: 'scouting/report/list',
          component: MyPurchasedReportsPage,
          name: 'clubReportList'
        },
        {
          path: 'scouting/request',
          component: JobRequestPage,
          name: 'clubRequestList',
          props: true
        },
        {
          path: 'scouting/report/:id',
          component: ReportPage,
          name: 'clubReport'
        },
        {
          path: 'scouting/request/:id',
          component: RequestPage,
          name: 'clubRequest'
        },
        {
          path: 'scouting/request/:id/bids',
          component: RequestBidsPage,
          name: 'clubRequestBids'
        },
        {
          path: 'scouting/payments',
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
