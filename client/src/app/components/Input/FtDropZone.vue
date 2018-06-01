<template>
  <div>
    <dropzone ref="myVueDropzone" id="dropzone" v-on:vdropzone-sending="sendingEvent" v-on:vdropzone-s3-upload-error="s3UploadError"
      v-on:vdropzone-s3-upload-success="s3UploadSuccess" :options="dropzoneOptions" />
    <button @click="uploadFiles">Upload Files</button>

  </div>
</template>
@vdropzone-file-added="vfileAdded" @vdropzone-success="vsuccess" @vdropzone-error="verror" @vdropzone-removed-file="vremoved"
@vdropzone-sending="vsending" @vdropzone-success-multiple="vsuccessMuliple" @vdropzone-sending-multiple="vsendingMuliple"
@vdropzone-queue-complete="vqueueComplete" @vdropzone-total-upload-progress="vprogress" @vdropzone-mounted="vmounted" @vdropzone-drop="vddrop"
@vdropzone-drag-start="vdstart" @vdropzone-drag-end="vdend" @vdropzone-drag-enter="vdenter" @vdropzone-drag-over="vdover"
@vdropzone-drag-leave="vdleave"
<script>
  import DropZone from 'vue2-dropzone';

  export default {
    name: 'FtDropZone',
    components: {
      dropzone: DropZone
    },
    data() {
      return {
        awss3: {
          signingURL: 'http://aws-direct-s3.dev/',
          headers: {},
          params: {},
          sendFileToServer: true
        },
        dropzoneOptions: {
          url: 'http://first-touch.s3-ap-southeast-1.amazonaws.com/',
          thumbnailWidth: 150,
          maxFilesize: 10,
          headers: {
            "My-Awesome-Header": "header value"
          },
          params: {
            key: ''
          },
          addRemoveLinks: true,
          autoProcessQueue: true,
          accept(file, done) {
            done();
          },
        },
      }
    },
    methods: {
      sendingEvent(file, xhr, formData) {
        formData.append('paramName', 'some value or other');
      },
      s3UploadError(error) {
        console.log(error)
      },
      s3UploadSuccess(location) {
        console.log(location)
      },
      uploadFiles() {
        this.$refs.myVueDropzone.setAWSSigningURL(this.signurl);

        // if (this.signurl) {
        //   this.$refs.myVueDropzone.setAWSSigningURL(this.signurl);
        //   this.$refs.myVueDropzone.processQueue();
        // } else {
        //   alert("Enter your signing URL");
        // }
      }
    }
  }
</script>
