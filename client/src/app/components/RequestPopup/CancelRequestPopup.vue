<template>
  <div class="wrapper ft-item">
    <div class="header-wrapper col-lg-12">
      <div class="header col-lg-12 row">
        <div class="col-lg-4 header-title">
          <h5 class="title">Cancel Report Request</h5>
          <p class="id">{{request.id | requestId(request.type_request) }}</p>
        </div>
        <div class="col-lg-8 buttons-inner">
          <button class="ft-button ft-button-right" @click="closeAction(request)">Close
            <span v-if="success">✓</span>
          </button>
        </div>
      </div>
    </div>
    <div class="content-wrapper">
      <div class="content col-lg-12">
        <p v-if="loading">Please wait...</p>
        <div class="img-container">
          <img class="img-fluid avatar" src="/images/landing-page/ft-icons-player.png" />
          <p class="price" v-if="!position">
            <span>Bid Price {{request.bid_price.value}} {{request.bid_price.currency | currency}}</span>
          </p>
        </div>
        <div class="info col-lg-8" v-if="!success">
          <div v-if="errors">
            <ul class="error">
              <li v-for="error in errors.errors" :key="error.id" v-if="errors.errors.isArray">
                {{error}}
              </li>
              <li v-if="!errors.errors.isArray">
                {{errors.errors}}
              </li>
            </ul>
          </div>
          <div class="row col-lg-12" v-if="!position">
            <label class="col-lg-12">Cancelation Reason</label>
            <textarea class="col-lg-12" v-model="reason"></textarea>
          </div>
          <div class="row col-lg-12" v-if="!position">
            <label class="col-lg-12">Attachments</label>
            <input type="file" multiple ref="myFiles">
          </div>
          <hr/>
          <div class="col-lg-12 buttons-inner">
            <button class="ft-button ft-button-right" @click="cancel">Cancel Report</button>
          </div>
        </div>
        <div v-if="success">
          <h3 v-if="!position">
            Bid Canceled
          </h3>
          <h3 v-if="position">
            Removed from job list
          </h3>
        </div>
      </div>
    </div>
  </div>
</template>
<style lang="scss">
  @import '~stylesheets/variables';
</style>

<style lang="scss" scoped>
  @import '~stylesheets/item';
</style>
<script>
  import countrydata from 'country-data';
  import {
    ASYNC_SUCCESS,
    ASYNC_LOADING
  } from 'app/constants/AsyncStatus';
  export default {
    name: 'CancelRequestPopup',
    props: ['request', 'closeAction', 'cancelReport', 'bid', 'filesUpload', 'uploadFiles'],
    data() {
      return {
        reason: '',
        start: false,
        filesComplete: false
      };
    },
    computed: {
      loading() {
        if (this.filesUpload.status == ASYNC_LOADING || this.bid.status == ASYNC_LOADING)
          return true;
        return false;
      },
      position() {
        if (this.request.type_request == 'position')
          return true;
        return false;
      },
      errors() {
        if (this.bid.errors) return this.bid.errors;
        return null;
      },
      bidSuccess() {
        return this.bid.status == ASYNC_SUCCESS && this.start;
      },
      success() {
        return this.bidSuccess && this.filesComplete
      }
    },
    watch: {
      bidSuccess() {
        if (this.bidSuccess && !this.filesComplete) {
          var fileList = this.$refs.myFiles.files;
          if (fileList.length > 0) {
            this.startUpload();
          } else {
            this.filesComplete = true;
          }
        }
      },
      filesUpload() {
        if (this.filesUpload.status === ASYNC_SUCCESS) {
          this.filesComplete = true;
        }
      }
    },
    methods: {
      cancel() {
        this.start = true;
        this.cancelReport({
          reason: this.reason
        })
      },
      startUpload() {
        var formData = new FormData();
        var fileList = this.$refs.myFiles.files;
        var i = 0;
        $.each(fileList, function (index, value) {
          formData.append('files[' + i + ']', value);
          i++;
        });
        formData.append('job_id', this.request.id);
        this.uploadFiles(formData);
      },
    }
  };
</script>
