<template>
  <div>
    <div class="timeline-widget">
      <div class="arrow"></div>
      <button @click="modalShow = true" class="timeline-widget-button btn-add">
        Add A Note
      </button>
      <button class="timeline-widget-button btn-create">
        Create A Category
      </button>
    </div>
    <b-modal ref="modal" id="add-modal" size="lg" centered v-model="modalShow">
      <div class="header">
        <div class="left">
        <h3 class="name">Publish a Post</h3>
        </div>
        <div class="right">
          <select class="privacy">
            <option>Private</option>
            <option>Public</option>
            <option>Custom</option>
          </select>
          <button class="btn-main">Publish</button>
          <button class="btn-sub" @click="modalShow = false">Close</button>
        </div>
      </div>
      <div class="body">
        <form class="form">
          <input class="title" placeholder="Title" required/>
          <div class="separator"></div>
          <textarea class="content" rows="7" placeholder="Content" required/>
        </form>
      </div>
    </b-modal>
  </div>
</template>
<style lang="scss" scoped>
@import '~stylesheets/variables.scss';

.timeline-widget {
  display: flex;
  border-left: 7px solid $secondary-header-color;

  .timeline-widget-button {
    color: $secondary-text-color;
    text-transform: uppercase;
    background-color: $navbar-background-color;
    border: none;
    max-width: 12vw;
    margin-right: 20px;
    &.btn-add {
      padding-left: 50px;
      background-image: url('https://cdn3.iconfinder.com/data/icons/complete-set-icons/512/photo512x512.png');
      background-repeat: no-repeat;
      background-position: left;
      background-size: contain;
    }
    &.btn-create {
      padding-left: 50px;
      background-image: url('https://cdn3.iconfinder.com/data/icons/complete-set-icons/512/photo512x512.png');
      background-repeat: no-repeat;
      background-position: left;
      background-size: contain;
    }
  }
  .arrow {
    margin-top: 18px;
    border-left-color: $secondary-header-color;
  }
}
</style>
<style lang="scss">
@import '~stylesheets/variables.scss';

#add-modal {
  color: #000;
  .modal-header,
  .modal-footer {
    display: none;
  }
  .modal-body {
    padding: 20px;
  }
  .header {
    display: flex;
    justify-content: space-between;
    .left {
      .name {
        text-transform: uppercase;
        color: #000;
      }
    }
    .right {
      .privacy,
      .btn-main,
      .btn-sub {
        height: 30px;
        line-height: 20px;
        border-radius: 4px;
        border: 1px solid $main-text-color;
        margin-left: 10px;
        color: $main-text-color;
      }
      .btn-main {
        background: $main-header-color;
        border: 1px solid $main-header-color;
        color: #fff;
      }
    }
  }
  .body {
    .form {
      display: flex;
      flex-direction: column;
      .title,
      .content {
        border: none;
        padding: 10px 0;
        &:focus {
          border: none;
          box-shadow: none;
          outline: none;
        }
      }
      .title {
        font-size: 2rem;
      }
      .content {
        font-size: 1.2rem;
      }
      .separator:before {
        content: '';
        position: absolute;
        margin-top: -2px;
        width: 10%;
        border-top: 1px solid $main-text-color;
      }
    }
  }
}
</style>

<script>
export default {
  name: 'NoteWidget',
  data() {
    return {
      modalShow: false,
    };
  },
};
</script>
