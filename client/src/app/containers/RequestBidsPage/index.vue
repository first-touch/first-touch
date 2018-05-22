<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h4 class="header">My Bids List</h4>
        <actions v-if="request.value" :id="request.value.id" :status="request.value.status" :updateStatus="customUpdateRequest">
        </actions>
        <timeline-item v-if="request.value">
          <teamrequest v-if="request.value.type_request == 'team'" :request="request.value" />
          <playerrequest v-if="request.value.type_request == 'player'" :request="request.value" />
          <positionrequest v-if="request.value.type_request == 'position'" :request="request.value" />
        </timeline-item>
        <timeline-item v-if="request.value">
          <bids :bids="bids.value" :currency="request.value.price.currency" :getBids="customGetBids" :acceptAction="acceptAction" />
        </timeline-item>
        <b-modal id="metaModal" :size="paymentSuccess? 'md' : 'lg'" ref="metaModal" :class="paymentSuccess? 'successModal' : 'formModal' ">
          <paymentpopup :paymentAction="paymentAction" v-if="selected" :stripeClubCards="stripeClubCards" :closeAction="hideModal" :result="bid" :StripeCardToken="StripeCardToken"
            :stripePayment="stripePayment" :stripeJs="stripeJs">
            <div slot="header" v-if="requestValue">
              <div class="row">
                <label class="col-md-3">Scout's name:</label>
                <p class="col-md-8"> {{requestValue.user.first_name}} {{requestValue.user.last_name}} </p>
              </div>
              <div class="row" v-if="selected">
                <label class="col-md-3">Price:</label>
                <p class="col-md-8"> {{selected.price.value}} {{requestValue.price.currency}} </p>
              </div>
            </div>
            <div class="col-md-12" v-if="published">
              <label class="col-sm-12 ftcheckbox-inner col-form-label" :class="keep? 'active' : ''">
                <span class="title"  v-if="keep">Keep receiving bids</span>
                <span class="not" v-if="!keep">Unpublish the request and do not receive beed anymore</span>
                <ftcheckbox class="ftcheckbox" :value="keep" v-on:update:val="keep = $event" :trueValue="true" :falseValue="false"
                />
              </label>
            </div>

          </paymentpopup>
        </b-modal>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
  @import '~stylesheets/modal';
</style>


<script>
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  import {
    ASYNC_SUCCESS
  } from 'app/constants/AsyncStatus';
  import TimelineItem from 'app/components/TimelineItem';
  import vSelect from 'vue-select';
  import NotificationSidebar from 'app/components/NotificationSidebar.vue';
  import FtDatepicker from 'app/components/Input/FtDatepicker';
  import PlayerRequest from './components/PlayerRequest';
  import PositionRequest from './components/PositionRequest';
  import TeamRequest from './components/TeamRequest';
  import Bids from './components/Bids';
  import Actions from './components/Actions';
  import PaymentPopup from 'app/components/Stripe/PaymentPopup';
  import FtCheckbox from 'app/components/Input/FtCheckbox';

  export default {
    name: 'RequestBidsList',
    components: {
      sidebar: NotificationSidebar,
      'timeline-item': TimelineItem,
      vselect: vSelect,
      ftdatepicker: FtDatepicker,
      teamrequest: TeamRequest,
      positionrequest: PositionRequest,
      playerrequest: PlayerRequest,
      bids: Bids,
      actions: Actions,
      paymentpopup: PaymentPopup,
      ftcheckbox: FtCheckbox

    },
    data() {
      return {
        selected: null,
        keep: true
      };
    },
    mounted() {
      this.getRequest(this.$route.params.id);
      this.customGetBids('');
    },
    computed: {
      ...mapGetters(['request', 'bids', 'bid', 'stripePayment', 'stripeJs', 'stripeClubCards']),
      paymentSuccess() {
        if (this.bid.status == ASYNC_SUCCESS) {
          if (this.bid.value.status == 'accepted') return true;
        }
        return false;
      },
      requestValue() {
        if (this.request.status == ASYNC_SUCCESS)
          return (this.request.value)
        return null;
      },
      published() {
        if (this.requestValue)
          return this.requestValue.status == 'publish'
        return null;
      }
    },
    watch: {
      bid() {
        if (this.bid.status == ASYNC_SUCCESS) {
          this.customGetBids();
          if (this.keep == false) {
            this.keep = true;
            this.getRequest(this.$route.params.id);
          }

        }
      }
    },
    methods: {
      ...mapActions(['getRequest', 'getBids', 'updateRequest', 'acceptBid', 'clearBid', 'StripeCardToken',
        'getClubsCards'
      ]),
      customGetBids(params) {
        this.getBids({
          id: this.$route.params.id,
          params: params
        });
      },
      acceptAction(bid) {
        this.clearBid();
        this.getClubsCards();
        this.$refs.metaModal.show();
        this.selected = bid;
      },
      paymentAction(token, save, usesaved) {
        var params = {
          token,
          bid_id: this.selected.id,
          save,
          usesaved,
          keep: this.keep
        };
        var obj = {
          id: this.$route.params.id,
          params
        };
        this.acceptBid(obj);
      },
      hideModal() {
        this.clearBid();
        this.customGetBids('');
        this.$refs.metaModal.hide();
      },
      customUpdateRequest(status) {
        this.updateRequest({
          id: this.$route.params.id,
          request: {
            status
          }
        });
      }
    }
  };
</script>
