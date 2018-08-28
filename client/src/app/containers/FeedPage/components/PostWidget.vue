<template>
  <div>
    <div class="timeline-widget">
      <div class="arrow"></div>
      <button class="timeline-widget-button" @click="toggleWrite">
        <button class="btn-png"></button>
        <span class="btn-text">
          publish a new post
        </span>
      </button>
      <button class="timeline-widget-button" @click="toggleUpload">
        <button class="btn-png"></button>
        <span class="btn-text">
          upload a picture
        </span>
      </button>
    </div>

    <div id="file-drag-drop" class="timeline-widget media" :class="{ active }">
      <div class="item-container">
        <form ref="fileform" @submit.prevent="handleSubmit">
          <fieldset class="form-group form-control" rows="4">
            <span class="drop-files">
              <b-form-file :value="content" @keyup="handleContentChange" placeholder="Browse for files..."></b-form-file>
              <br> OR Drop files here...
            </span>
            <div class="files-uploaded">
              <div v-for="(file, key) in files" class="file-listing">
                <img class="preview" v-bind:ref="'preview'+parseInt( key )" /> {{ file.name }}
                <div class="remove-container">
                  <a class="remove" v-on:click="removeFile( key )">Remove</a>
                </div>
              </div>
            </div>

          </fieldset>

          <button v-if="posting" type="button" class="bar-button" disabled>Posting...</button>
          <button v-else-if="files.length > 0" v-on:click="submitFiles()" type="submit" class="bar-button">Post</button>
        </form>
      </div>
    </div>

    <div class="timeline-widget writer" :class="{ active }" v-if="writePost">
      <div class="item-container">
        <form @submit.prevent="handleSubmit">
          <fieldset class="form-group">
            <textarea :value="content" @keyup="handleContentChange" class="form-control" rows="4" placeholder="What's on your mind?"></textarea>
          </fieldset>
          <button v-if="posting" type="button" class="bar-button" disabled>Posting...</button>
          <button v-else type="submit" class="bar-button">Post</button>
        </form>
      </div>
    </div>


  </div>
</template>
<style lang="scss" scoped>
  @import '~stylesheets/variables.scss';
  .timeline-widget {
    display: flex;
    border-left: 7px solid $secondary-header-color;
    .item-container {
      padding: 10px 20px 0;
      width: 100%;
      &.active {
        height: auto;
      }
    }
    .timeline-widget-button {
      background-color: $navbar-background-color;
      border: none;
      margin-right: 20px;
      .btn-png {
        box-sizing: content-box;
        width: 33px;
        height: 40px;
        background-color: $navbar-background-color;
        border: none;
        background-image: url('https://cdn3.iconfinder.com/data/icons/complete-set-icons/512/photo512x512.png');
        background-repeat: no-repeat;
        background-position: left;
        background-size: contain;
      }
      .btn-text {
        box-sizing: content-box;
        max-width: 6vw;
        color: $secondary-text-color;
        text-transform: uppercase;
        text-align: left;
        float: right;
      }
    }
    .arrow {
      margin-top: 18px;
      border-left-color: $secondary-header-color;
    }
    &.writer {
      overflow: hidden;
      transition: height 1s;
    }
    &.media {
      fieldset {
        background: #fff;
        min-height: 200px;
      }
      .drop-files {
        padding: 20px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        color: #7F8081;
      }
      .files-uploaded {
        display: flex;
        flex-direction: row;
        width: 100%;
        overflow: auto;
      }
      .file-listing {
        padding: 10px;
        display: flex;
        flex-direction: column;
        width: 200px;
      }
      .file-listing img {
        height: 100px;
        width: 150px;
      }
      .remove-container a {
        color: red;
        cursor: pointer;
      }
    }
  }

  .w-100 {
    width: 25% !important;
  }
</style>

<script>
  export default {
    name: 'PostWidget',
    props: ['posting', 'handleContentChange', 'handleSubmit', 'content'],
    data() {
      return {
        active: false,
        writePost: false,
        mediaPost: false,
        dragAndDropCapable: false,
        files: [],
        uploadPercentage: 0,
      };
    },
    methods: {
      toggleWrite() {
        this.$set(this, 'active', true);
        this.$set(this, 'writePost', !this.writePost);
        this.$set(this, 'mediaPost', false);
      },
      toggleUpload() {
        this.$set(this, 'active', true);
        this.$set(this, 'mediaPost', !this.mediaPost);
        this.$set(this, 'writePost', false);
      },
      determineDragAndDropCapable() {
        var div = document.createElement('div');
        return (('draggable' in div) ||
            ('ondragstart' in div && 'ondrop' in div)) &&
          'FormData' in window &&
          'FileReader' in window;
      },
      getImagePreviews() {
        for (let i = 0; i < this.files.length; i++) {
          if (/\.(jpe?g|png|gif)$/i.test(this.files[i].name)) {
            let reader = new FileReader();
            reader.addEventListener("load", function () {
              this.$refs['preview' + parseInt(i)][0].src = reader.result;
            }.bind(this), false);
            reader.readAsDataURL(this.files[i]);
          } else {
            this.$nextTick(function () {
              this.$refs['preview' + parseInt(i)][0].src = '/images/file.png';
            });
          }
        }
      },
      submitFiles() {
        let formData = new FormData();
        for (var i = 0; i < this.files.length; i++) {
          let file = this.files[i];

          formData.append('files[' + i + ']', file);
        }
        axios.post('/file-drag-drop',
            formData, {
              headers: {
                'Content-Type': 'multipart/form-data'
              },
              onUploadProgress: function (progressEvent) {
                this.uploadPercentage = parseInt(Math.round((progressEvent.loaded * 100) / progressEvent.total));
              }.bind(this)
            }
          ).then(function () {
            console.log('SUCCESS!!');
          })
          .catch(function () {
            console.log('FAILURE!!');
          });
      },
      removeFile(key) {
        this.files.splice(key, 1);
      },
    },
    mounted() {
      this.dragAndDropCapable = this.determineDragAndDropCapable();
      if (this.dragAndDropCapable) {
        ['drag', 'dragstart', 'dragend', 'dragover', 'dragenter', 'dragleave', 'drop'].forEach(function (evt) {
          this.$refs.fileform.addEventListener(evt, function (e) {
            e.preventDefault();
            e.stopPropagation();
          }.bind(this), false);
        }.bind(this));
        this.$refs.fileform.addEventListener('drop', function (e) {
          for (let i = 0; i < e.dataTransfer.files.length; i++) {
            this.files.push(e.dataTransfer.files[i]);
            this.getImagePreviews();
          }
        }.bind(this));
      }
    },

  };
</script>
