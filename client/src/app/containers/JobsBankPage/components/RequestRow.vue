<template>
  <tr>
    <td> {{request.id | requestId(request.type_request) }} </td>
    <td> TBA </td>
    <td> {{ request.type_request }} job request </td>
    <td> {{request.price.value}} to {{request.price.max}} {{request.price.currency | currency}} </td>
    <td> {{request.deadline | moment}} </td>
    <td>
      <!-- <button class="btn btn-primary" @click="viewAction(report)">View report</button>
      <button class="btn btn-secondary" v-if="report.status == 'publish'" @click="updateReport('private', report.id)">
        Unpublish
      </button>
      <button class="btn btn-secondary" v-if="report.status == 'private'" @click="updateReport('publish', report.id)">
        Publish
      </button> -->
    </td>
  </tr>
</template>

<script>
  export default {
    name: 'RequestRow',
    props: [
      'request'
    ],
  };
</script>
