<template>
  <tr>
    <td> TBA </td>
    <td> {{ request.type_request }} job request </td>
    <td> {{ request.deadline | moment }} </td>
    <td>
      <slot></slot>
    </td>
  </tr>
</template>

<script>
  export default {
    name: 'BidRow',
    props: ['request']
  };
</script>
