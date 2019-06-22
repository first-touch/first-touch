<template>
  <div class="ft-page container">
    <h4 class="spaced-title upper-cased main-color page-title mb-5">My Pending Bids</h4>
    <div class="a-side-indicator primary">
      <div class="arrow"></div>
      <ft-button :linkTo="{ name: 'scoutJobsBank'}" icon="search">Find Work</ft-button>
      <ft-button :linkTo="{ name: 'scoutJobsList'}" icon="handshake">My Assignments</ft-button>
    </div>
    <bids-list bid_status="pending" class="mt-2 mb-2">
      <template v-slot:actions="slotProps">
        <button class="btn btn-primary" @click="openBidPopup(slotProps.bid)">Update Bid</button>
        <button class="btn btn-primary" @click="cancelBid(slotProps.bid)">Cancel Bid</button>
      </template>
    </bids-list>

    <ft-dialog :visible.sync="isBidding" v-on:closed="unsetBidingOn">
      <div slot="title">
        <span v-if="requestBid != null">Edit bid</span>
        <span v-else>Make your bid</span>
      </div>
      <bid-popup :request="bidingOn"
                 :currentBid="requestBid"
                 v-on:submit-bid="submitBid"
      />
    </ft-dialog>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
import BidsList from '../JobsListPage/components/BidsList';
import BidPopup from '../JobsBankPage/components/BidPopup';
import FtButton from 'app/components/Button/Button';

export default {
  name: 'JobList',
  components: {
    BidsList,
    FtButton,
    BidPopup
  },
  data() {
    return {
      bidingOn: null,
      requestBid: null,
      isBidding: false,
    }
  },
  methods: {
    ...mapActions(['updateBid']),
    openBidPopup (bid) {
      this.bidingOn = bid.request;
      this.requestBid = bid;
      this.isBidding = true;
    },
    cancelBid (bid) {
      console.log('navigate to associated report')
    },
    submitBid(bidData) {

      let submitRequest;
      submitRequest = this.updateBid({
        id: this.requestBid.id,
        price: bidData
      });
      submitRequest.then(res => {
        const msg = "Bid updated successfully."
        this.flash(msg, "success", { timeout: 3000, important: true });
        this.unsetBidingOn()
      });
    },
    unsetBidingOn() {
      this.isBidding = false;
      this.requestBid = null;
      this.bidingOn = null;
    }
  }
};
</script>
