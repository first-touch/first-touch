<template>
  <div class="report col-md-12">
    <div class="row">
      <p class="col-sm-4">Purchassed Price (IN SGD) {{report.price}} </p>
    </div>
    <div class="row">
      <span class="col-sm-12">Report Name: {{report.headline}} </span>
    </div>
    <div class="reportDate">
      <div class="row">
        <span class="col-sm-4">Create on {{report.report_data.created_at}} </span>
      </div>
      <div class="row">
        <span class="col-sm-4">Updated on {{report.report_data.updated_at}} </span>
      </div>
    </div>
    <div class="metas">
      <div>
        <label class="row col-sm-12">Formations(s) Used & playing Style</label>
        <p class="row col-sm-12"> {{report.headline}} </p>
      </div>
      <div>
        <label class="row col-sm-12">Attacking Organisation & Transition After winnig possession</label>
        <p class="row col-sm-12"> {{report.headline}} </p>
      </div>
      <div>
        <label class="row col-sm-12">Defensive Organisation & Transition After losing possession</label>
        <p class="row col-sm-12"> {{report.headline}} </p>
      </div>
      <div>
        <label class="row col-sm-12">Set Plays - For</label>
        <p class="row col-sm-12"> {{report.headline}} </p>
      </div>
      <div>
        <label class="row col-sm-12">Set Plays - Against</label>
        <p class="row col-sm-12"> {{report.headline}} </p>
      </div>
      <div>
        <label class="row col-sm-12">Main Threats</label>
        <p class="row col-sm-12"> {{report.headline}} </p>
      </div>
      <div>
        <label class="row col-sm-12">Others Observations & Viewpoint To Note</label>
        <p class="row col-sm-12"> {{report.headline}} </p>
      </div>
      <div>
        <label class="row col-sm-12">Conclusion</label>
        <p class="row col-sm-12"> {{report.headline}} </p>
      </div>
      <div>
        <label class="row col-sm-12">Attachments</label>
        <div class="row col-sm-12"> WIP </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';
  .report {
    background: white;
    color: black;
    padding: 50px;
    .reportDate {
      margin-left: 30px;
      margin-bottom: 20px;
    }
  }
</style>

<script>

  export default {
    name: 'ClubReport',
    props: [
      'report',
    ],
    data() {
      return {};
    }
  };
</script>