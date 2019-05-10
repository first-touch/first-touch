<template>
  <tr>
    <td> {{report.id | reportId(report.type_report) }} </td>
    <td> {{report.headline}} </td>
    <td> {{ report.created_at | moment }} </td>
    <td>
      <button class="btn btn-primary" @click="viewAction(report)">View report</button>
      <button class="btn btn-secondary" v-if="report.status == 'publish'" @click="updateReport('private', report.id)">
        Unpublish
      </button>
      <button class="btn btn-secondary" v-if="report.status == 'private'" @click="updateReport('publish', report.id)">
        Publish
      </button>
    </td>
  </tr>
</template>

<script>
  export default {
    name: 'ReportItem',
    props: [
      'report',
      'updateReport',
      'viewAction'
    ],
  };
</script>
