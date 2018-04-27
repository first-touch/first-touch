<template>
  <div>
    <sidebar />
    <div class="container-fluid">
      <div class="ft-page">
        <h4 class="header">My Bids List</h4>
        <actions v-if="request.value" :id="request.value.id" :status="request.value.status" :updateStatus="customUpdateRequest">
        </actions>
        <timeline-item v-if="request.value">
        <!-- <teamrequestpopup v-if="request.value.type_request == 'team'" :request="request.value" /> -->
          <teamrequest v-if="request.value.type_request == 'team'" :request="request.value" />
          <playerrequest v-if="request.value.type_request == 'player'" :request="request.value" />
          <positionrequest v-if="request.value.type_request == 'position'" :request="request.value" />
        </timeline-item>
        <timeline-item v-if="request.value">
          <bids :bids="bids.value" :currency="request.value.price.currency" :getBids="customGetBids" :acceptAction="acceptAction" />
        </timeline-item>
        <b-modal id="metaModal" :size="paymentSuccess? 'md' : 'lg'" ref="metaModal" :class="paymentSuccess? 'successModal' : 'formModal' ">
          <paymentpopup :paymentAction="paymentAction" :stripeClubCards="stripeClubCards"
          :closeAction="hideModal" :result="bid" :StripeCardToken="StripeCardToken" :stripePayment="stripePayment"
            :stripeJs="stripeJs" />
        </b-modal>
      </div>
    </div>
  </div>
</template>

<style lang="scss">
  @import '~stylesheets/modal';
</style>


<script>
import { mapGetters, mapActions } from 'vuex';
import { ASYNC_SUCCESS } from 'app/constants/AsyncStatus';
import TimelineItem from 'app/components/TimelineItem';
import vSelect from 'vue-select';
import NotificationSidebar from 'app/components/NotificationSidebar.vue';
import FtDatepicker from 'app/components/Input/FtDatepicker';
import Bids from './components/Bids';
import Actions from './components/Actions';
import PaymentPopup from 'app/components/Stripe/PaymentPopup';
import TeamRequest from 'app/components/RequestPopup/TeamRequestPopup';
import PlayerRequest from 'app/components/RequestPopup/PlayerRequestPopup';
import PositionRequest from 'app/components/RequestPopup/PositionRequestPopup';

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
      paymentpopup: PaymentPopup
    },
    data() {
      return {
        selected: null
      };
    },
    mounted() {
      this.getRequest(this.$route.params.id);
      this.customGetBids('');
    },
    computed: {
      ...mapGetters(['request', 'bids', 'bid', 'stripePayment', 'stripeJs','stripeClubCards']),
      paymentSuccess() {
        if (this.bid.status == ASYNC_SUCCESS) {
          if (this.bid.value.status == 'accepted') return true;
        }
        return false;
      }
    },
    watch: {
      bid() {
        if (this.bid.status == ASYNC_SUCCESS) {
          this.customGetBids();
        }
      }
    },
    methods: {
      ...mapActions(['getRequest', 'getBids', 'updateRequest', 'acceptBid', 'clearBid', 'StripeCardToken','getClubsCards']),
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
          usesaved
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
