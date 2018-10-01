import Vue from 'vue';
import VueRouter from 'vue-router';
import store from '../store';

import LandingPage from '../containers/LandingPage/index.vue';
import LoginPage from '../containers/LoginPage/index.vue';
import SignupPage from '../containers/SignupPage/index.vue';
import ConfirmAccount from '../containers/ConfirmAccount/index.vue';
import ResetPassword from '../containers/ResetPassword/index.vue';
import EditPassword from '../containers/EditPassword/index.vue';

import UserLayout from '../components/UserLayout/index.vue';
// TODO: Understand the difference between note and notes pages
import NotesPage from '../containers/NotesPage/index.vue';
import NotePage from '../containers/NotePage/index.vue';
import TagContainer from '../containers/NotesPage/components/TagContainer.vue';
import FeedPage from '../containers/FeedPage/index.vue';
import EditProfilePage from '../containers/EditProfilePage/index.vue';
import ProfilePage from '../containers/ProfilePage/index.vue';
import Network from '../containers/NetworkPage/index.vue';

// import Messages from '../containers/MessagesPage/index.vue';
// import ConvoContainer from '../containers/MessagesPage/components/ConvoContainer.vue/index.vue';
// import ClubLayout from './app/components/ClubLayout';
// import ClubStream from '../containers/ClubStreamPage/index.vue';
// import ClubNotes from '../containers/ClubNotesPage/index.vue';
// import TCPage from '../containers/LegalPages/TCPage/index.vue';
// import PrivacyPolicy from '../containers/LegalPages/PrivacyPolicy/index.vue';
// import CommunityGuidelines from '../containers/LegalPages/CommunityGuidelines/index.vue';
// import ContactUs from '../containers/LegalPages/ContactUs/index.vue';
// import AboutPage from '../containers/AboutPage/index.vue';

// import CreateReportPage from '../containers/CreateReportPage/index.vue';
// import EditReportPage from '../containers/EditReportPage/index.vue';
// import ReportPage from '../containers/ReportPage/index.vue';
// import MarketPlacePage from '../containers/MarketPlacePage/index.vue';
// import JobsListPage from '../containers/JobsListPage/index.vue';
// import MyPurchasedReportsPage from '../containers/MyPurchasedReportsPage/index.vue';
// import JobRequestPage from '../containers/JobRequestPage/index.vue';
// import RequestPage from '../containers/RequestPage/index.vue';
// import RequestBidsPage from '../containers/RequestBidsPage/index.vue';
// import PaymentDetailPage from '../containers/PaymentDetailPage/index.vue';
// import ClubPaymentDetails from '../containers/ClubPaymentDetailsPage/index.vue';
// import ProposedPlayer from '../containers/ProposedPlayerPage/index.vue';
// import JobsBankPage from '../containers/JobsBankPage/index.vue';
// import JobBidPage from '../containers/JobBidPage/index.vue';

Vue.use(VueRouter);

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
  routes: [{
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
  //   {
  //     path: '/club',
  //     component: ClubLayout,
  //     beforeEnter: requireClub,
  //     children: [
  //       {
  //         path: '',
  //         component: ClubStream
  //       },
  //       {
  //         path: 'notes',
  //         component: ClubNotes
  //       },
  //       {
  //         path: '/club/scouting/report/marketplace',
  //         component: MarketPlacePage,
  //         name: 'clubReportMarketplace'
  //       },
  //       {
  //         path: '/club/scouting/report/proposed',
  //         component: ProposedPlayer,
  //         name: 'clubReportProposed',
  //         props: true
  //       },
  //       {
  //         path: '/club/scouting/report/list',
  //         component: MyPurchasedReportsPage,
  //         name: 'clubReportList'
  //       },
  //       {
  //         path: '/club/scouting/request',
  //         component: JobRequestPage,
  //         name: 'clubRequestList',
  //         props: true
  //       },
  //       {
  //         path: '/club/scouting/report/:id',
  //         component: ReportPage,
  //         name: 'clubReport'
  //       },
  //       {
  //         path: '/club/scouting/request/:id',
  //         component: RequestPage,
  //         name: 'clubRequest'
  //       },
  //       {
  //         path: '/club/scouting/request/:id/bids',
  //         component: RequestBidsPage,
  //         name: 'clubRequestBids'
  //       },
  //       {
  //         path: '/club/scouting/payments',
  //         component: ClubPaymentDetails,
  //         name: 'ClubPaymentDetails'
  //       }
  //     ]
  //   },
  //   {
  //     path: '/terms_conditions',
  //     component: TCPage
  //   },
  //   {
  //     path: '/privacy_policy',
  //     component: PrivacyPolicy
  //   },
  //   {
  //     path: '/community_guidelines',
  //     component: CommunityGuidelines
  //   },
  //   {
  //     path: '/contact_us',
  //     component: ContactUs
  //   },
  //   {
  //     path: '/about',
  //     component: AboutPage
  //   }
  ]
});
