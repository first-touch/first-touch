<template>
  <div class="Loading" >
    <p v-if="status == 'reportUploading' ">
      Creating Report
    </p>
    <p v-if="status == 'filesUploading' ">
      Uploading Files
    </p>
    <p v-if="status == 'filesUploadingFailure' ">
      Your files failed to be uploaded, you will be redirect to the edit page, please try again
    </p>
    <p v-if="status == 'reportUploadingFailure' ">
      Your Report Failed Please try again or contact an administrator
    </p>
  </div>
</template>

<style lang="scss" scoped>
.Loading {
  color: black;
  text-align: center;
  font-size: 20px;
}
</style>

<script>
export default {
  name: 'CreateReportPage',
  props: ['status']
};
</script>