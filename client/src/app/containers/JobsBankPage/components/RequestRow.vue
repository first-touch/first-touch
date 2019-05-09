<template>
  <tr>
    <td> TBA </td>
    <td> {{ request.type_request }} </td>
    <td> {{request.deadline | moment}} </td>
    <td> {{country}} </td>
    <td>
      <button class="btn btn-primary" @click="viewRequestDetails">View details</button>
      <button class="btn btn-primary" @click="makeBid">{{ makeOrUpdateBid }}</button>
    </td>
  </tr>
</template>

<script>
  import { mapActions } from 'vuex';
  export default {
    name: 'RequestRow',
    props: [
      'request'
    ],
    data() {
      return {
        latestBid: null
      }
    },
    methods: {
      ...mapActions(['getRequestBids']),
      viewRequestDetails() {
        console.log('request details!');
      },
      makeBid() {
        this.$emit('make-bid', { request: this.request, bid: this.latestBid });
      },
    },
    computed: {
      country() {
        if (this.isPlayerRequest || this.isTeamRequest) {
          return `${this.request.league.name}, ${this.request.league.nation}`;
        } else {
          return 'N/A';
        }
      },
      isPlayerRequest() {
        return this.requestType == "player";
      },
      isTeamRequest() {
        return this.requestType == "team";
      },
      requestType() {
        return this.request.type_request;
      },
      requestHasBid() {
        return this.latestBid != null;
      },
      makeOrUpdateBid() {
        if (this.requestHasBid) {
          return "Update Bid";
        } else {
          return "Make a Bid";
        }
      }
    },
    mounted() {
      const params = { request_id: this.request.id };
      this.getRequestBids(params).then(res => {
        if (res.length > 0) {
          this.latestBid = res[0];
        }
      });
    }
  };
</script>
