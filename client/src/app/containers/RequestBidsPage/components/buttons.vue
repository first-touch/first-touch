<template>
  <div class="buttons-inner">
    <button class="ft-button ft-button-right ft-button-secondary" @click="toEdit">Edit</button>
    <div class="more col-lg-1">
      <icon name="ellipsis-v"></icon>
      <div class="action">
        <div class="content">
          <a v-if="status == 'publish'" @click="updateStatus('private')">
            Unpublish
          </a>
          <a v-if="status == 'private'" @click="updateStatus('publish')">
            Publish
          </a>
          <a @click="updateStatus('deleted')">
            Delete
          </a>
        </div>
        <span class="down-arrow"></span>
      </div>
    </div>
  </div>
</template>

<script>
  import 'vue-awesome/icons/ellipsis-v';
  import 'vue-awesome/icons/exclamation-triangle';
  import Icon from 'vue-awesome/components/Icon';
  export default {
    name: 'RequestButtons',
    props: ['updateStatus', 'toEdit', 'status'],
    components: {
      icon: Icon,
    },
  }
</script>
