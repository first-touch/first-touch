<template>
  <div>
    <div class="timeline-widget">
      <div class="arrow"></div>
      <div class="timeline-widget-button">
        <b-btn v-b-toggle.post-text>
          <div class="row">
            <div class="col no-padding">
              <img src="https://cdn3.iconfinder.com/data/icons/complete-set-icons/512/photo512x512.png">
            </div>
            <div class="col">
              Publish a
              <br> new post
            </div>
          </div>
        </b-btn>
      </div>
      <div class="timeline-widget-button">
        <b-btn v-b-toggle.post-media>
          <div class="row">
            <div class="col no-padding">
              <img src="https://cdn3.iconfinder.com/data/icons/complete-set-icons/512/photo512x512.png">
            </div>
            <div class="col">
              Upload
              <br> a photo
            </div>
          </div>
        </b-btn>
      </div>
    </div>
    <b-collapse id="post-text" accordion="post-upload">
      <b-card>
        <div class="container">
          <form @submit.prevent="handleSubmit">
            <fieldset class="form-group">
              <textarea :value="content" @keyup="handleContentChange" class="form-control" rows="4" placeholder="Share a thought, link or opinion"></textarea>
            </fieldset>
            <div class="row justify-content-end">
              <button v-if="posting" type="button" class="bar-button" disabled>Posting...</button>
              <button v-else type="submit" class="bar-button">Post</button>
            </div>
          </form>
        </div>
      </b-card>
    </b-collapse>
    <b-collapse id="post-media" accordion="post-upload">
      <b-card>
        <div class="container">
          <form ref="fileform" @submit.prevent="handleSubmit">
            <fieldset class="form-group form-control">
              <span class="drop-files">
                <b-form-file id="input" :value="content" @change="browsedFiles" placeholder="Drop files here or Browse Files here..."
                  multiple></b-form-file>
                <br> OR Drop files here...
              </span>
              <div class="files-uploaded">
                <div v-for="(file, key) in files" class="file-listing">
                  <div class="remove-container">
                    <a class="remove" v-on:click="removeFile( key )"><img src="/images/cancel.png"></a>
                  </div>
                  <div class="images-uploaded">
                    <img class="preview" v-bind:ref="'preview'+parseInt( key )" /> {{ file.name }}
                  </div>
                </div>
              </div>
            </fieldset>

            <div class="row justify-content-end">
              <button v-if="posting" type="button" class="bar-button" disabled>Posting...</button>
              <button v-else type="submit" class="bar-button">Post</button>
            </div>
          </form>
        </div>
      </b-card>
    </b-collapse>

  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables.scss';

  .timeline-widget {
    display: flex;
    border-left: 7px solid $secondary-header-color;

    .timeline-widget-button {
      .btn-secondary {
        border: none; // max-width: 12vw;
        margin-right: 20px;
        margin-bottom: 20px;
        color: $secondary-text-color;
        text-transform: uppercase;
        background-color: $navbar-background-color;
        text-align: left;
      }

      .btn-text-title {
        margin-top: 10px;
      }

      img {
        height: 50px;
      }
    }

    .arrow {
      margin-top: 18px;
      border-left-color: $secondary-header-color;
    }
  }

  #post-text,
  #post-media {
    border-left: 7px solid $secondary-header-color;
    padding-left: 20px;

    textarea {
      border: none;
      color: #7F8081;
    }

    .bar-button {
      border: none;
      box-shadow: none;
      background: #B3CB75;
      width: 200px;
    }
  }

  .form-control {
    border: none;
  }

  #post-media {
    .files-uploaded {
      .file-listing {
        margin-top: 25px;

        .images-uploaded {
          padding-top: 7px;
          padding-left: 10px;

          img {
            height: 100px;
            margin: 5px;
          }
        }

        .remove-container {
          .remove {
            position: absolute;
            cursor: pointer;

            img {
              height: 20px;
            }
          }
        }
      }
    }

  }
</style>

<script>
  export default {
    name: 'PostWidget',
    props: ['posting', 'handleContentChange', 'handleSubmit', 'content'],
    data() {
      return {
        dragAndDropCapable: false,
        files: [],
        uploadPercentage: 0,
      };
    },
    methods: {
      browsedFiles() {
        var inputElement = document.getElementById("input");
        inputElement.addEventListener("change", handleFiles, false);

        function handleFiles() {
          var fileList = this.files;
          for (var i = 0; i < fileList.length; i++) {
            console.log(fileList[i]);
            return fileList[i];
            debugger;
          }
        }
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
      // submitFiles() {
      //   let formData = new FormData();
      //   for (var i = 0; i < this.files.length; i++) {
      //     let file = this.files[i];

      //     formData.append('files[' + i + ']', file);
      //   }
      //   axios.post('/post-media',
      //       formData, {
      //         headers: {
      //           'Content-Type': 'multipart/form-data'
      //         },
      //         onUploadProgress: function (progressEvent) {
      //           this.uploadPercentage = parseInt(Math.round((progressEvent.loaded * 100) / progressEvent.total));
      //         }.bind(this)
      //       }
      //     ).then(function () {
      //       console.log('SUCCESS!!');
      //     })
      //     .catch(function () {
      //       console.log('FAILURE!!');
      //     });
      // },
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
