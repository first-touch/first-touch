<template>
<transition 
  name="dialog-fade"
  @after-enter="afterEnter"
  @after-leave="afterLeave">
  <div class="ft-dialog__wrapper" v-show="visible" @click.self="handleWrapperClick">
    <div 
      ref="dialog"
      class="ft-dialog"
      role="dialog"
      aria-modal="true"
      :aria-label="title || 'dialog'"
      :style="style"
    >
      <header class="ft-dialog__header">
        <slot name="title">
          <span class="ft-dialog__title">{{ title }}</span>
        </slot>
        <button
          type="button"
          class="btn-close"
          @click="handleClose"
          aria-label="Close">
        x
        </button>
      </header>
      <section class="ft-dialog__body container">
        <slot></slot>
      </section>
      <footer class="ft-dialog__footer" v-if="$slots.footer">
        <slot name="footer"></slot>
      </footer>
    </div>
  </div>
</transition>
</template>

<script>
  import Vue from 'vue';
  
  export default {
    name: 'FTDialog',
    props: {
      visible: { type:Boolean, default: false },
      title: { type:String, default: ''},
      top: { type:String, default: '15vh'},
      width: String,
      closeOnClickModal: { type:Boolean, default: true},
      beforeClose:Function
    },
    data(){
      return {
        opened: false,
        closed: false,
        rendered: false
      }
    },
    computed: {
      style(){
        let style = {};
        style.marginTop = this.top;
        if (this.width){
          style.width = this.width;
        }
        return style;
      }
    },
    watch: {
      visible(val){
        if (val){
          this.closed = false;
          if (this._opening) return;
          if (!this.rendered){
            this.rendered = true;
            Vue.nextTick(() => {
              this.open();
            });
          } else {
            this.open();
          }
        } else {
          this.close();
        }
      }
    },
    mounted(){
      if (this.visible){
        this.rendered = true;
        this.open();
      }
    },
    methods: {
      open(){
        if (!this.rendered){
          this.rendered = true;
        }
        if (this.opened) return;
        this._opening = true;

        this.opened = true;
        this.doAfterOpen();
      },
      doAfterOpen(){
        this.$emit('open');
        this._opening = false;
      },
      close() {
        if (!this.closed) this.$emit('close');
      },
      afterEnter(){
        this.$emit('opened');
      },
      afterLeave(){
        this.$emit('closed');
      },
      handleWrapperClick() {
        if (!this.closeOnClickModal) return;
        this.handleClose();
      },
      handleClose() {
        if (typeof this.beforeClose === 'function') {
          this.beforeClose(this.hide);
        } else {
          this.hide();
        }
      },
      hide(cancel) {
        if (cancel !== false) {
          this.$emit('update:visible', false);
          this.$emit('close');
          this.closed = true;
        }
      },
    },
  };
</script>

<style lang="scss" scoped>
@import '~stylesheets/variables';

.ft-dialog__wrapper {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: rgba(0, 0, 0, 0.3);
  display: flex;
  justify-content: center;
  align-items: center;
}

.ft-dialog {
  background: #FFFFFF;
  box-shadow: $dialog-box-shadow;
  border-radius: 0;
  width: 50%;
  margin: 0 auto 50px;

  .ft-dialog__header {
    padding: $dialog-padding-primary;
    padding-bottom: 10px;

    .title {
      font-size: $dialog-title-font-size;
      color: $main-text-color;
    }
  }

  .ft-dialog__footer {
    padding: $dialog-padding-primary;
    padding-top: 10px;
    text-align: right;
    box-sizing: border-box;
  }

  .ft-dialog__body { 
    padding: 20px 10px;
    font-size: $dialog-font-size;
  }

  .btn-close {
    position: absolute;
    top: $dialog-padding-primary;
    right: $dialog-padding-primary;
    padding: 0;
    background: transparent;
    border: none;
    outline: none;
    cursor: pointer;
    font-size: 20px;
  }
}

.dialog-fade-enter-active {
  animation: dialog-fade-in .3s;
}
.dialog-fade-leave-active {
  animation: dialog-fade-out .3s;
}

@keyframes dialog-fade-in {
  0% {
    transform: translate3d(0, -20px, 0);
    opacity: 0;
  }
  100% {
    transform: translate3d(0, 0, 0);
    opacity: 1;
  }
}

@keyframes dialog-fade-out {
  0% {
    transform: translate3d(0, 0, 0);
    opacity: 1;
  }
  100% {
    transform: translate3d(0, -20px, 0);
    opacity: 0;
  }
}
</style>