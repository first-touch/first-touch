<template>
  <tr>
    <td> TBA </td>
    <td> {{ request.type_request }} </td>
    <td> {{request.deadline | moment}} </td>
    <td> {{country}} </td>
    <td>
      <button class="btn btn-primary" @click="viewRequestDetails">View request details</button>
      <button class="btn btn-primary" @click="makeBid">Make a Bid</button>
      <button class="btn btn-primary" @click="updateBid">Update your Bid</button>
      <button class="btn btn-primary" @click="cancelBid">Cancel Bid</button>
    </td>
  </tr>
</template>

<script>
  export default {
    name: 'RequestRow',
    props: [
      'request'
    ],
    methods: {
      viewRequestDetails() {
        console.log('request details!');
      },
      makeBid() {
        this.$emit('make-bid', this.request);
      },
      updateBid() {
        console.log('update bid');
      },
      cancelBid() {
        console.log('cancel bid');
      }
    },
    computed: {
      country() {
        if (this.isPlayerRequest) {
          return this.request.team.competitions[0].nation;
        } else if (this.isTeamRequest) {
          return this.request.team.competitions[0].nation;
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
      }
    }
  };
</script>
