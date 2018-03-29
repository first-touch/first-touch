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
        <span class="col-sm-12">Create on {{report.report_data.created_at}} </span>
      </div>
      <div class="row">
        <span class="col-sm-12">Updated on {{report.report_data.updated_at}} </span>
      </div>
    </div>
    <div class="metas">
      <div>
        <label class="row col-sm-12">Formations(s) Used & playing Style</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.formation}} </p>
      </div>
      <div>
        <label class="row col-sm-12">Attacking Organisation & Transition After winnig possession</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.attacking_organisation}}  </p>
      </div>
      <div>
        <label class="row col-sm-12">Defensive Organisation & Transition After losing possession</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.defensive_organisation}}  </p>
      </div>
      <div>
        <label class="row col-sm-12">Set Plays - For</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.setplays_for}} </p>
      </div>
      <div>
        <label class="row col-sm-12">Set Plays - Against</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.setplays_against}}  </p>
      </div>
      <div>
        <label class="row col-sm-12">Main Threats</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.main_threats}}  </p>
      </div>
      <div>
        <label class="row col-sm-12">Others Observations & Viewpoint To Note</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.observations}}  </p>
      </div>
      <div>
        <label class="row col-sm-12">Conclusion</label>
        <p class="row col-sm-12"> {{report.report_data.meta_data.conclusions}}  </p>
      </div>
        <div>
          <label class="row col-sm-12">Attachments</label>
          <div class="row col-sm-12">
            <button v-for="attachment in report.report_data.attachments.attachments" :key="attachment.id" class="btn-info btn-attachments" @click="downloadFile(attachment.id, attachment.filename)"> {{attachment.filename}}</button>
          </div>
        </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import '~stylesheets/variables';
.report {
  .reportDate {
    margin-left: 30px;
    margin-bottom: 20px;
  }
    .btn-attachments {
    cursor: pointer;
    padding: 20px;
    margin-right: 20px;
  }
}
</style>

<script>
export default {
  name: 'ClubReport',
  props: ['report','downloadFile'],
  data() {
    return {};
  },
};
</script>