<template>
  <div>
    <span>{{ item.name }}</span>
    <abbr>{{ item.city }}</abbr>
  </div>
</template>
<script>
  export default {
    props: {
      item: {
        required: true
      },
      searchText: {
        required: true
      },
    },
  };
</script>
