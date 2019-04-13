<template>
<div class="avatar__wrap rounded-circle" :class="{ 'editor': isEditor, 'no-avatar': src=='' }">
  <div class="image" :style="imageStyle" />
  <div class="edit-overlay" v-if="isEditor">
    <div class="text-center">
      <v-icon name="camera" scale="3" class="icon" />
      <span v-if="src == ''"> No Avatar is set</span>
    </div>
  </div>
  <input type="file"
          id="avatar"
          name="avatar"
              accept="image/*"
              @change="fileSelected($event.target.files)"
              class="input-file"
            />
</div>
</template>

<script>
import 'vue-awesome/icons/camera';
import 'vue-awesome/icons/user-circle';
import VIcon from 'vue-awesome/components/Icon'

export default {
  name:"user-avatar",
  components: {
    VIcon
  },
  props: {
    src: { type: String, required: true },
    isEditor: { type: Boolean, default: false }
  },
  computed: {
    imageStyle() {
      return {
        backgroundImage: `url(${this.src})`
      }
    }
  },
  methods: {
    fileSelected(files){
      this.$emit('upload', files);
    }
  }
}
</script>

<style lang="scss" scoped>
.avatar__wrap {
  position: relative;
  overflow: hidden;
  width: 100%;
  padding-top: 100%;
  box-shadow: 0 3px 5px rgba(0,0,0, 0.3);
  cursor: pointer;

  .no-image,
  .input-file,
  .edit-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    opacity: 0;
    border: 0;
    cursor: pointer;
  }

  .edit-overlay {
    background: rgba(255, 255, 255, 0.5);
    transition: opacity 0.5s ease;

    display: flex;
    align-items: center;
    justify-content: center;

    .icon {
      fill: rgba(255, 255, 255, 0.9)
    }
  }

  &.no-avatar .edit-overlay,
  &.editor:hover .edit-overlay {
    opacity: 1;
  }

  &.no-avatar .edit-overlay {
    .icon {
      fill: unset;
      display: block;
      margin: 0 auto;
    }
  }

  .image {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;

    background-size: cover;
    background-position: center center;
  }
}

</style>

