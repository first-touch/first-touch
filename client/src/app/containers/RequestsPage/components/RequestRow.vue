<template>
  <tr>
    <td> {{ request.status }} </td>
    <td> {{ request.type_request }} </td>
    <td> {{ request.created_at | moment }} </td>
    <td> {{ bidCount }} </td>
    <td>
      <button class="btn btn-primary" @click="updateStatus"> Publish/Unpublish </button>
      <button class="btn btn-primary" @click="editRequest"> Edit </button>
      <button class="btn btn-primary" @click="viewAssociatedBids">View Bids</button>
      <button class="btn btn-primary" @click="viewAssociatedReports">View Reports</button>
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
      updateStatus() {
        this.$emit('update-status', { request: this.request, newStatus: 'publish' })
      },
      editRequest() {
        this.$emit('edit-request', { request: this.request })
      },
      viewAssociatedBids() {
        this.$emit('view-bids', { request: this.request });
      },
      viewAssociatedReports() {
        this.$emit('view-reports', { request: this.request });
      },
    },
    computed: {
      bidCount() {
        return 0;
      },
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
