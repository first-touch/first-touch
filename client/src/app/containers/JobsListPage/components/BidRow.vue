<template>
  <tr>
    <td> {{request.id | reportId(request.type_report) }} </td>
    <td> TBA </td>
    <td> {{ request.type_request }} job request </td>
    <td> {{ request.deadline | moment }} </td>
    <td>
      <button class="btn btn-primary" @click="createReport">Write report</button>
      <button class="btn btn-primary" @click="viewReport">View final report</button>
    </td>
  </tr>
</template>

<script>
  export default {
    name: 'BidRow',
    props: ['request'],
    methods: {
      createReport () {
        console.log('start writing report for this request');
      },
      viewReport () {
        console.log('navigate to associated report')
      },
    }
  };
</script>
