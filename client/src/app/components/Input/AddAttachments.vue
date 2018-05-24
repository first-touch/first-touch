<template>
  <div class="form-group row ft-input">
    <div class="form-group row attachments-div col-md-6">
      <label class="col-md-12 col-form-label">Add Attachments:
        <input type="file" name="files" ref="myFiles" @change="update" multiple class="col-md-4">
      </label>
      <div class="col-md-12">
        <ul class="col-md-6">
          <li class="list" v-for="file in files" :key="file.id"> {{file.name}} </li>
        </ul>
      </div>
    </div>
    <div v-if="attachments" class="form-group row col-md-6">
      <label class="col-sm-12">Current Attachments</label>
      <div class="update-attachments col col-sm-12" v-for="attachment in attachments" :key="attachment.id">
        <div class="col col-sm-12 file" :class="remove_attachment[attachment.id]?'removed':'remove'" @click="removeAttachment(attachment.id)">
          <p>{{attachment.filename}}</p>
          <p class="col col-sm-2">
            <icon name='trash'></icon>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  @import '~stylesheets/variables';

  .row {
    color: $main-text-color;
    .attachments-div {
      ul {
        li {
          display: list-item;
          list-style: disc;
        }
      }
    }
    .update-attachments {
      color: $main-text-color;
      .file {
        cursor: pointer;
        &.removed {
          p {
            text-decoration: line-through;
            color: red;
          }
          .fa-icon {
            color: green;
          }
        }
        &.remove {
          .fa-icon {
            color: red;
          }
        }
        p {
          display: inline-block;
        }
      }
    }
  }
</style>

<script>
  import 'vue-awesome/icons/trash';
  import Icon from 'vue-awesome/components/Icon';
  export default {
    name: 'files',
    props: ['attachments'],
    components: {
      icon: Icon
    },
    data() {
      return {
        remove_attachment: {},
        files: []
      };
    },
    methods: {
      update() {
        this.files = this.$refs.myFiles.files;
        this.$emit('update:remove', this.remove_attachment);
        this.$emit('update:files', this.files);
      },
      removeAttachment(id) {
        var obj = this.remove_attachment;
        if (this.remove_attachment[id] === true) delete obj[id];
        else {
          obj[id] = true;
        }
        this.remove_attachment = Object.assign({}, obj);
        this.update();
      }
    }
  };
</script>
