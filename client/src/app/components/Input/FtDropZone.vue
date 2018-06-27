<template>
  <form class="dropzone">
    <div id="dropzone-message" style="display: none">
      <div class="dropzone-title">
        <span class="arrow-up dropzone-info">
          <icon name="arrow-up" scale="2" />
        </span>
      </div>
      <span class="dropzone-info">Drag files to upload</span>
    </div>
  </form>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .dropzone {
    width: 100%;
    border: 0;
    padding: 10px;
    background-image: linear-gradient(to right, $secondary-text-color 50%, transparent 50%), linear-gradient(to right, $secondary-text-color 50%, transparent 50%), linear-gradient(to bottom, $secondary-text-color 50%, transparent 50%), linear-gradient(to bottom, $secondary-text-color 50%, transparent 50%);
    background-position: left top, left bottom, left top, right top;
    background-repeat: repeat-x, repeat-x, repeat-y, repeat-y;
    background-size: 20px 3px, 20px 3px, 3px 20px, 3px 20px;

    .dropzone-title {
      height: 60px;

    }
    .arrow-up {
      color: $main-header-color;
      border: 3px solid $main-header-color;
      padding: 20px;
      border-radius: 10px;
      .fa-icon {
        position: relative;
        top: 10px;
      }
    }
  }
</style>

<script>
  import Dropzone from 'dropzone'
  import '../../../../node_modules/dropzone/dist/dropzone.css'
  import 'vue-awesome/icons/arrow-up';
  import Icon from 'vue-awesome/components/Icon';
  import {
    mapGetters,
    mapActions
  } from 'vuex';
  // import lambda from '../lambda'

  Dropzone.autoDiscover = false

  export default {
    name: 'dropzone',
    components: {
      icon: Icon
    },
    data() {
      return {
        complete: []
      }
    },
    mounted() {
      const vm = this
      let options = {
        url: '/',
        method: 'put',
        sending(file, xhr) {
          let _send = xhr.send
          xhr.send = () => {
            _send.call(xhr, file)
          }
        },
        parallelUploads: 1,
        uploadMultiple: false,
        header: '',
        dictDefaultMessage: document.querySelector('#dropzone-message').innerHTML,
        autoProcessQueue: false,
        accept: vm.accept
      }
      this.dropzone = new Dropzone(this.$el, options)
      vm.dropzone.on('processing', (file) => {
        vm.dropzone.options.url = file.uploadURL
      })
      vm.dropzone.on('success', (file) => {
        vm.$emit('change');
      })
    },
    methods: {
      ...mapActions(['getSignedUrl']),
      accept(file, done) {
        this.getSignedUrl(file)
          .then((url) => {
            file.uploadURL = url.presigned_url;
            done()
            setTimeout(() => this.dropzone.processFile(file))
            this.complete.push({
              filename: file.name,
              url: url.public_url
            })
          })
          .catch((err) => {
            done('Failed to get an S3 signed upload URL', err)
          })
      }
    }
  }
</script>
