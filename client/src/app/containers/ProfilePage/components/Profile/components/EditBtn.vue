<template>
  <router-link :to="to" class="btn">
    <img class="img-fluid" src="/images/edit.svg" alt="Edit Button"/>
  </router-link>
</template>
<style lang="scss" scoped>
.btn {
  position: absolute;
  top: 0;
  right: 0;
  border-radius: 50%;
  height: 40px;
  width: 40px;
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  .img-fluid {
    height: 20px;
    width: 20px;
  }
}
</style>
<script>
export default {
  name: 'EditBtn',
  props: ['to']
}
</script>


