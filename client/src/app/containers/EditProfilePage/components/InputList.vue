<template>
<div class="input-list">
  <div  v-for="(element, index) in elements"
        :key="index"
        class="input-list__element mb-2">
      <span>{{ index + 1 }}.</span>
      <span>{{ element }}</span>
      <span class="input-list__btn-delete" @click="removeElement(index)"> x </span>
  </div>
  <div class="input-list__add">
    <button ref="entrybtn" type="button"
            class="input-list__btn-add btn btn-secondary"
            v-show="!editMode"
            @click="enableInput"> + New Entry</button>
    <div class="input-list__add-input" v-show="editMode">
      <input ref="inputbox" type="text" v-model="newElement" @keydown.enter.stop.prevent="saveEntry"/>
      <button type="button" @click="saveEntry">Add</button>
    </div>
  </div>
</div>
</template>

<script>
export default {
  props: {
    value: { type: Array, required: true }
  },
  data() {
    return {
      elements: [],
      newElement: "",
      editMode: false
    }
  },
  watch: {
    value: {
      immediate: true,
      handler: function(to){
        this.elements = to;
      }
    }
  },
  methods: {
    removeElement(idx){
      this.elements.splice(idx, 1);
      this.$emit('input', this.elements);
    },
    enableInput(){
      this.editMode = true;

      this.$nextTick(() => {
        this.$refs.inputbox.focus();
      })
    },

    saveEntry(){
      if (this.newElement != ""){
        this.elements.push(this.newElement);
        this.newElement = "";

        this.$emit('input', this.elements);
      }
      this.editMode = false;

      this.$nextTick(() => {
        this.$refs.entrybtn.focus();
      })
    }
  }
}
</script>

<style lang="scss" scoped>

.input-list__btn-delete {
  display: inline-block;
  border: 1px solid grey;
  border-radius: 50px;
  width: 17px;
  height: 17px;
  text-align: center;
  font-size: 10px;
  cursor: pointer;

  &:hover {
    background: grey;
    color: white;
  }
}
</style>
