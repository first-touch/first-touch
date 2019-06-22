<template>
  <tr>
    <td> TBA </td>
    <td> {{ request.type_request }} </td>
    <td> {{ request.deadline | moment }} </td>
    <td> {{ country }} </td>
    <td> {{ requestPrice.max}} {{ requestPrice.currency | currency }} </td>
    <td>
      <button class="btn btn-primary" @click="viewRequestDetails">View details</button>
      <button class="btn btn-primary" @click="makeBid">Make a Bid</button>
    </td>
  </tr>
</template>

<script>
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
      viewRequestDetails() {
        console.log('request details!');
      },
      makeBid() {
        this.$emit('make-bid', { request: this.request });
      },
    },
    computed: {
      country() {
        if (this.isPlayerRequest || this.isTeamRequest) {
          if (this.request.league) {
            return `${this.request.league.name}, ${this.request.league.nation}`;
          } else {
            return 'Missing league info.';
          }
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
      requestPrice() {
        return this.request.price;
      }
    }
  };
</script>
